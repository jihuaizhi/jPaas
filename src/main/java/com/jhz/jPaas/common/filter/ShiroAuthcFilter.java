package com.jhz.jPaas.common.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jhz.jPaas.common.JPConstant;
import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.common.WebDevUtils;
import com.jhz.jPaas.entity.AccountEntity;

import net.sf.json.JSONObject;

/**
 * 扩展shiro认证过滤器
 * 
 * @author jihuaizhi
 * @since 2018-10-01
 */
public class ShiroAuthcFilter extends FormAuthenticationFilter {

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * 验证是否正常登录系统
	 * 
	 * @author jihuaizhi
	 * @param req
	 * @param resp
	 * @param arg2
	 * @return
	 */
	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
		HttpServletRequest httpRequest = (HttpServletRequest) request;

		AccountEntity currentAccountEntity = (AccountEntity) SecurityUtils.getSubject().getPrincipal();

		Subject subject = getSubject(request, response);
		// 如果已经登录,则通过验证
		if (null != subject.getPrincipals()) {
			logger.info("当前账号:" + currentAccountEntity.getAccountCode() + " 已经登录系统,正在访问URL:"
					+ httpRequest.getServletPath());
			return true;
		}
		logger.info("当前未登录系统");
		return false;
	}

	/**
	 * 身份认证异常
	 */
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws IOException {
		if (WebDevUtils.isAjax(request)) {
			// ajax请求
			ReturnModel returnModel = new ReturnModel();
			returnModel.putError(JPConstant.FTL_002, "当前账号未登录系统，请重新登录!");
			response.setCharacterEncoding("UTF-8");// 设置编码
			response.setContentType("application/json");// 设置返回类型
			PrintWriter out = response.getWriter();
			out.println(JSONObject.fromObject(returnModel).toString());
		} else {
			// TODO http请求的情况下 跳转至页面时如何带数据到页面???
			WebUtils.issueRedirect(request, response, "/views/error/noLogin.html");
		}

		return false;
	}

}