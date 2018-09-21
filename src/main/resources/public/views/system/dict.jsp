<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String basePath = request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>字典维护</title>
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
          <!-- 左侧字典树 -->
          <div class="col-md-4">
            <div class="box box-primary" style="height: 800px;">
              <div class="box-header with-border">
                <h5 class="box-title">字典列表</h5>
                <div class="box-tools pull-left">
                  <div class="btn-group">
                    <button id="btn_refresh_dict" type="button" class="btn btn-primary btn-sm">刷</button>
                    <button id="btn_insert_dict" type="button" class="btn btn-primary btn-sm">增</button>
                    <button id="btn_update_dict" type="button" class="btn btn-primary btn-sm ">修</button>
                    <button id="btn_delete_dict" type="button" class="btn btn-primary btn-sm">删</button>
                  </div>
                </div>
              </div>
              <div class="box-body">
                <div id="data_tree" style="height: 720px"></div>
              </div>
            </div>
          </div>
          <!-- 右侧字典值编辑表格 -->
          <div class="col-md-8">
            <div class="box box-primary" style="height: 800px;">
              <div class="box-header with-border">
                <h3 class="box-title">字典数据值列表</h3>
                <div class="box-tools pull-left">
                  <div class="btn-group">
                    <button id="btn_refresh_dict_data" type="button" class="btn btn-sm btn-primary">刷</button>
                    <button id="btn_insert_dict_data" type="button" class="btn btn-sm btn-primary">新</button>
                    <button id="btn_update_dict_data" type="button" class="btn btn-sm btn-primary">修</button>
                    <button id="btn_delete_dict_data" type="button" class="btn btn-sm btn-primary">删</button>
                  </div>
                </div>
              </div>
              <!-- /.box-header -->
              <div class="box-body">
                <table id="data_table" class="display table table-striped table-bordered table-hover table-checkable">
                  <thead>
                    <tr>
                      <th>字典数据项ID</th>
                      <th>所属字典ID</th>
                      <th>数据项编码</th>
                      <th>数据项名称</th>
                      <th>排序号</th>
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

  <!--     新建/編輯字典  start -->
  <form id="data_form" style="display: none">
    <input id="dictuuid" name="dictuuid" type="hidden" value="">
    <div class="box">
      <div class="box-body">
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <div class="form-group">
                <label class="control-label required">字典编码</label>
                <input id="dictCode" name="dictCode" maxlength="6" type="text" class="form-control" placeholder="格式：CD_000">
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label class="control-label required">字典名称</label>
              <input id="dictName" name="dictName" type="text" maxlength="20" class="form-control">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label class="control-label required">字典状态</label>
              <div class="radio">
                <input name="dataState" value="1" type="radio">
                <label class="radio-inline"> 有效 </label>
                <input name="dataState" value="2" type="radio">
                <label class="radio-inline"> 无效 </label>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="box-footer">
        <div class="row pull-right">
          <div class="col-md-12">
            <button id="btn_save_dict" type="button" class="btn btn-sm btn-primary">保存</button>
            <button name="btn_close_form" type="button" class="btn btn-default btn-sm">关闭</button>
          </div>
        </div>
      </div>
    </div>
  </form>
  <!--     新建/編輯字典  end -->

  <!-- 新建/編輯字典数据项  start-->
  <form id="data_form_1" style="display: none">
    <input id="uuid" name="uuid" type="hidden" value="">
    <input id="parentId" name="parentId" type="hidden" value="">
    <div class="box box-primary  ">
      <div class="box-body">
        <div class="row">
          <div class="col-md-12">
            <div class="form-group">
              <div class="form-group">
                <label class="control-label required">字典数据项编码</label>
                <input id="dictDataCode" name="dictDataCode" maxlength="20" type="text" class="form-control" placeholder="格式：字母或数字的组合">
              </div>
            </div>
          </div>
          <div class="col-md-12">
            <div class="form-group">
              <label class="control-label required">字典数据项名称</label>
              <input id="dictDataName" name="dictDataName" type="text" maxlength="20" class="form-control">
            </div>
          </div>
          <div class="col-md-12">
            <div class="form-group">
              <label class="control-label required">字典数据项排序号</label>
              <input id="sortNum" name="sortNum" type="text" maxlength="2" class="form-control" placeholder="格式：0 ~ 99 的数字">
            </div>
          </div>
          <div class="col-md-12">
            <div class="form-group">
              <label class="control-label required">字典数据项状态</label>
              <div class="radio">
                <input name="dataState" value="1" type="radio">
                <label class="radio-inline"> 有效 </label>
                <input name="dataState" value="2" type="radio">
                <label class="radio-inline"> 无效 </label>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="box-footer">
        <div class="row pull-right">
          <div class="col-md-12">
            <button id="btn_save_dict_data" type="button" class="btn btn-sm btn-primary">保存</button>
            <button name="btn_close_form" type="button" class="btn btn-default btn-sm">关闭</button>
          </div>
        </div>
      </div>
    </div>
  </form>
  <!-- 新建/編輯字典数据项  end-->

  <!-- 引入公共js文件 -->
  <%@include file="/include/script.jsp"%>
  <!-- 引入页面js文件 -->
  <script src="views_platform/common/dict.js"></script>
</body>
</html>