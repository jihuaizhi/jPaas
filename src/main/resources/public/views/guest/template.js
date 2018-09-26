//表格的双击事件
$("#data_table").on("dblclick", "tr", function(e) {
    console.log(e);
    $('#btn_update').trigger("click");
})
