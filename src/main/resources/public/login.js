//页面初始化块
$(function() {
	$('input').iCheck({
		checkboxClass : 'icheckbox_square-blue',
		radioClass : 'iradio_square-blue',
		increaseArea : '20%'
	});
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
