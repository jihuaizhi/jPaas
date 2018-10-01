package com.jhz.jPaas.common.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.StringUtils;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;
import org.apache.shiro.web.util.WebUtils;

import com.jhz.jPaas.common.JPConstant;
import com.jhz.jPaas.common.ReturnModel;

import net.sf.json.JSONObject;

/**
 * 扩展shiro过滤器<br>
 * 作用:<br>
 * 解决重复账号登录问题,同一个账号,后登录的会将先登录的session清除
 * 
 * @author jihuaizhi
 * @since 2018-10-01
 */
public class ShiroAuthcFilter extends AuthorizationFilter {

	/**
	 * 验证是否正常登录系统
	 * 
	 * @author jihuaizhi
	 * @param req
	 * @param resp
	 * @param arg2
	 * @return
	 * @throws Exception
	 */
	@Override
	protected boolean isAccessAllowed(ServletRequest req, ServletResponse resp, Object arg2) throws Exception {
		Subject subject = getSubject(req, resp);
		// 如果已经登录,则通过验证
		if (null != subject.getPrincipals()) {
			return true;
		}
		return false;
	}

	/**
	 * 身份认证异常
	 */
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws IOException {
		if (isAjax((HttpServletRequest) request)) {
			// ajax请求
			ReturnModel returnModel = new ReturnModel();
			returnModel.putError(JPConstant.FTL_002, "身份认证异常，请重新登录!");
			PrintWriter out = response.getWriter();
			out.println(JSONObject.fromObject(returnModel));
		} else {
			String unauthorizedUrl = getUnauthorizedUrl();
			if (StringUtils.hasText(unauthorizedUrl)) {
				WebUtils.issueRedirect(request, response, unauthorizedUrl);
			} else {
				WebUtils.toHttp(response).sendError(401);
			}
		}

		return false;
	}

	/**
	 * 验证是否是ajax异步请求
	 * 
	 * @author jihuaizhi
	 * @param request
	 * @return
	 */
	private boolean isAjax(HttpServletRequest request) {
		String header = request.getHeader("X-Requested-With");
		if (null != header && "XMLHttpRequest".endsWith(header)) {
			return true;
		}
		return false;
	}
}