//字典树形控件
var dictTree;


// 字典数据表格列数据映射
var columnsConfig = [
    { data : 'uuid' },
    { data : 'parentId' },
    { data : 'dictDataCode' },
    { data : 'dictDataName' },
    { data : 'sortNum' },
    { data : 'dataState',
    render : function(data, type, row, meta) {
        if (data == "1") {
            return "有效";
        } else if (data == "2") {
            return "无效";
        }
    } } ];


// 字典数据表格列样式设置,通过targets设置范围可对多列生效
var columnDefsConfig = [
    { "targets" : [ 0 ],
    // 不可搜索
    "searchable" : false },
    { "targets" : [ 0, 1 ],
    // 隐藏列 targets可同时设置多列
    "visible" : false } ];


// 页面初始化块
$(function() {

    // 加载字典树形控件的数据
    getDictList();
    // 初始化表格显示
    $("#data_table").DataTable($.extend(true, {}, TABLE_OPTION_2,
        { "columnDefs" : columnDefsConfig }));
});


/**
 * 初始化字典数据项表格
 * 
 * @returns
 */
function initDictDataTable() {
    var para = {};
    para.dictId = dictTree.getSelectedItemId();
    if (para.dictId == null || para.dictId == "") {
        layer.warning("请先选择字典树,确定数据项所属的字典!");
        return false;
    }
    layer.load(2);
    $.ajax(
        { url : "dict/getdictdatalist",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                $("#data_table").DataTable($.extend(true, {}, TABLE_OPTION_2,
                    { data : data.objList,
                    columns : columnsConfig,
                    columnDefs : columnDefsConfig }));
            }
        },
        complete : function(XMLHttpRequest, textStatus) {
            layer.closeAll('loading');
        } });
}


/**
 * 选中树 调用的方法
 * 
 * @param id
 * @returns
 */
function onTreeSelect(id) {

    initDictDataTable();
}


/**
 * 获取字典列表并填充树形控件
 * 
 * @returns
 */
function getDictList() {
    layer.load(2);
    $.ajax(
        { url : "dict/getlist",
        success : function(data) {
            if (data.success == true) {
                var dictList = data.objList;
                for (var i = 0; i < dictList.length; i++) {
                    dictList[i].text = dictList[i].dictCode + " " + dictList[i].dictName;
                }
                var jsonObj = getTreeJsonObj(dictList, "", "parentId", "uuid", "text");
                if (dictTree != undefined) {
                    // 销毁树
                    dictTree.destructor();
                }
                dictTree = getTreeObject("data_tree", jsonObj, true, false, false);
                dictTree.parse(jsonObj, "json");
                
                // 绑定事件
                dictTree.attachEvent("onSelect", function(id) {
                    onTreeSelect(id);
                });
            }
        },
        complete : function(XMLHttpRequest, textStatus) {
            layer.closeAll('loading');
        } });
}


// 刷新字典按钮点击事件
$("#btn_refresh_dict").click(function() {
    $.ajax(
        { url : "authentication/logout",
        success : function(data) {
            if (data.success == true) {
                //TODO 待实现
            }
        } });
})


// 新增字典按钮点击事件
$("#btn_insert_dict").click(function() {
    // 初始化表单
    $("#data_form")[0].reset();
    // 回复字典编码控件状态
    $("#dictCode").attr("readonly", false);
    // 字典状态默认值 有效
    $("input[name=dataState]:eq(0)").iCheck('check');
    // 设置控件获得焦点
    $("#dictCode").focus();
    $("#dictuuid").val("");
    //显示表单
    showForm("新增字典信息", $('#data_form'));
})


// 修改字典按钮点击事件
$("#btn_update_dict").click(function() {
    var para = {};
    // 获得选中的节点ID
    para.uuid = dictTree.getSelectedItemId();
    if (para.uuid == null || para.uuid == "") {
        layer.warning("请选择要修改的数据！");
        return;
    }
    $.ajax(
        { url : "dict/getdictbyid",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                // 初始化表单
                $("#data_form")[0].reset();
                // 回显字段信息
                $("#dictuuid").val(data.obj.uuid);
                $("#dictCode").val(data.obj.dictCode);
                $("#dictName").val(data.obj.dictName);
                $("input:radio[name=dataState][value='" + data.obj.dataState + "']").iCheck('check');
                // 禁止修改字典编码
                $("#dictCode").attr("readonly", true);
                //显示表单
                showForm("修改字典信息", $('#data_form'));
            }
        } });
})


// 保存字典按钮点击事件
$("#btn_save_dict").click(function() {

    // 表单校验
    var msg = "";
    if ($('#dictCode').val() == "") {
        msg += "请输入字典编码!" + "  \n";
    }
    if (!(/CD_[0-9]{3}/).test($('#dictCode').val())) {
        msg += "字典编码格式错误!" + "  \n";
    }
    if ($('#dictName').val() == "") {
        msg += " 请输入字典名称!" + "  \n";
    }
    if (!$("input[name=dataState]").is(':checked')) {
        msg += " 请输入字典状态!" + "  \n";
    }
    if (msg != "") {
        layer.warning(msg);
        return;
    }
    $.ajax(
        { url : "dict/save",
        data : $("#data_form").formToJsonString(),
        success : function(data) {
            if (data.success == true) {
                getDictList();
                layer.closeAll('page');
                layer.info("保存成功！");
            } else if (data.errorList.length > 0) {
                layer.error(getErrString(data.errorList));
            }
        }});
})


// 删除字典按钮点击事件
$("#btn_delete_dict").click(function() {
    if (dictTree.getSelectedItemId() == null) {
        layer.warning("请选择要删除的数据！");
        return;
    }
    showConfirm("是否要删除该字典?", deleteRole, dictTree.getSelectedItemId());
})


//删除字典
function deleteDict(id) {
    var para = {};
    // 获得选中的节点ID
    para.uuid = id;
    $.ajax(
        { url : "dict/deletebyid",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                getDictList();
                layer.info("删除成功！");
            }
        } });
}


// 刷新字典数据项按钮点击事件
$("#btn_refresh_dict_data").click(function() {
    // 加载字典数据表格的数据
    initDictDataTable();
})


// 新增字典数据项按钮点击事件
$("#btn_insert_dict_data").click(function() {
    // 获得选中的节点ID
    var dict_id = dictTree.getSelectedItemId();
    if (dict_id == null || dict_id == "") {
        layer.warning("请先选择字典树,确定数据项所属的字典!");
        return;
    }
    // 初始化表单
    $("#data_form_1")[0].reset();
    // 设置数据项ID
    $("#uuid").val("");
    // 设置数据项所属父级字典ID
    $("#parentId").val(dict_id);
    // 字典状态默认值 有效
    $("#data_form_1 :radio[name=dataState]:eq(0)").iCheck('check');
    // 设置控件获得焦点
    $("#dictDataCode").focus();
    // 显示表单
    showForm("新增字典数据项信息", $('#data_form_1'));
})


// 编辑字典数据项按钮点击事件
$("#btn_update_dict_data").click(function() {

    // 判断是否选中字典树
    var dict_id = dictTree.getSelectedItemId();
    if (dict_id == null || dict_id == "") {
        layer.warning("请先选择字典树,确定数据项所属的字典!");
        return;
    }

    var table = $("#data_table").DataTable();
    var data = table.row(
        { selected : true }).data();
    if (data == null || data == undefined) {
        layer.warning("请选择要修改的数据！");
        return;
    }
    var para = {};
    para.uuid = data.uuid;

    $.ajax(
        { url : "dict/getdictdatabyid",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                // 初始化表单
                $("#data_form_1")[0].reset();
                $("#uuid").val(data.obj.uuid);
                $("#parentId").val(data.obj.parentId);
                $("#dictDataCode").val(data.obj.dictDataCode);
                $("#dictDataName").val(data.obj.dictDataName);
                $("#sortNum").val(data.obj.sortNum);
                $("input:radio[name=dataState][value='" + data.obj.dataState + "']").iCheck('check');
                // 显示表单
                showForm("修改字典数据项信息", $('#data_form_1'));
            }
        }});

})


// 删除字典数据项按钮点击事件
$("#btn_delete_dict_data").click(function() {

    // 判断是否选中字典树
    var dict_id = dictTree.getSelectedItemId();
    if (dict_id == null || dict_id == "") {
        layer.warning("请先选择字典树,确定数据项所属的字典!");
        return;
    }

    // 获得选中的表格数据ID
    var table = $("#data_table").DataTable();
    var data = table.row(
        { selected : true }).data();
    if (data == null || data == undefined) {
        layer.warning("请选择要删除的数据！");
        return;
    }
    showConfirm("是否要删除该字典数据项?", deleteRole, data.uuid);
})


//删除字典数据项
function deleteDictData(id) {
    var para = {};
    para.uuid = id;
    $.ajax(
        { url : "dict/deletedictdatabyid",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                initDictDataTable();
                layer.info("删除成功！");
            }
        }});
}


// 保存字典数据项按钮点击事件
$("#btn_save_dict_data").click(function() {

    // 表单校验
    var msg = "";
    if ($('#dictDataCode').val() == "") {
        msg += "请输入字典数据项编码!" + "  \n";
    } else {
        if (!(/[0-9a-zA-Z]{1,20}/).test($('#dictDataCode').val())) {
            msg += "字典数据项编码格式错误!" + "  \n";
        }
    }
    if ($('#dictDataName').val() == "") {
        msg += " 请输入字典数据项名称!" + "  \n";
    }
    if (!$("input[name=dataState]").is(':checked')) {
        msg += " 请输入字典数据项状态!" + "  \n";
    }
    if ($('#sortNum').val() == "") {
        msg += "请输入字典数据项排序号!" + "  \n";
    } else {
        if (!(/[0-9]{1,2}/).test($('#sortNum').val())) {
            msg += "字典数据项排序号格式错误!" + "  \n";
        }
    }
    if (msg != "") {
        layer.warning(msg);
        return;
    }
    $.ajax(
        { url : "dict/data/new",
        data : $("#data_form_1").formToJsonString(),
        success : function(data) {
            if (data.success == true) {
                initDictDataTable();
                layer.closeAll('page');
                layer.info("保存成功！");
            } else if (data.status == "err_001") {
                layer.error("该字典数据项编码已经存在,请修改！");
            }
        } });
})


//关闭表单窗口
$("button[name='btn_close_form']").click(function() {
    layer.closeAll('page');
})
