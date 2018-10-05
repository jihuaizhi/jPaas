package com.jhz.jPaas.common.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.filter.authz.PermissionsAuthorizationFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jhz.jPaas.common.JPConstant;
import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.common.WebDevUtils;
import com.jhz.jPaas.entity.RoleEntity;

import net.sf.json.JSONObject;

/**
 * @Desc 用于自定义过滤器，过滤用户请求是否被授权
 * @author jihuaizhi
 * @date 2018-10-01
 * @version
 */
public class ShiroPermsFilter extends PermissionsAuthorizationFilter {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	/*
	 * 拦截请求,判断是否具备访问权限
	 */
	@Override
	public boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue)
			throws IOException {
		HttpServletRequest httpReq = (HttpServletRequest) request;
		// 检查角色列表是否包含超级管理员角色
		if (SecurityUtils.getSubject().hasRole(RoleEntity.SUPER_ADMINISTRATOR)) {
			// 超级管理员角色的用户跳过所有权限检查
			logger.info("权限验证过滤器---URL:" + httpReq.getServletPath() + " 超级管理员:跳过检查");
			return true;
		}
		boolean isPermission = SecurityUtils.getSubject().isPermitted(httpReq.getServletPath());

		logger.info("权限验证过滤器---URL:" + httpReq.getServletPath() + " 验证结果:" + isPermission);
		return isPermission;
	}

	/**
	 * 会话超时或权限校验未通过的，返回错误信息
	 */
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws IOException {
		if (WebDevUtils.isAjax(request)) {
			// ajax请求的场合,返回json
			ReturnModel returnModel = new ReturnModel();
			returnModel.putError(JPConstant.FTL_003, "权限检查失败，请联系管理员授权!");
			response.setCharacterEncoding("UTF-8");// 设置编码
			response.setContentType("application/json");// 设置返回类型
			PrintWriter out = response.getWriter();
			out.println(JSONObject.fromObject(returnModel).toString());
			out.flush();
			out.close();
			return false;
		} else {
			// http请求的场合,跳转至登录页面
			return super.onAccessDenied(request, response);

		}
	}

}