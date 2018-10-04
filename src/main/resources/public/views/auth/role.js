//菜单树
var menutTree;

var checkAllFlag = true;

// 表格列数据映射
var colConfigRole = [
        {
            data : 'uuid',
            visible : false
        },
        {
            data : null,
            title : '序号',
            width : "30px",
            render : function(data, type, row, meta) {
                // 显示流水号
                return meta.row + 1;
            }
        },
        {
            data : 'roleCode',
            title : '角色代码',
            width : "150px"
        },
        {
            data : 'roleName',
            title : '角色名称',
            width : "150px"
        },
        {
            data : 'roleDescription',
            title : '角色说明'
        }

];


// 表格列数据映射
var colConfigPermission = [
        {
            data : 'uuid',
            visible : false
        },
        {
            data : null,
            width : "30px",
            orderable : false,
            className : 'select-checkbox',
            render : function(data, type, row, meta) {
                return "";
            }
        },
        {
            data : 'permissionCode',
            title : 'URL路径',
            width : "120px",
        },
        {
            data : 'permissionName',
            title : 'URL名称',
        }
];


// 页面初始化块
$(function() {
    initDataTable();
    initMenuTree(null);
});


/**
 * 加载表格数据
 * 
 * @returns
 */
function initDataTable() {
    $.ajax({
        url : "/role/getList",
        success : function(data) {
            if (data.success == true) {
                $("#data_table").DataTable({
                    data : data.objList,
                    rowId : 'uuid', // 设置主键字段名
                    columns : colConfigRole
                });
            }
        }
    });
}


// 新增按钮点击事件
$("#btn_insert").click(function() {
    $("#uuid").val("");
    // 初始化表单
    $("#data_form")[0].reset();
    $("#roleCode").attr("readonly", false);
    // 初始化菜单树
    initMenuTree(null);
    initUrlTable(null);
    $('a[href="#tab_1"]').trigger("click");

    // 显示表单
    $('#data_modal .modal-title').text("新增角色");
    $('#data_modal').modal('show');

});

// 修改按钮点击事件
$("#btn_update").click(function() {
    var table = $("#data_table").DataTable();
    var data = table.row({ selected : true
    }).data();
    if (data == null || data == undefined) {
        layer.warning("请选择要修改的数据！");
        return;
    }
    var para = {};
    para.uuid = data.uuid;
    $.ajax({
        url : "/role/getById",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                // 初始化表单
                $("#uuid").val(data.obj.uuid);
                $("#roleCode").val(data.obj.roleCode);
                $("#roleCode").attr("readonly", true);
                $("#roleName").val(data.obj.roleName);
                $("#roleDescription").val(data.obj.roleDescription);
                var menuUuid = [];
                for (var i = 0; i < data.menuList.length; i++) {
                    menuUuid.push(data.menuList[i].menuUuid);
                }
                initMenuTree(menuUuid);
                var permissions = [];
                for (var i = 0; i < data.permissionList.length; i++) {
                    permissions.push(data.permissionList[i].permissionUuid);
                }
                initUrlTable(permissions);
                $('a[href="#tab_1"]').trigger("click");
                $('#data_modal .modal-title').text("修改角色");
                $('#data_modal').modal('show');
            }
        }
    })
})


// 删除按钮点击事件
$("#btn_delete").click(function() {
    var table = $("#data_table").DataTable();
    var data = table.row({ selected : true
    }).data();
    if (data == null || data == undefined) {
        layer.warning("请选择要删除的数据！");
        return;
    }
    showConfirm("删除角色将会级联删除相关权限和用户关联,是否确定要删除该角色?", deleteRole, data.uuid);
});


// 删除角色
function deleteRole(uuid) {
    var para = {};
    para.uuid = uuid;
    $.ajax({
        url : "/role/delete",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                initDataTable();
                layer.success("删除成功！");
            } else if (data.errorList.length > 0) {
                layer.error(getErrString(data.errorList));
            }
        }
    });
}


// 保存按钮点击事件
$("#btn_save").click(function() {
    // 表单校验
    var msg = "";
    if ($('#roleCode').val() == "") {
        msg += "请输入角色编码!<br>";
    }
    if ($('#roleName').val() == "") {
        msg += "请输入角色名称!<br>";
    }
    if (msg != "") {
        layer.warning(msg);
        return;
    }
    showConfirm("是否确认保存角色及授权信息?", saveRole);
})


// 保存方法
function saveRole() {
    // 获取所有选中的菜单项
    var menuIds = "";
    var checkedId = menutTree.getAllChecked();
    var checkedPId = menutTree.getAllPartiallyChecked();
    if (checkedPId != null && checkedPId.length > 0) {
        menuIds = checkedId + "," + checkedPId;
    } else {
        menuIds = checkedId;
    }
    $("#checkedMenuUuid").val(menuIds);

    // 获取所有选中的url授权uuid
    var table = $("#data_table_permission").DataTable();
    var data = table.rows({ selected : true
    }).ids();
    $("#selectedPermissionUuid").val(data.join(","));
    if ($("#uuid").val() == "") {
        $.ajax({
            url : "/role/insert",
            data : $("#data_form").formToJsonString(),
            success : function(data) {
                if (data.success == true) {
                    initDataTable();
                    // 隐藏表单
                    $('#data_modal').modal('hide');
                    layer.info("新增成功！");
                }
            }
        });
    } else {
        $.ajax({
            url : "/role/update",
            data : $("#data_form").formToJsonString(),
            success : function(data) {
                if (data.success == true) {
                    initDataTable();
                    // 隐藏表单
                    $('#data_modal').modal('hide');
                    layer.info("更新成功！");
                }
            }
        });
    }
}


/**
 * 加载树形控件数据
 * @param checkedIds 初始化树后需要被勾选的id数组
 * @returns
 */
function initMenuTree(checkedIds) {
    $.ajax({
        url : "/menu/getMenuList",
        success : function(data) {
            if (data.success == true) {
                var objList = data.objList;
                var jsonObj = getTreeJsonObj(objList, "", "parentUuid", "uuid", "menuName");
                if (menutTree != undefined) {
                    // 销毁树
                    menutTree.destructor();
                }
                menutTree = getTreeObject("menu_tree", jsonObj, false, true, true);
                menutTree.openAllItems("");
                menutTree.setSubChecked("", false);
            }
        },
        complete : function(XMLHttpRequest, textStatus) {
            // 加载已有角色的时候,勾选曾经保存过的数据
            if (checkedIds != undefined && checkedIds != null) {
                var childlessNodes = menutTree.getAllChildless().split(",");
                console.log(childlessNodes.length);
                for (var i = 0; i < checkedIds.length; i++) {
                    for (var j = 0; j < childlessNodes.length; j++) {
                        if (checkedIds[i] == childlessNodes[j]) {
                            menutTree.setCheck(checkedIds[i], true);
                        }
                    }
                }
            }
        }
    });
}


/**
 * @加载URL授权
 */
function initUrlTable(selectIds) {
    $.ajax({
        url : "/permission/getVisibilityList",
        success : function(data) {
            if (data.success == true) {
                $("#data_table_permission").DataTable({
                    data : data.objList,
                    rowId : 'uuid', // 设置主键字段名
                    columns : colConfigPermission,
                    select : {
                        style : 'multi',
                        selector : 'tr',
                        items : 'row',
                    },
                    ordering : false,
                    paging : false
                });
            }
        },
        complete : function(XMLHttpRequest, textStatus) {
            // 加载已有角色的时候,勾选曾经保存过的数据
            if (selectIds != undefined && selectIds != null) {
                var table = $("#data_table_permission").DataTable();
                for (var i = 0; i < selectIds.length; i++) {
                    table.row(function(idx, data, node) {
                        return data.uuid === selectIds[i] ? true : false;
                    }).select();
                }
            }
        }
    });
}

// 表格的全选和反全选事件
$('#checkAll').on('click', function(event) {
    var table = $("#data_table_permission").DataTable();
    if (checkAllFlag) {
        table.rows().select();
    } else {
        table.rows().deselect();
    }
    checkAllFlag = !checkAllFlag;
})



// 查看角色下所有的用户
$("#btn_role_user").click(function() {
    var table = $("#data_table").DataTable();
    var data = table.row({ selected : true
    }).data();
    if (data == null || data == undefined) {
        layer.warning("请选择角色！");
        return;
    }
    layer.info("开发中...");
    // showFrame("角色包含的用户列表", ('views_platform/security/role_user.jsp'));
})
