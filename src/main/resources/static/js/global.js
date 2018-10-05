//****************** 产品自定义公共js  ***********************


/*
 * 页面初始化块
 */
$(function() {
	// 所有模态框可拖拽移动
	// $('.modal-dialog').draggable();
});


/**
 * 确认对话框组件
 * 
 * @param msg 对话框显示信息
 * @param okFunction 回调方法名
 * @param data 回调方法的参数
 * @returns
 * @author jihuaizhi 2017/6/23
 */
function showConfirm(msg, callback, data) {
	layer.confirm(msg, {
		title : "确认信息",
		offset : '30px',
		btn : [
				'确定', '取消'
		]
	}, function() {
		layer.closeAll('dialog');
		callback(data);
	}, function() {
	});
}


/**
 * 设置ajax请求公共参数，如果ajax请求设置了参数，则覆盖本函数的默认设置 对ajax请求错误进行统一异常处理,若$.ajax请求自定义了error回调，则不会执行本函数，而是执行自定义的回调函数
 * 
 * @returns
 */
$(function() {
	$.ajaxSetup({
		aysnc : true,
		timeout : 100000,
		type : 'Post',
		contentType : "application/json;charset=utf-8",
		dataType : 'json',
		error : function(jqXHR) {
			// 统一跳转至错误信息页面，也可以根据不同错误码分别处理
			switch (jqXHR.status) {
			case (404):
				sessionStorage.setItem("errMessage", "ERR-404：访问的资源不存在！" + jqXHR.message);
				window.location.href = '/views/error/404.html';
				break;
			case (500):
				sessionStorage.setItem("errMessage", "ERR-500：服务器系统内部错误！" + jqXHR.message);
				window.location.href = '/views/error/500.html';
				break;
			default:
				sessionStorage.setItem("errMessage", "ERR-？？？：AJAX请求异常，未知错误！" + jqXHR.message);
				top.location.href = '/views/error/defaultException.html';
			}
		}
	});
});


/**
 * 自定义ajax请求，TODO 未调试完成 拦截$.ajax请求的success回调函数，在请求正常返回的情况下获取后台传递的错误信息并进行统一的处理
 * 在执行$.ajax请求自己的success回调函数前先执行本函数，拦截后台返回的错误列表，对特定的致命类型的（FATAL）错误进行分别或统一处理
 */
var ajax = $.ajax;
// 修改ajax方法的默认实现
$.ajax = function(opt) {
	var success = opt.success;
	// 对用户配置的success方法进行代理
	function ns(data) {
		for (var i = 0; i < data.errList.length; i++) {
			var eCode = data.errList[i].errCode;
			var eMessage = data.errList[i].errMessage;
			switch (eCode) {
			case ("FTL_001"):
				// 软件授权异常,跳转至错误信息页面
				sessionStorage.setItem("errorMessage", eCode + eMessage);
				top.location.href = '/views/error/defaultException.html';
				return;
			case ("FTL_002"):
				// 身份认证异常，强制提示信息，跳转至登录页面
				layer.confirm(eMessage, {
					title : "身份认证异常",
					offset : '30px',
					area : [
							'300px', '200px'
					],
					btn : [
						'确定'
					]
				}, function() {
					top.location.href = '/login.html';
				});
				return;
			case ("FTL_003"):
				// 权限检查异常，显示提示信息
				layer.confirm(eMessage, {
					title : "权限检查异常",
					offset : '30px',
					area : [
							'300px', '200px'
					],
					btn : [
						'确定'
					]
				}, function() {
					history.back();
				});
				return;
			case ("FTL_999"):// 其它未知异常
				layer.confirm(eMessage, {
					title : "服务端异常",
					offset : '30px',
					area : [
							'300px', '200px'
					],
					btn : [
						'确定'
					]
				});
				return;
			}
		}
		//其它未处理异常,直接显示后台错误
		if (data.errList.length > 0) {
			layer.error(getErrString(data.errList));
		}
		return success.apply(this, arguments);
	}
	// 代理嵌入调用
	opt.success = ns;
	return ajax(opt);
}

/**
 * 将表单数据序列化为JSON字符串，便于作为参数提交Ajax请求
 */
$.fn.formToJsonString = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name] !== undefined) {
			if (!o[this.name].push) {
				o[this.name] = [
					o[this.name]
				];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	// 当未选择radio或checkbox的时候,拼name部分进返回的字符串
	var $radio = $('input[type=radio],input[type=checkbox]', this);
	$.each($radio, function() {
		if (!o.hasOwnProperty(this.name)) {
			o[this.name] = '';
		}
	});
	return JSON.stringify(o);
};


/**
 * datatable组件的本地化语言设置常量
 */
var TABLE_LANGUAGE = {
	language : {
		sProcessing : "处理中...",
		sLengthMenu : "显示 _MENU_ 项结果",
		sZeroRecords : "没有匹配结果",
		sInfo : "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
		sInfoEmpty : "显示第 0 至 0 项结果，共 0 项",
		sInfoFiltered : "(由 _MAX_ 项结果过滤)",
		sInfoPostFix : "",
		sSearch : "搜索:",
		sUrl : "",
		sEmptyTable : "无 数 据",
		sLoadingRecords : "载入中...",
		sInfoThousands : ",",
		oPaginate : {
			sFirst : "首页",
			sPrevious : "上页",
			sNext : "下页",
			sLast : "末页"
		},
		"oAria" : {
			"sSortAscending" : ": 以升序排列此列",
			"sSortDescending" : ": 以降序排列此列"
		},
		select : {
			rows : "%d 行 被选中"
		}
	}
};

/**
 * 表格控件全局配置
 */
$.extend($.fn.dataTable.defaults, TABLE_LANGUAGE, {
	// 表格排序
	ordering : true,
	// 显示每页数量的选项
	bLengthChange : false,
	// 分页按钮
	pagingType : "simple_numbers",
	// 页脚信息
	info : false,
	// 表格可被销毁重建
	destroy : true,
	// 自动调整列宽
	autoWidth : false,
	// 取消默认排序查询,否则复选框一列会出现小箭头
	order : [],
	// 原生搜索
	searching : false,
	// 是否显示分页信息
	paging : true,
	// 行选择器：单选
	select : {
		style : 'single'
	}
});


/**
 * 将数据封装为dhtmlx tree控件所需的格式返回
 * 
 * @param arrayData
 * @param pidVal
 * @param pid
 * @param id
 * @param text
 * @returns
 */
function getTreeJsonObj(arrayData, pidVal, pid, id, text) {
	var tmp = getTreeJson(arrayData, pidVal, pid, id, text);
	var menuObj = {
		"id" : "",
		"item" : tmp
	};
	return menuObj;
}

/**
 * 将数组转换为树形结构的JSON字符串,经过getTreeJsonObj方法再处理后提供给tree控件作为显示数据用 
 * 递归算法实现 ，本方法可直接提供给treeview控件作为显示数据使用
 * 
 * @param arrayData 对象数组,对象至少包含名称为pid,id,text的属性
 * @param pidVal 父级ID的值
 * @param pid pid属性名
 * @param id id属性名
 * @param text text属性名
 * @returns
 */
function getTreeJson(arrayData, pidVal, pid, id, text) {
	var result = [], temp;
	for (var i = 0; i < arrayData.length; i++) {
		if (eval("arrayData[i]." + pid) == pidVal) {
			// 树节点上的自定义属性
			var userdata = [
				{
					"name" : pid,
					"content" : eval("arrayData[i]." + pid)
				}
			];
			var obj = {
				"id" : eval("arrayData[i]." + id),
				"text" : eval("arrayData[i]." + text),
				"userdata" : userdata
			};
			temp = getTreeJson(arrayData, eval("arrayData[i]." + id), pid, id, text);
			if (temp.length > 0) {
				obj.item = temp;
			}
			result.push(obj);
		}
	}
	return result;
}


/**
 * 初始化dhtmlX Tree对象，根据参数或者不同展示类型的实例
 * 
 * @param divIdtree控件在页面的占位DIV的ID
 * @param jsonObj tree控件的json数据
 * @param isDrop 是否允许拖拽
 * @param isCheck 是否允许显示checkBox
 * @param isSmartCheck 是否允许显示父子级联动勾选 三状态checkBox
 * @returns
 */
function getTreeObject(divId, jsonObj, isDrop, isCheck, isSmart) {
	var treeObject = new dhtmlXTreeObject(divId, "100%", "100%", "");
	treeObject.setImagePath("/plugins/dhtmlxTree_v51_std/skins/skyblue/imgs/dhxtree_skyblue/");
	treeObject.setSkin('dhx_skyblue');
	treeObject.enableHighlighting(true);
	if (isDrop) {
		treeObject.setDragBehavior("complex", true);
		treeObject.enableDragAndDrop(true, true);
	}
	if (isCheck) {
		treeObject.enableCheckBoxes(true, true);
	}
	if (isSmart) {
		treeObject.enableThreeStateCheckboxes(true);
		treeObject.enableSmartCheckboxes(true);
	}
	treeObject.parse(jsonObj, "json");
	return treeObject;
}


/**
 * 将对象数组转换为Select2组件显示所需要的数据格式
 * 
 * @param arrayData 对象数组,对象至少包含名称为id,text的属性
 * @param id 唯一标识属性名称
 * @param text 显示用属性名称
 * @returns 
 */

function getSelect2Array(arrayData, id, text) {
	var result = new Array();
	for (var i = 0; i < arrayData.length; i++) {
		var opt = {};
		opt.id = eval("arrayData[i]." + id);
		opt.text = eval("arrayData[i]." + text);
		result.push(opt);
	}
	return result;
}


/**
 * 将数组形式保存的错误信息,转换为字符换用于显示提示信息
 * 
 * @param errList
 * @returns
 */
function getErrString(errList) {
	var str = "";
	for (var i = 0; i < errList.length; i++) {
		str += errList[i].errCode + " : " + errList[i].errMessage + " <br>";
	}
	return str;
}
