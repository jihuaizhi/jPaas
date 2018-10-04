//表格的双击事件
$("#data_table").on("dblclick", "tr", function(e) {
    console.log(e);
    $('#btn_update').trigger("click");
})

// 模态框接收回车按键事件,触发保存按钮点击事件
$("#data_modal").keydown(function(e) {
    if (e.keyCode == 13) {
        $('#btn_save').trigger("click");
    }
});