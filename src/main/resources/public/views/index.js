// 页面初始化块
$(function() {
    // 加载菜单
// loadMenu();
// loadCurrentUser();
 $('iframe#content_iframe').attr('src', "/views/auth/account.html");

	
	$('body').layout('fix');
// reinitIframe();
	$('html , body').animate({
		scrollTop : 0
	}, 'slow');
     
});

$(window).resize(function() {
	reinitIframe();
	});

$("#content_iframe").on("load",function() {
	reinitIframe();
});



// iframe高度自适应
function reinitIframe() {
    var iframe = document.getElementById("content_iframe");
    try {
        var bHeight = iframe.contentWindow.document.body.offsetHeight;
        var dHeight = iframe.contentWindow.document.documentElement.offsetHeight;
        var height = Math.min(bHeight, dHeight);
        if(height<1080 ){
            height=1080;
        }
		iframe.height = height;
		$('body').height(height);
    } catch (ex) {
    }
}


// 加载菜单项
function loadMenu() {
    $.ajax(
        { url : "menu/queryListByUser",
        type : "Post",
        contentType : "application/json;charset=utf-8",
        dataType : "json",
        success : function(data) {
            if (data.success == true) {
                var objList = data.objList;
                var jsonString = getTreeMenuHtml(objList, "");
                $("#menu_data").html(jsonString);
                // 默认加载第一个菜单项的内容
                $('iframe#content_iframe').attr('src', objList[0].menuLink); 
            }
        },
        error : function(XMLHttpRequest, textStatus, errorThrown) {
            layer.error("服务器通讯失败！");
        },
        complete : function(XMLHttpRequest, textStatus) {
        } });
    
}

// 加载登陆者信息
function loadCurrentUser() {
    $.ajax(
        { url : "authentication/getloginuser",
        success : function(data) {
            if (data.success == true) {
                $("#userName").html(data.loginUser.userName);
                var df = data.loginUser.dataState;
                if (df == "1") {
                    $("#dataState").html("启用");
                } else if (df == "0") {
                    $("#dataState").html("启用");
                } else {
                    $("#dataState").html("异常");
                }
                $("#startTime").html(new Date(data.startTime).Format("yyyy-MM-dd hh:mm:ss"));
                

            }
        } });
}



// 菜单tips提示信息
$("#testMenu").mouseover(function() {
    layer.tips('测试页面,可以随便修改和调试', "#testMenu",
        { tips : [ 2, '#FFA54F' ],
        time : 5000 });
})
$("#testMenu").mouseleave(function() {
    layer.closeAll();
})

// 将后台请求的菜单数组数据转换为树形菜单htnml
function getTreeMenuHtml(arrayData, pid) {
    var result = "";
    for (var i = 0; i < arrayData.length; i++) {
        var str = "";
        if (arrayData[i].parentId == pid) {
            var temp = getTreeMenuHtml(arrayData, arrayData[i].uuid);

            str += "<li>";
            str += "    <a href='" + arrayData[i].menuLink + "' target='content_iframe'>";
            if (arrayData[i].menuIcon == null || arrayData[i].menuIcon == "") {
                str += "        <i class='ion-ios-list-outline'></i>";
            } else {
                str += "        <i class='" + arrayData[i].menuIcon + "'></i>";
            }
            str += "        <span class='title'>" + arrayData[i].menuName + "</span>";
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

// 注销系统
$("#btn_logout").click(function() {
    $.ajax(
        { url : "authentication/logout",
        success : function(data) {
            if (data.success == true) {
                window.location.href = getRootPath() +"/views_login/login.jsp";
            }
        } });
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

/**
 * 取得应用程序访问路径
 * 
 * @returns
 */
function getRootPath(){
    // 获取当前网址，如： http://localhost:8088/test/test.jsp
    var curPath=window.document.location.href;
    // 获取主机地址之后的目录，如： test/test.jsp
    var pathName=window.document.location.pathname;
    var pos=curPath.indexOf(pathName);
    // 获取主机地址，如： http://localhost:8088
    var localhostPaht=curPath.substring(0,pos);
    // 获取带"/"的项目名，如：/test
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    return(localhostPaht+projectName);
}