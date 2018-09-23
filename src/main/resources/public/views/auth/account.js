// 表格列数据映射
var columnsConfig = [
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
            data : 'accountCode',
            title : '账号名称'
        },
        {
            data : 'accountName',
            title : '显示名称'
        },
        {
            data : 'dataState',
            title : '账号状态',
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
    initDataTable();
});


// 加载表格数据
function initDataTable() {
    $.ajax({
        url : "/account/getAccountList",
        success : function(data) {
            if (data.success == true) {
                $("#data_table").DataTable({
                    data : data.objList,
                    columns : columnsConfig
                });
            }
        }
    });
}

// 新增按钮点击事件
$("#btn_insert").click(function() {
    // 初始化表单
    $("#data_form")[0].reset();
    // 数据状态默认值 有效
    $("input[name=dataState]:eq(0)").iCheck('check');
    $("#uuid").val("");
    // 显示表单
    $('#data_modal .modal-title').text("新增账号");
    $('#data_modal').modal('show');
});

// 密码校验方法
function checkPassword(pwd) {
    // 密码校验规则-长度6-18之间的字母、数字、下划线-
    var patrn = /^(\w){6,18}$/;
    if (!patrn.test(pwd)) {
        return "密码过于简单！请按照格式输入:密码校验规则-长度6-18之间的字母、数字、下划线！<br>";
    } else {
        return "";
    }
};

// 保存按钮点击事件
$("#btn_save").click(function() {
    // 表单校验
    var msg = "";
    if ($('#accountCode').val() == "") {
        msg += "请输入登录账号!<br>";
    }
    if ($('#accountName').val() == "") {
        msg += "请输入账号名称!<br>";
    }
    if ($("#password1").val() != "") {
        msg += checkPassword($("#password1").val());
    }
    if ($("#password2").val() != "") {
        msg += checkPassword($("#password2").val());
    }
    if ($("#password1").val() != $("#password2").val()) {
        msg += "两次输入的密码不一致!<br>";
    }
    if (msg != "") {
        layer.warning(msg);
        return;
    }
    if ($("#uuid").val() == "") {
        if ($("#password1").val() == "") {
            layer.warning("请输入密码!");
            return;
        }
        $.ajax({
            url : "/account/insert",
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
            url : "/account/update",
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
    showConfirm("是否要删除该账号?", deleteUser, data.uuid);
})

// 删除账号
function deleteUser(uuid) {
    var para = {};
    para.uuid = uuid;
    $.ajax({
        url : "/account/delete",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                initDataTable();
                layer.info("删除成功！");
            }
        }
    });
}


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
        url : "/account/getById",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                // 初始化表单
                $("#data_form")[0].reset();
                $("#uuid").val(data.obj.uuid);
                $("#accountCode").val(data.obj.accountCode);
                $("#accountCode").attr("disabled", true);
                $("#accountName").val(data.obj.accountName);
                $("input:radio[name=dataState][value='" + data.obj.dataState + "']").iCheck('check');
                $('#data_modal .modal-title').text("修改账号");
                $('#data_modal').modal('show');

            }
        }
    });
})

// 修改密码
$("#btn_pwd").click(function() {
    var table = $("#data_table").DataTable();
    var data = table.row({ selected : true
    }).data();
    if (data == null || data == undefined) {
        layer.warning("请选择要修改密码的数据！");
        return;
    }
    // 初始化表单
    $("#data_form_pwd")[0].reset();
    // 显示表单
    $('#data_modal_pwd').modal('show');
})

// 重置密码表单保存按钮点击事件
$("#btn_save_pwd").click(function() {

    // 表单校验
    var msg = "";
    if ($('#newPassword1').val() == "") {
        msg += "请输入新密码!<br>";
    }
    if ($('#newPassword2').val() == "") {
        msg += "请输入确认密码!<br>";
    }
    if ($('#newPassword1').val() != $('#newPassword2').val()) {
        msg += "两次输入的密码不一致，请重新输入" + " \n";
    }
    if (msg != "") {
        layer.warning(msg);
        return;
    }

    var table = $("#data_table").DataTable();
    var data = table.row({ selected : true
    }).data();
    var para = {};
    para.uuid = data.uuid;
    para.oldPassword = $('#oldPassword').val();
    para.newPassword = $('#newPassword1').val();
    $.ajax({
        url : "/account/resetPwd",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                // 隐藏表单
                $('#data_modal_pwd').modal('hide');
                layer.info("重置密码成功！");
            }
        }
    });
})
