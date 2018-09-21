<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String basePath = request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>角色维护</title>
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
          <div class="col-md-12">
            <!-- 数据表格 start-->
            <div class="box box-primary" style="height: 800px;">
              <div class="box-header with-border">
                <h5 class="box-title">角色列表</h5>
                <div class="box-tools pull-left">
                  <div class="btn-group">
                    <button id="btn_insert" type="button" class="btn btn-primary btn-sm">新</button>
                    <button id="btn_update" type="button" class="btn btn-primary btn-sm">修</button>
                    <button id="btn_delete" type="button" class="btn btn-primary btn-sm">删</button>
                    <button id="btn_user" type="button" class="btn btn-primary btn-sm">查看角色用户</button>
                    <button id="btn_sort" type="button" class="btn btn-sm btn-primary">启用拖拽排序</button>
                  </div>
                </div>
              </div>
              <div class="box-body">
                <table id="data_table" class="display table table-striped table-bordered table-hover table-checkable">
                  <thead>
                    <tr>
                      <th>角色ID</th>
                      <th>排序号</th>
                      <th>序号</th>
                      <th>角色编码</th>
                      <th>角色名称</th>
                      <th>角色描述</th>
                      <th>状态</th>
                    </tr>
                  </thead>
                  <tbody></tbody>
                </table>
              </div>
            </div>
            <!-- 数据表格 end  -->
          </div>
        </div>
      </section>
      <!-- /.页面内容 -->
    </div>
  </div>
  <!-- ./页面最外层容器 -->
  <!-- 引入公共js文件 -->
  <%@include file="/include/script.jsp"%>
  <!-- 引入页面js文件 -->
  <script src="views_platform/security/role_manage_list.js"></script>
</body>
</html>