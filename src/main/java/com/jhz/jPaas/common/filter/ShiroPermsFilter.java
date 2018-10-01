package com.jhz.jPaas.common.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.StringUtils;
import org.apache.shiro.web.filter.authz.PermissionsAuthorizationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jhz.jPaas.common.JPConstant;
import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.entity.AccountEntity;

import net.sf.json.JSONObject;

/**
 * @Desc 用于自定义过滤器，过滤用户请求是否被授权
 * @author jihuaizhi
 * @date 2018-10-01
 * @version
 */
public class ShiroPermsFilter extends PermissionsAuthorizationFilter {

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public boolean isAccessAllowed(ServletRequest req, ServletResponse resp, Object arg2) {
		HttpServletRequest request = (HttpServletRequest) req;
		// 获取请求路径
		String path = request.getServletPath();
		Subject subject = getSubject(req, resp);
		if (null != subject.getPrincipal()) {
			// 超级管理员用户跳过所有权限授权检查
			if (subject.getPrincipal().toString().equals(AccountEntity.SUPER_ADMIN)) {
				return true;
			}
			if (subject.isPermitted(path)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 会话超时或权限校验未通过的，返回错误信息
	 */
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws IOException {
		if (isAjax((HttpServletRequest) request)) {
			// ajax请求
			ReturnModel returnModel = new ReturnModel();
			returnModel.putError(JPConstant.FTL_003, "权限校验失败，请联系管理员授权!");
			PrintWriter out = response.getWriter();
			out.println(JSONObject.fromObject(returnModel));
		} else {
			// 一般请求
			String unauthorizedUrl = getUnauthorizedUrl();
			if (StringUtils.hasText(unauthorizedUrl)) {
				WebUtils.issueRedirect(request, response, unauthorizedUrl);
			} else {
				WebUtils.toHttp(response).sendError(401);
			}
		}
		return false;
	}

	private boolean isAjax(HttpServletRequest request) {
		String header = request.getHeader("X-Requested-With");
		if (null != header && "XMLHttpRequest".endsWith(header)) {
			return true;
		}
		return false;
	}
}