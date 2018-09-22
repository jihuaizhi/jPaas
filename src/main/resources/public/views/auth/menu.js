//菜单树
var menutTree;

var menuIsOpen = false;

// 数据表格列数据映射
//var columnsConfig = [
//		{
//			data : 'uuid',
//			visible : false
//		}, {
//			data : null,
//			title : '序号',
//			width : "50px",
//			render : function(data, type, row, meta) {
//				// 显示流水号
//				return meta.row + 1;
//			}
//		}, {
//			data : 'menuName',
//			title : '菜单名称'
//		}, {
//			data : 'menuLink',
//			title : '菜单链接'
//		}, {
//			data : 'menuIcon',
//			title : '菜单图标'
//		}
//];


// 页面初始化块
$(function() {
	// 加载树形控件的数据
	initMenuTree("");
	// // 初始化表格显示
	// $("#data_table").DataTable(
	// { "columnDefs" : columnDefsConfig });
});


// 加载树形控件数据
function initMenuTree(pid) {
	var para = {};
	para.parentUuid = pid;
	$.ajax({
		url : "/menu/getMenuByParent",
		data : JSON.stringify(para),
		success : function(data) {
			var objList = data.objList;
			var jsonObj = getTreeJsonObj(objList, "", "parentUuid", "uuid", "menuName");
			if (menutTree != undefined) {
				// 销毁树
				menutTree.destructor();
			}
			menutTree = undefined;
			menutTree = getTreeObject("data_tree", jsonObj, true, false, false);
			// 绑定事件
			menutTree.attachEvent("onSelect", function(uuid) {
				onTreeSelect(uuid);
			});
			menutTree.attachEvent("onDrop", function(sId, tId, uuid, sObject, tObject) {
				dndTree(sId, tId, uuid, sObject, tObject);
			});
			menutTree.attachEvent("onDblClick", function(uuid) {
				onTreeDblClick(uuid);
			});
		}
	});

}

//
//// 加载表格数据
function loadMenuTable() {
//	var para = {};
//	para.uuid = menutTree.getSelectedItemId();
//	if (para.uuid == null || para.uuid == "") {
//		layer.warning("请选择要查看的菜单树！");
//		return false;
//	}
//	layer.load(2);
//	$.ajax({
//		url : "menu/querylistbyid",
//		data : JSON.stringify(para),
//		success : function(data) {
//			if (data.success == true) {
//				$("#data_table").DataTable({
//					data : data.objList,
//					columns : columnsConfig,
//				});
//			}
//		}
//	});
}


// 展开收起按钮点击事件
$("#btn_expandOrCollapse").click(function() {
	if (menuIsOpen) {
		menutTree.closeAllItems("");
		$("#btn_open").text("展开");
	} else {
		menutTree.openAllItems("");
		$("#btn_open").text("折叠");
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
	// 设置控件获得焦点
	$("#menuName").focus();
	// 激活表单
	$("#data_form input,#data_form button").attr("disabled", false);
	$("#btn_editOrCancel").hide();
}


//菜单表单编辑状态切换按钮点击事件
$("#btn_editOrCancel").click(function() {
	if ($("#btn_save").attr("disabled") == "disabled") {
		$("#data_form input,#data_form button").attr("disabled", false);
		$("#btn_editOrCancel").text("取消");
	} else {
		$("#data_form input,#data_form button").attr("disabled", true);
		$("#btn_editOrCancel").text("编辑");
	}
	$("#btn_editOrCancel").attr("disabled", false);

})

// 菜单编辑表单-图标选择按钮点击事件
$("#btn_selectIcon").click(function() {
	$("#icon_class").val("");
	$('#data_modal .modal-title').text("选择菜单图标");
	$('#data_modal').modal('show');
})

//图标点击事件
$(".bs-glyphicons li").click(function() {
	$(".bs-glyphicons li").css("background-color", "");
	$(this).css("background-color", "rgba(86, 61, 124, .1)");
	$("#icon_class").val($(this).children("span").prop("className"));
});

//图标选择表单-选择按钮点击事件
$("#btn_select").click(function() {
	$("#menuIcon").val($("#icon_class").val());
	$("#selected_icon").attr("class", $("#icon_class").val());
	$('#data_modal').modal('hide');
})


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
					layer.info("新增成功,重新登录后生效！");
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
					layer.info("修改成功,重新登录后生效！");
				}
			}
		});
	}
	initMenuTree("");
	// 初始化表单
	$("#data_form")[0].reset();
	$("#uuid").val("");
	$("#parentUuid").val("");
	// 禁用表单
	$("#data_form input,#data_form button").attr("disabled", true);
	$("#btn_editOrCancel").hide();
	$("#selected_icon").attr("class", "");

})





// 菜单项双击事件,触发修改按钮操作
function onTreeDblClick(uuid) {
	$('#btn_update').trigger("click");
}


// 修改按钮点击事件
$("#btn_update").click(function() {
	$("#data_form input,#data_form button").attr("disabled", false);

//	var para = {};
//	para.uuid = menutTree.getSelectedItemId();
//	if (para.uuid == null || para.uuid == "") {
//		layer.warning("请选择要修改的菜单！");
//		return;
//	}
//	$.ajax({
//		url : "menu/querybyid",
//		data : JSON.stringify(para),
//		success : function(data) {
//			if (data.success == true) {
//				$("#data_form")[0].reset();
//				$("#uuid").val(data.obj.uuid);
//				$("#parentUuid").val(data.obj.parentUuid);
//				$("#menuName").val(data.obj.menuName);
//				$("#menuLink").val(data.obj.menuLink);
//				$("#menuIcon").val(data.obj.menuIcon);
//				$("input:radio[name=dataState][value='" + data.obj.dataState + "']").iCheck('check');
//				showForm("修改菜单项", $('#data_form'));
//			} else if (data.errorList.length > 0) {
//				layer.error(getErrString(data.errorList));
//			}
//		}
//	});
})



// 删除按钮点击事件
$("#btn_delete").click(function() {
	if (menutTree.getSelectedItemId() == null || menutTree.getSelectedItemId() == "") {
		layer.warning("请选择要删除的菜单！");
		return;
	}
	showConfirm("删除菜单将会同时删除该菜单下的所有子菜单,是否要继续删除该菜单项?", deleteMenu, menutTree.getSelectedItemId());
})


// 删除菜单
function deleteMenu(uuid) {
	var para = {};
	para.uuid = uuid;
	$.ajax({
		url : "menu/delete",
		data : JSON.stringify(para),
		success : function(data) {
			if (data.success == true) {
				initMenuTree("");
				layer.info("删除成功！");
			} else if (data.errorList.length > 0) {
				layer.error(getErrString(data.errorList));
			}
			window.parent.loadMenu();
		},
		complete : function(XMLHttpRequest, textStatus) {
			layer.closeAll('loading');
		}
	});
}

// 启用表格拖拽
$("#btn_sort").click(function() {
	layer.warning("努力开发中...");
})


// 树形控件拖拽事件
function dndTree(sId, tId, uuid, sObject, tObject) {
	var uuidList = menutTree.getAllSubItems("").split(",");
	var para = {};
	para.uuid = sId;
	para.parentUuid = tId;
	para.idList = uuidList;
	$.ajax({
		url : "menu/savesort",
		data : JSON.stringify(para),
		success : function(data) {
			if (data.success == true) {
				initMenuTree("");
				// parent.location.reload();
				layer.info("保存成功,重新登录后生效！");
			} else if (data.errorList.length > 0) {
				layer.error(getErrString(data.errorList));
			}
		},
		complete : function(XMLHttpRequest, textStatus) {
			window.parent.loadMenu();
		}
	});
}


/**
 * 选中树 调用的方法
 * 
 * @param uuid
 * @param state
 * @returns
 */
function onTreeSelect(uuid) {
//	loadMenuTable();

	var para = {};
	para.uuid = uuid;
	$.ajax({
		url : "/menu/getById",
		data : JSON.stringify(para),
		success : function(data) {
			if (data.success == true) {
				$("#uuid").val(data.obj.uuid);
				$("#parentUuid").val(data.obj.parentUuid);
				$("#menuName").val(data.obj.menuName);
				$("#menuLink").val(data.obj.menuLink);
				$("#menuIcon").val(data.obj.menuIcon);
				$("#selected_icon").attr("class", data.obj.menuIcon);
				$("#btn_editOrCancel").show();
			}
		}
	});
}


// 关闭表单窗口
$("button[name='btn_close_form']").click(function() {
	layer.closeAll('page');
})
