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

//接收回车按键事件,触发保存按钮点击事件
$("body").keydown(function(e) {
	if (e.keyCode == 13) {
		$('#btn_login').trigger("click");
	}
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
