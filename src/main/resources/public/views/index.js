// 页面初始化块
$(function() {
	// 加载菜单
	loadMenu();
	loadCurrentUser();
	$('iframe#content_iframe').attr('src', "");

	reinitIframe();
	$('html , body').animate({
		scrollTop : 0
	}, 'slow');

});

// 窗体缩放后调整iframe高度
$(window).resize(function() {
	reinitIframe();
});


// iframe加载完成后调整高度
$("#content_iframe").on("load", function() {
	reinitIframe();
});


// iframe高度自适应
function reinitIframe() {
	var iframe = document.getElementById("content_iframe");
	try {
		var bHeight = iframe.contentWindow.document.body.offsetHeight;
		var dHeight = iframe.contentWindow.document.documentElement.offsetHeight;
		var height = Math.min(bHeight, dHeight);
		if (height < 1080) {
			height = 1080;
		}
		iframe.height = height;
		$('body').height(height);
	} catch (ex) {
	}
}

// 点击左上角LOGO,回到主页
$("#btn_main").click(function() {
	$('iframe#content_iframe').attr('src', "");
})

// 注销系统,shiro自动处理/logout请求
$("#btn_logout").click(function() {
	window.location.href = "/logout";
})


// 加载登陆者信息
function loadCurrentUser() {
	$.ajax({
		url : "/getloginUser",
		success : function(data) {
			if (data.success == true) {
				$("#userName").html(data.account.accountName);
				var df = data.account.dataState;
				if (df == "1") {
					$("#dataState").html("状态:正常");
				} else if (df == "0") {
					$("#dataState").html("状态:停用");
				}
				$("#startTime").html("登录时间:" + new Date(data.startTime).Format("yyyy-MM-dd hh:mm:ss"));
				$("#accountCode").html(data.account.accountCode);
				$("#accountName").html(data.account.accountName);

			}
		}
	});
}


// 加载菜单项
function loadMenu() {
	$.ajax({
		url : "/menu/getUserMenuList",
		success : function(data) {
			if (data.success == true) {
			    var menuList=data.objList;
				var jsonString = getTreeMenuHtml(menuList, "");
 $("#menu_data").html(jsonString);
// $("#menu_data").prepend(jsonString);
			}
		}
	});

}


// 将后台请求的菜单数组数据转换为树形菜单htnml
function getTreeMenuHtml(arrayData, pid) {
 var result = "";
 for (var i = 0; i < arrayData.length; i++) {
     var str = "";
     if (arrayData[i].parentUuid == pid) {
         var temp = getTreeMenuHtml(arrayData, arrayData[i].uuid);
         if (temp.length > 0) {
             str += "<li class='treeview'>";
         }else{
             str += "<li>";
         }
             str += "    <a href='" + arrayData[i].menuLink + "' target='content_iframe'>";
         if (arrayData[i].menuIcon == null || arrayData[i].menuIcon == "") {
             str += "        <i class='ion-ios-list-outline'></i>";
         } else {
             str += "        <i class='" + arrayData[i].menuIcon + "'></i>";
         }
         str += "        <span>" + arrayData[i].menuName + "</span>";
         if (temp.length > 0) {
             str += "        <span class='pull-right-container'>";
             str += "            <i class='fa fa-angle-left pull-right'></i>";
             str += "        </span>";
         }
         str += "    </a>";
         if (temp.length > 0) {
             str += "<ul class='treeview-menu'>";
             str += temp;
             str += "</ul>"
         }
         str += "</li>";
     }
     result += str;
 }
 return result;
}































// 菜单tips提示信息
$("#testMenu").mouseover(function() {
	layer.tips('测试页面,可以随便修改和调试', "#testMenu", {
		tips : [
				2, '#FFA54F'
		],
		time : 5000
	});
})
$("#testMenu").mouseleave(function() {
	layer.closeAll();
})




Date.prototype.Format = function (fmt) { // author: meizz
var o = {
"M+": this.getMonth() + 1,                      // 月份
"d+": this.getDate(),                           // 日
"h+": this.getHours(),                          // 小时
"m+": this.getMinutes(),                        // 分
"s+": this.getSeconds(),                        // 秒
"q+": Math.floor((this.getMonth() + 3) / 3),    // 季度
"S": this.getMilliseconds()                     // 毫秒
};
if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
for (var k in o)
if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
return fmt;
}
