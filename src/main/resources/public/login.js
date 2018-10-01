//页面初始化块
$(function() {

});

//登录按钮点击事件
$("#btn_login").click(function() {
	$.ajax({
		url : "/login",
		data : $("#data_form").formToJsonString(),
		success : function(data) {
			if (data.success == true) {
				window.location.href = "/views/index.html";
			}
		}
	});

});


//TODO 测试用
$("#test").click(function() {
	$.ajax({
		url : "/getloginUser",
		success : function(data) {
			if (data.success == true) {
				layer.success("ajax访问成功返回！");
			}
		}
	});

});
