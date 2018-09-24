//菜单树
var menutTree;

// 菜单树的展开收起状态控制变量
var menuIsOpen = true;

// 页面初始化块
$(function() {
    // 加载树形控件的数据
    initMenuTree("");
});


// 加载树形控件数据
function initMenuTree(pid) {
    $.ajax({
        url : "/menu/getMenuList",
        success : function(data) {
            var objList = data.objList;
            var jsonObj = getTreeJsonObj(objList, "", "parentUuid", "uuid", "menuName");
            if (menutTree != undefined) {
                // 销毁树
                menutTree.destructor();
            }
            menutTree = getTreeObject("data_tree", jsonObj, true, false, false);
            // 绑定事件
            menutTree.attachEvent("onDrop", function(sId, tId, uuid, sObject, tObject) {
                dndTree(sId, tId, uuid, sObject, tObject);
            });
            menutTree.attachEvent("onDblClick", function(uuid) {
                onTreeDblClick(uuid);
            });
            menutTree.openAllItems("");
        }
    });
}


// 展开收起按钮点击事件
$("#btn_expandOrCollapse").click(function() {
    if (menuIsOpen) {
        menutTree.closeAllItems("");
        $("#btn_expandOrCollapse").text("展开");
    } else {
        menutTree.openAllItems("");
        $("#btn_expandOrCollapse").text("折叠");
    }
    menuIsOpen = !menuIsOpen;
})


// 新增按钮点击事件
$("#btn_insert").click(function() {
    if (menutTree.getSelectedItemId() == null || menutTree.getSelectedItemId() == "") {
        showConfirm("未选择新增菜单的父级菜单,是否要新增顶级菜单项?", addMenu, "");
    } else {
        addMenu(menutTree.getSelectedItemId());
    }
})


// 新增菜单菜单
function addMenu(pid) {
    // 初始化表单
    $("#data_form")[0].reset();
    $("#uuid").val("");
    $("#parentUuid").val(pid);
    $("#menu_icon_display").attr("class", "");
    // 激活表单
    $('#data_modal .modal-title').text("新增菜单");
    $('#data_modal').modal('show');
}


// 保存按钮点击事件
$("#btn_save").click(function() {
    // 表单校验
    var msg = "";
    if ($('#menuName').val() == "") {
        msg += "请输入菜单名称!<br>";
    }
    if ($('#menuLink').val() == "") {
        msg += " 请输入菜单链接!<br>";
    }
    if ($('#menuIcon').val() == "") {
        msg += " 请输入菜单图标!<br>";
    }
    if (msg != "") {
        layer.warning(msg);
        return;
    }
    if ($("#uuid").val() == "") {
        $.ajax({
            url : "/menu/insert",
            data : $("#data_form").formToJsonString(),
            success : function(data) {
                if (data.success == true) {
                    initMenuTree("");
                    layer.info("新增成功！");
                }
            }
        });
    } else {
        $.ajax({
            url : "/menu/update",
            data : $("#data_form").formToJsonString(),
            success : function(data) {
                if (data.success == true) {
                    initMenuTree("");
                    layer.info("修改成功！");
                }
            }
        });
    }
    $('#data_modal').modal('hide');
})


// 菜单编辑表单-图标选择按钮点击事件
$("#btn_open_icon_form").click(function() {
    $('#data_modal_icon .modal-title').text("选择菜单图标");
    $('#data_modal_icon').modal('show');
})

// 图标点击事件
$(".bs-glyphicons li").click(function() {
    $(".bs-glyphicons li").css("background-color", "");
    $(this).css("background-color", "rgba(86, 61, 124, .1)");
    $("#icon_class").val($(this).children("span").prop("className"));
});


// 图标双击事件
$(".bs-glyphicons li").dblclick(function() {
    $('#btn_select_icon').trigger("click");
});


// 图标选择表单-选择按钮点击事件
$("#btn_select_icon").click(function() {
    $("#menuIcon").val($("#icon_class").val());
    $("#menu_icon_display").attr("class", $("#icon_class").val());
    $('#data_modal_icon').modal('hide');
})



// 菜单项双击事件,触发修改按钮操作
function onTreeDblClick(uuid) {
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
    $.ajax({
        url : "/menu/getById",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                $("#data_form")[0].reset();
                $("#uuid").val(data.obj.uuid);
                $("#parentUuid").val(data.obj.parentUuid);
                $("#menuName").val(data.obj.menuName);
                $("#menuLink").val(data.obj.menuLink);
                $("#menuIcon").val(data.obj.menuIcon);
                $("#menu_icon_display").attr("class", data.obj.menuIcon);
                // 打开表单
                $('#data_modal .modal-title').text("修改菜单");
                $('#data_modal').modal('show');
            }
        }
    });
})


// 删除按钮点击事件
$("#btn_delete").click(function() {
    if (menutTree.getSelectedItemId() == null || menutTree.getSelectedItemId() == "") {
        layer.warning("请选择要删除的菜单！");
        return;
    }
    showConfirm("是否要继续删除该菜单项?", deleteMenu, menutTree.getSelectedItemId());
})



// 删除菜单
function deleteMenu(uuid) {
    var para = {};
    para.uuid = uuid;
    $.ajax({
        url : "/menu/delete",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                initMenuTree("");
                layer.info("删除成功！");
            }
        }
    });
}


// 树形控件拖拽事件
function dndTree(sId, tId, uuid, sObject, tObject) {
    var uuidList = menutTree.getAllSubItems("").split(",");
    var para = {};
    para.uuid = sId;
    para.parentUuid = tId;
    para.idList = uuidList;
    $.ajax({
        url : "/menu/saveSort",
        data : JSON.stringify(para),
        success : function(data) {
            if (data.success == true) {
                initMenuTree("");
                layer.info("保存成功！");
            }
        }
    });
}
