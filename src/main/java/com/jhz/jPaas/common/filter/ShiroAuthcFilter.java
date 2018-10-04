package com.jhz.jPaas.common.filter;

import java.io.PrintWriter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
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
	 */
	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {

		boolean isAccessAllowed = super.isAccessAllowed(request, response, mappedValue);
		// TODO 调试用代码 start
		HttpServletRequest httpReq = (HttpServletRequest) request;
		AccountEntity entity = (AccountEntity) SecurityUtils.getSubject().getPrincipal();
		if (null != entity) {
			logger.info("登录验证过滤器---帐号:" + entity.getAccountCode() + " URL:" + httpReq.getServletPath() + " 验证结果:"
					+ isAccessAllowed);

		} else {
			logger.info("登录验证过滤器---帐号:null URL:" + httpReq.getServletPath() + " 验证结果:" + isAccessAllowed);
		}
		// 调试用代码 end
		return isAccessAllowed;
	}

	/**
	 * 身份认证异常处理
	 * 
	 */
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
		// ajax请求的场合,返回json
		if (WebDevUtils.isAjax(request)) {
			// ajax请求
			ReturnModel returnModel = new ReturnModel();
			returnModel.putError(JPConstant.FTL_002, "当前账号未登录系统，请重新登录!");
			response.setCharacterEncoding("UTF-8");// 设置编码
			response.setContentType("application/json");// 设置返回类型
			PrintWriter out = response.getWriter();
			out.println(JSONObject.fromObject(returnModel).toString());
			out.flush();
			out.close();
			return false;
		} else {
			// http请求的场合,跳转至登录页面
			// TODO http请求的情况下 跳转至页面时如何带数据到页面???
			// WebUtils.issueRedirect(request, response, "/views/error/noLogin.html");
			return super.onAccessDenied(request, response);
		}

	}

}