$(function() {
	$('input').iCheck({
		checkboxClass : 'icheckbox_square-blue',
		radioClass : 'iradio_square-blue',
		increaseArea : '20%'
	});
});


$("#btn_login").click(function() {
	$.ajax({
		url : "/login",
		data : $("#data_form").formToJsonString(),
		success : function(data) {
			console.log(data);
			if (data.success == true) {
				window.location.href = "/views/index.html";
			}
		}
	});

});
