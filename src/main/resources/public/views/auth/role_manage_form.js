//菜单树
var menutTree;


var checkAllFlag = true;


//表格列数据映射
var columnsConfig = [
    { data : 'uuid' },
    { data : null,
    render : function(data, type, row, meta) {
        return "";
    } },
    { data : 'permissionCode' },
    { data : 'permissionName' } ];


var columnDefsConfig = [
    { "targets" : [ 0 ],
    "visible" : false },
    { orderable : false,
    className : 'select-checkbox',
    width : "50px",
    targets : 1 } ];


// 页面初始化块
$(function() {
    var uuid = sessionStorage.getItem("roleuuid");
    if (uuid != null && uuid.length > 0) {
        initUpdate(uuid);
    } else if (uuid != null && uuid.length == 0) {
        initNew();
    } else {
        window.history.back();
    }
});


/**
 * 新增画面初始化
 */
function initNew() {
    $("#uuid").val("");
    $("#roleCode").attr("readonly", false)
    $("input[name=dataState]:eq(0)").iCheck('check');
    initMenuTree(null);
    initUrlTable(null);
    $("#roleCode").focus();
}


/**
 * 修改画面初始化
 */
function initUpdate(uuid) {
    $("#roleCode").attr("readonly", true)
    $("#roleName").focus();
    var para = {};
    para.uuid = uuid;
    $.ajax(
        { url : "role/querybyid",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                // 初始化表单
                $("#uuid").val(data.role.uuid);
                $("#roleCode").val(data.role.roleCode);
                $("#roleName").val(data.role.roleName);
                $("#roleDescription").val(data.role.roleDescription);
                $("input:radio[name=dataState][value='" + data.role.dataState + "']").iCheck('check');
                var menuIds = [];
                for (var i = 0; i < data.menus.length; i++) {
                    menuIds.push(data.menus[i].uuid);
                }
                initMenuTree(menuIds);

                var permissions = [];
                for (var i = 0; i < data.permissions.length; i++) {
                    permissions.push(data.permissions[i].uuid);
                }
                initUrlTable(permissions);

            } else if (data.errorList.length > 0) {
                layer.error(getErrString(data.errorList));
            }
        } })
}


/**
 * 加载树形控件数据
 * @param checkedIds 初始化树后需要被勾选的id数组
 * @returns
 */
function initMenuTree(selectIds) {
    $.ajax(
        { url : "menu/querylistvisible",
        success : function(data) {
            if (data.success == true) {
                var objList = data.objList;
                var jsonObj = getTreeJsonObj(objList, "", "parentId", "uuid", "menuName");
                if (menutTree != undefined) {
                    // 销毁树
                    menutTree.destructor();
                }
                menutTree = getTreeObject("data_tree_1", jsonObj, false, true, true);
                menutTree.parse(jsonObj, "json");
                menutTree.openAllItems("");
                menutTree.setSubChecked("", false);
            } else if (data.errorList.length > 0) {
                layer.error(getErrString(data.errorList));
            }
        },
        complete : function(XMLHttpRequest, textStatus) {
            if (selectIds != undefined && selectIds != null) {
                for (var i = 0; i < selectIds.length; i++) {
                    menutTree.setCheck(selectIds[i], true);
                }
            }
        } });
}


/**
 * @加载URL授权
 */
function initUrlTable(selectIds) {
    $.ajax(
        { url : "role/getPermissionListVisible",
        success : function(data) {
            if (data.success == true) {
                $("#data_table").DataTable($.extend(true, {}, TABLE_LANGUAGE,
                    { data : data.objList,
                    columns : columnsConfig,
                    columnDefs : columnDefsConfig,
                    select :
                        { style : 'multi',
                        selector : 'tr',
                        items : 'row', },
                    ordering : false,
                    paging : false }));
            } else if (data.errorList.length > 0) {
                layer.error(getErrString(data.errorList));
            }
        },
        complete : function(XMLHttpRequest, textStatus) {
            if (selectIds != undefined && selectIds != null) {
                var table = $("#data_table").DataTable();
                for (var i = 0; i < selectIds.length; i++) {
                    table.row(function(idx, data, node) {
                        return data.uuid === selectIds[i] ? true : false;
                    }).select();
                }
            }
        } });
}


// 保存按钮点击事件
$("#btn_save").click(function() {
    // 表单校验
    var msg = "";
    if ($('#roleCode').val() == "") {
        msg += "请输入角色编码!" + "  \n";
    }
    if ($('#roleName').val() == "") {
        msg += "请输入角色名称!" + "  \n";
    }
    if (msg != "") {
        layer.warning(msg);
        return;
    }
    showConfirm("是否确认保存角色及授权信息?", saveRole);
})


// 保存方法
function saveRole() {
    //获取所有选中的菜单项
    var menuIds = "";
    var checkedId = menutTree.getAllChecked();
    var checkedPId = menutTree.getAllPartiallyChecked();
    if (checkedPId != null && checkedPId.length > 0) {
        menuIds = checkedId + "," + checkedPId;
    } else {
        menuIds = checkedId;
    }
    $("#menuIds").val(menuIds);

    //获取所有选中的url授权
    var table = $("#data_table").DataTable();
    var data = table.rows(
        { selected : true }).data();
    var urlIds = [];
    for (var i = 0; i < data.length; i++) {
        urlIds.push(data[i].uuid);
    }
    $("#permissionIds").val(urlIds);

    $.ajax(
        { url : "role/save",
        data : $("#data_form").formToJsonString(),
        success : function(data) {
            if (data.success == true) {
                layer.alert("保存成功！");
                sessionStorage.clear();
                window.location.href = getRootPath() + "/views_platform/security/role_manage_list.jsp";
            } else if (data.errorList.length > 0) {
                layer.error(getErrString(data.errorList));
            }
        } })
}


//表格的全选和反全选事件
$('#checkAll').on('ifChanged', function(event) {
    var table = $("#data_table").DataTable();
    if (checkAllFlag) {
        table.rows().select();
    } else {
        table.rows().deselect();
    }
    checkAllFlag = !checkAllFlag;
})


//返回列表按钮点击事件
$("#btn_back").click(function() {
    sessionStorage.clear();
    window.location.href = getRootPath() + "/views_platform/security/role_manage_list.jsp";
})
