// 用户表格列数据映射
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
            data : 'permissionCode',
            title : 'URL路径',
            width : "120px",
            render : function(data, type, row, meta) {
                return "<a href=" + data + ">" + data + "</a>";
            }
        },
        {
            data : 'permissionName',
            title : 'URL名称',
            width : "150px"
        },
        {
            data : 'permissionType',
            title : '权限类型',
            width : "100px",
            render : function(data, type, row, meta) {
                if (data == "1") {
                    return "URL请求";
                } else if (data == "3") {
                    return "菜单";
                } else if (data == "2") {
                    return "操作";
                } else if (data == "4") {
                    return "UI可见性";
                } else if (data == "5") {
                    return "数据对象";
                } else {
                    return "";
                }
            }
        },
        {
            data : 'permissionDescription',
            title : 'URL描述'
        },
        {
            data : 'dataState',
            title : '账号状态',
            width : "60px",
            render : function(data, type, row, meta) {
                if (data == "1") {
                    return "正常";
                } else if (data == "0") {
                    return "隐藏";
                } else {
                    return "";
                }
            }
        }
]

// 页面初始化块
$(function() {
    initDataTable();
});

/**
 * 加载表格数据
 * 
 * @returns
 */
function initDataTable() {
    $.ajax({
        url : "/permission/getList",
        success : function(data) {
            if (data.success == true) {
                $("#data_table").DataTable({
                    paging : false,
                    data : data.objList,
                    rowId : 'uuid', // 设置主键字段名
                    columns : columnsConfig,
                });
            }
        }
    });
}

// 扫描按钮点击事件
$("#btn_scan").click(function() {
    showConfirm("是否执行URL扫描,扫描URL会自动扫描系统所有URL,并修改现有数据", scanPermission, null);

})

// 执行扫描URL
function scanPermission() {
    $.ajax({
        url : "/permission/scanurl",
        success : function(data) {
            if (data.success == true) {
                layer.success("刷新成功！");
            }
        },
        complete : function(XMLHttpRequest, textStatus) {
            initDataTable();
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
        url : "/permission/getById",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                // 初始化表单
                $("#data_form")[0].reset();
                $("#uuid").val(data.obj.uuid);
                $("#permissionCode").val(data.obj.permissionCode);
                $("#permissionName").val(data.obj.permissionName);
                $("input:radio[name=dataState][value='" + data.obj.dataState + "']").iCheck('check');
                $("#permissionDescription").val(data.obj.permissionDescription);
                // 显示表单
                $('#data_modal .modal-title').text("修改URL信息");
                $('#data_modal').modal('show');
            }
        }
    });
})

// 保存按钮点击事件
$("#btn_save").click(function() {
    $.ajax({
        url : "/permission/update",
        data : $("#data_form").formToJsonString(),
        success : function(data) {
            if (data.success == true) {
                initDataTable();
                $('#data_modal').modal('hide');
                layer.info("保存成功！");
            }
        }
    });
})

// 禁用按钮点击事件 改变状态
$("#btn_delete").click(
        function() {
            var table = $("#data_table").DataTable();
            var data = table.row({ selected : true
            }).data();
            if (data == null || data == undefined) {
                layer.warning("请选择要删除的数据！");
                return;
            }
            showConfirm("删除权限信息将会同时删除角色与权限的关联关系,<br>URL权限是扫描系统自动生成的数据,手工删除可能引起不可预知的问题,<br>" + " 是否确定要删除该权限信息?",
                    deletePermission, data.uuid);
        })

// 删除用户信息
function deletePermission(uuid) {
    var para = {};
    para.uuid = uuid;
    $.ajax({
        url : "/permission/delete",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                initDataTable();
                layer.info("删除成功！");
            }
        }
    });
}

//模态框接收回车按键事件,触发保存按钮点击事件
$("#data_modal").keydown(function(e) {
    if (e.keyCode == 13) {
        $('#btn_save').trigger("click");
    }
});

