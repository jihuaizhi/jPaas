// 表格列数据映射
var columnsConfig = [
        {
            data : 'uuid',
            visible : false
        },
        {
            data : null,
            title : '序号',
            width : "50px",
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
        },
        {
            data : 'dataState',
            title : '角色状态',
            width : "100px",
            render : function(data, type, row, meta) {
                if (data == "1") {
                    return "启用";
                } else if (data == "0") {
                    return "停用";
                } else {
                    return "";
                }
            }
        }
];

// 页面初始化块
$(function() {
    $('input').iCheck({
        checkboxClass : 'icheckbox_square-blue',
        radioClass : 'iradio_square-blue',
        increaseArea : '20%'
    });
    initDataTable();
    // initMenuTree(null);
    // initUrlTable(null);
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
                $("#data_table").DataTable($.extend(true, {}, T_SINGLE, {
                    data : data.roleList,
                    columns : columnsConfig,
                    rowReorder : true,
                    rowReorder : { selector : 'td:nth-child(1)'
                    }
                }));

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
    // 数据状态默认值 有效
    $("input[name=dataState]:eq(0)").iCheck('check');
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
                $("#uuid").val(data.role.uuid);
                $("#roleCode").val(data.role.roleCode);
                $("#roleCode").attr("readonly", true);
                $("#roleName").val(data.role.roleName);
                $("#roleDescription").val(data.role.roleDescription);
                $("input:radio[name=dataState][value='" + data.role.data + "']").iCheck('check');
                $('#data_modal .modal-title').text("修改角色");
                $('#data_modal').modal('show');
                // var menuIds = [];
                // for (var i = 0; i < data.menus.length; i++) {
                // menuIds.push(data.menus[i].uuid);
                // }
                // initMenuTree(menuIds);
                //
                // var permissions = [];
                // for (var i = 0; i < data.permissions.length; i++) {
                // permissions.push(data.permissions[i].uuid);
                // }
                // initUrlTable(permissions);

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
    // var menuIds = "";
    // var checkedId = menutTree.getAllChecked();
    // var checkedPId = menutTree.getAllPartiallyChecked();
    // if (checkedPId != null && checkedPId.length > 0) {
    // menuIds = checkedId + "," + checkedPId;
    // } else {
    // menuIds = checkedId;
    // }
    // $("#menuIds").val(menuIds);
    //
    // // 获取所有选中的url授权
    // var table = $("#data_table").DataTable();
    // var data = table.rows({ selected : true
    // }).data();
    // var urlIds = [];
    // for (var i = 0; i < data.length; i++) {
    // urlIds.push(data[i].uuid);
    // }
    // $("#permissionIds").val(urlIds);

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




//
// // 查看角色下所有的用户
// $("#btn_user").click(function() {
// var table = $("#data_table").DataTable();
// var data = table.row({ selected : true
// }).data();
// if (data == null || data == undefined) {
// layer.warning("请选择角色！");
// return;
// }
// showFrame("角色包含的用户列表", ('views_platform/security/role_user.jsp'));
// })
//
// // 启用表格拖拽
// $("#btn_sort").click(function() {
// layer.warning("努力开发中...");
// })
