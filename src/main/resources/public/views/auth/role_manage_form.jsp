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

        <!-- 表单 start-->
        <form id="data_form">
          <input id="uuid" name="uuid" type="hidden" value="">
          <input id="menuIds" name="menuIds" type="hidden" value="">
          <input id="permissionIds" name="permissionIds" type="hidden" value="">
          <div class="box box-primary" style="min-height: 800px;">
            <div class="box-header with-border">
              <div class="row">
                <div class="col-md-12">
                  <h5 id="title" class="box-title">角色信息</h5>
                  <div class="box-tools pull-right">
                    <div class="btn-group">
                      <button id="btn_save" type="button" class="btn btn-primary btn-sm">保存</button>
                      <button id="btn_back" type="button" class="btn btn-default btn-sm">返回</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="box-body">
              <div class="row">
                <div class="col-md-4">
                  <div class="col-md-12">
                    <div class="form-group">
                      <label class="control-label required">角色编码</label>
                      <input id="roleCode" name="roleCode" readonly type="text" maxlength="20" class="form-control" placeholder="角色的编码">
                    </div>
                  </div>
                  <div class="col-md-12">
                    <div class="form-group">
                      <label class="control-label required">角色名称</label>
                      <input id="roleName" name="roleName" type="text" maxlength="20" class="form-control" placeholder="角色的中文显示名称">
                    </div>
                  </div>
                  <div class="col-md-12">
                    <div class="form-group">
                      <label class="control-label required">角色状态</label>
                      <div class="radio">
                        <input name="dataState" value="1" type="radio">
                        <label class="radio-inline"> 启用 </label>
                        <input name="dataState" value="0" type="radio">
                        <label class="radio-inline"> 停用 </label>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-12">
                    <div class="form-group">
                      <label class="control-label">角色描述</label>
                      <textarea id="roleDescription" name="roleDescription" maxlength="200" class="form-control" rows="3" placeholder="角色职责的详细说明"></textarea>
                    </div>
                  </div>
                </div>
                <div class="col-md-8">
                  <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                      <li class="active">
                        <a href="#tab_1" data-toggle="tab">菜单授权</a>
                      </li>
                      <li>
                        <a href="#tab_2" data-toggle="tab">URL授权</a>
                      </li>
                      <li>
                        <a href="#tab_3" data-toggle="tab">操作授权</a>
                      </li>
                    </ul>
                    <div class="tab-content">
                      <div class="tab-pane active" id="tab_1">
                        <div id="data_tree_1" style="height: 100%;"></div>
                      </div>
                      <div class="tab-pane" id="tab_2">
                        <table id="data_table" class="display table table-striped table-bordered table-hover table-checkable">
                          <thead>
                            <tr>
                              <th>ID</th>
                              <th class="text-center"><input type="checkbox" id="checkAll" class="select-checkbox"></th>
                              <th>权限标识</th>
                              <th>权限名称</th>
                            </tr>
                          </thead>
                          <tbody></tbody>
                        </table>
                      </div>
                      <div class="tab-pane" id="tab_3">
                        <div id="data_tree_3" style="height: 200px;">开发中...</div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
        </form>
        <!-- 表单 end-->

      </section>
      <!-- /.页面内容 -->
    </div>
  </div>
  <!-- ./页面最外层容器 -->
  <!-- 引入公共js文件 -->
  <%@include file="/include/script.jsp"%>
  <!-- 引入页面js文件 -->
  <script src="views_platform/security/role_manage_form.js"></script>
</body>
</html>