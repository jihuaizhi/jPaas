//菜单树
var menutTree;


var menuIsOpen = false;


// 数据表格列数据映射
var columnsConfig = [
    { data : 'uuid' },
    { data : 'sortNum' },
    { data : null,
    render : function(data, type, row, meta) {
        //显示流水号
        return meta.row + 1;
    } },
    { data : 'menuName' },
    { data : 'menuLink' },
    { data : 'menuIcon' },
    { data : 'dataState',
    render : function(data, type, row, meta) {
        if (data == "1") {
            return "启用";
        } else if (data == "0") {
            return "停用";
        } else {
            return "";
        }
    } } ];


var columnDefsConfig = [
    { "targets" : [ 0, 1 ],
    "visible" : false } ];


// 页面初始化块
$(function() {
    // 加载树形控件的数据
//    initMenuTree();
//    // 初始化表格显示
//    $("#data_table").DataTable($.extend(true, {}, TABLE_OPTION_1,
//        { "columnDefs" : columnDefsConfig }));
});


//加载树形控件数据
function initMenuTree() {
    layer.load(2);
    $.ajax(
        { url : "menu/querylist",
        success : function(data) {
            var objList = data.objList;
            var jsonObj = getTreeJsonObj(objList, "", "parentId", "uuid", "menuName");
            if (menutTree != undefined) {
                // 销毁树
                menutTree.destructor();
            }
            menutTree = getTreeObject("data_tree", jsonObj, true, false, false);
            menutTree.parse(jsonObj, "json");
            // 绑定事件
            menutTree.attachEvent("onSelect", function(id) {
                onTreeSelect(id);
            });
            menutTree.attachEvent("onDrop", function(sId, tId, id, sObject, tObject) {
                dndTree(sId, tId, id, sObject, tObject);
            });
            menutTree.attachEvent("onDblClick", function(id) {
                onTreeDblClick(id);
            });
        },
        complete : function(XMLHttpRequest) {
            layer.closeAll('loading');
        } });

}


//加载表格数据
function loadMenuTable() {
    var para = {};
    para.uuid = menutTree.getSelectedItemId();
    if (para.uuid == null || para.uuid == "") {
        layer.warning("请选择要查看的菜单树！");
        return false;
    }
    layer.load(2);
    $.ajax(
        { url : "menu/querylistbyid",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                $("#data_table").DataTable($.extend(true, {}, TABLE_OPTION_1,
                    { data : data.objList,
                    columns : columnsConfig,
                    columnDefs : columnDefsConfig }));
            } else if (data.errorList.length > 0) {
                layer.error(getErrString(data.errorList));
            }
        },
        complete : function(XMLHttpRequest, textStatus) {
            layer.closeAll('loading');
        } });
}


//展开收起按钮点击事件
$("#btn_open").click(function() {
    if (menuIsOpen) {
        menutTree.closeAllItems("");
        $("#btn_open").html("展");
    } else {
        menutTree.openAllItems("");
        $("#btn_open").html("收");
    }
    menuIsOpen = !menuIsOpen;
})


// 新增按钮点击事件
$("#btn_insert").click(function() {
    if (menutTree.getSelectedItemId() == null || menutTree.getSelectedItemId() == "") {
        showConfirm("未选择新增菜单的父级菜单,是否要新增顶级菜单项?", addMenu, null);
    } else {
        addMenu(menutTree.getSelectedItemId());
    }
})


//新增菜单
function addMenu(pid) {
    var para = {};
    para.parentId = pid;
    // 初始化表单
    $("#data_form")[0].reset();
    $("#uuid").val("");
    $("#parentId").val(para.parentId);
    // 状态默认值:显示
    $("input[name=dataState]:eq(0)").iCheck('check');
    // 设置控件获得焦点
    $("#menuName").focus();
    //显示表单
    showForm("新增菜单项", $('#data_form'));
}


//菜单项双击事件,触发修改按钮操作
function onTreeDblClick(id) {
    $('#btn_update').trigger("click");
}


// 修改按钮点击事件
$("#btn_update").click(function() {
    var para = {};
    para.uuid = menutTree.getSelectedItemId();
    if (para.uuid == null || para.uuid == "") {
        layer.warning("请选择要修改的菜单！");
        return;
    }
    $.ajax(
        { url : "menu/querybyid",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                $("#data_form")[0].reset();
                $("#uuid").val(data.obj.uuid);
                $("#parentId").val(data.obj.parentId);
                $("#menuName").val(data.obj.menuName);
                $("#menuLink").val(data.obj.menuLink);
                $("#menuIcon").val(data.obj.menuIcon);
                $("input:radio[name=dataState][value='" + data.obj.dataState + "']").iCheck('check');
                showForm("修改菜单项", $('#data_form'));
            } else if (data.errorList.length > 0) {
                layer.error(getErrString(data.errorList));
            }
        } });
})


// 保存按钮点击事件
$("#btn_save").click(function() {

    // 表单校验
    var msg = "";
    if ($('#menuName').val() == "") {
        msg += "请输入菜单名称!" + "  \n";
    }
    if ($('#nemuLink').val() == "") {
        msg += " 请输入菜单链接!" + "  \n";
    }
    if (!$("input[name=dataState]").is(':checked')) {
        msg += " 请输入菜单状态!" + "  \n";
    }
    if (msg != "") {
        layer.warning(msg);
        return;
    }

    $.ajax(
        { url : "menu/save",
        data : $("#data_form").formToJsonString(),
        success : function(data) {
            if (data.success == true) {
                layer.closeAll('page');
                layer.info("保存成功,重新登录后生效！");
                initMenuTree();
            } else if (data.errorList.length > 0) {
                layer.error(getErrString(data.errorList));
            }
        },
        complete : function(XMLHttpRequest, textStatus) {
            window.parent.loadMenu();
        } });
})


// 删除按钮点击事件
$("#btn_delete").click(function() {
    if (menutTree.getSelectedItemId() == null || menutTree.getSelectedItemId() == "") {
        layer.warning("请选择要删除的菜单！");
        return;
    }
    showConfirm("删除菜单将会同时删除该菜单下的所有子菜单,是否要继续删除该菜单项?", deleteMenu, menutTree.getSelectedItemId());
})


//删除菜单
function deleteMenu(id) {
    var para = {};
    para.uuid = id;
    $.ajax(
        { url : "menu/delete",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                initMenuTree();
                layer.info("删除成功！");
            } else if (data.errorList.length > 0) {
                layer.error(getErrString(data.errorList));
            }
            window.parent.loadMenu();
        },
        complete : function(XMLHttpRequest, textStatus) {
            layer.closeAll('loading');
        } });
}

//启用表格拖拽
$("#btn_sort").click(function() {
    layer.warning("努力开发中...");
})


//树形控件拖拽事件
function dndTree(sId, tId, id, sObject, tObject) {
    var uuidList = menutTree.getAllSubItems("").split(",");
    var para = {};
    para.uuid = sId;
    para.parentId = tId;
    para.idList = uuidList;
    $.ajax(
        { url : "menu/savesort",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                initMenuTree();
                //                parent.location.reload();
                layer.info("保存成功,重新登录后生效！");
            } else if (data.errorList.length > 0) {
                layer.error(getErrString(data.errorList));
            }
        },
        complete : function(XMLHttpRequest, textStatus) {
            window.parent.loadMenu();
        } });
}


/**
 * 选中树 调用的方法
 * 
 * @param id
 * @param state
 * @returns
 */
function onTreeSelect(id) {
    loadMenuTable();
}


//关闭表单窗口
$("button[name='btn_close_form']").click(function() {
    layer.closeAll('page');
})
