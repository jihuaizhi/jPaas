<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String basePath = request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>菜单维护</title>
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<base href=" <%=basePath%>">
<!-- 引入公共css文件 -->
<link rel="stylesheet" href="static/style.css">

<style>
</style>
</head>
<body class="skin-purple hold-transition sidebar-mini">
  <!-- 页面最外层容器 -->
  <div class="wrapper">
    <!-- 页面内容部分左侧留出菜单位置,设置页面背景色 -->
    <div class="content-wrapper-inner">
      <!-- 页面内容 -->
      <section class="content">
        <div class="row">
          <div class="col-md-4">
            <div class="box box-primary" style="height: 800px;">
              <div class="box-header with-border">
                <h5 class="box-title">菜单树</h5>
                <div class="box-tools pull-left">
                  <div class="btn-group">
                    <button id="btn_open" type="button" class="btn btn-primary btn-sm">展</button>
                    <button id="btn_insert" type="button" class="btn btn-primary btn-sm">增</button>
                    <button id="btn_update" type="button" class="btn btn-primary btn-sm ">修</button>
                    <button id="btn_delete" type="button" class="btn btn-primary btn-sm">删</button>
                  </div>
                </div>
              </div>
              <div class="box-body">
                <div id="data_tree" style="height: 720px;"></div>
              </div>
            </div>
          </div>
          <!-- 表格 -->
          <div class="col-md-8">
            <div id="tree_box" class="box box-primary" style="height: 800px;">
              <div class="box-header with-border">
                <h5 class="box-title">下级菜单列表</h5>
                <div class="box-tools pull-left">
                  <div class="btn-group">
                    <button id="btn_sort" type="button" class="btn btn-sm btn-primary">启用拖拽排序</button>
                  </div>
                </div>
              </div>
              <!-- /.box-header -->
              <div class="box-body">
                <table id="data_table" class="display table table-striped table-bordered table-hover table-checkable">
                  <thead>
                    <tr>
                      <th>菜单ID</th>
                      <th>排序号</th>
                      <th>序号</th>
                      <th>菜单名称</th>
                      <th>菜单链接</th>
                      <th>菜单图标</th>
                      <th>状态</th>
                    </tr>
                  </thead>
                  <tbody></tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- /.页面内容 -->
    </div>
  </div>
  <!-- ./页面最外层容器 -->

  <!--     新建/編輯菜单  start -->
  <form id="data_form" style="display: none">
    <input id="uuid" name="uuid" type="hidden">
    <input id="parentId" name="parentId" type="hidden">
    <div class="box">
      <div class="box-body">
        <div class="row">
          <div class="col-md-12">
            <div class="form-group">
              <div class="form-group">
                <label class="control-label required">菜单名称</label>
                <input id="menuName" name="menuName" maxlength="20" type="text" class="form-control" placeholder="菜单的显示名称">
              </div>
            </div>
          </div>
          <div class="col-md-12">
            <div class="form-group">
              <label class="control-label required">菜单链接</label>
              <input id="menuLink" name="menuLink" type="text" maxlength="100" class="form-control" placeholder="菜单的链接页面,如果是父级菜单请填写 #">
            </div>
          </div>
          <div class="col-md-12">
            <div class="form-group">
              <label class="control-label">菜单图标</label>
              <input id="menuIcon" name="menuIcon" type="text" maxlength="100" class="form-control" placeholder="菜单图标class名称,格式 : fa fa-bars 或者 ion-arrow-right-a">
              <span>本系统可以使用以下两种图标库定制菜单图标:</span>
              <br>
              <a herf="http://fontawesome.dashgame.com" target="_blank">
                <span>Font Awesome图标库&nbsp;&nbsp;图标样式css示例 : fa fa-bars</span>
              </a>
              <br>
              <a herf="http://ionicons.com" target="_blank">
                <span>ionicons图标库:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;图标样式css示例 : ion-arrow-right-a</span>
              </a>
              <br>

              <label class="control-label text-info"> </label>
            </div>
          </div>
          <div class="col-md-12">
            <div class="form-group">
              <label class="control-label required">菜单状态</label>
              <div class="radio">
                <input name="dataState" value="1" type="radio">
                <label class="radio-inline">启用 </label>
                <input name="dataState" value="0" type="radio">
                <label class="radio-inline">停用</label>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="box-footer">
        <div class="row pull-right">
          <div class="col-md-12">
            <button id="btn_save" type="button" class="btn btn-sm btn-primary">保存</button>
            <button name="btn_close_form" type="button" class="btn btn-default btn-sm">关闭</button>
          </div>
        </div>
      </div>
    </div>
  </form>
  <!--     新建/編輯字典  end -->

  <!-- 引入公共js文件 -->
  <%@include file="/include/script.jsp"%>
  <!-- 引入页面js文件 -->
  <script src="views_platform/security/menu.js"></script>
</body>
</html>