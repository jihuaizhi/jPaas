package com.jhz.jPaas.common.filter;

import java.io.PrintWriter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;

import com.jhz.jPaas.common.JPConstant;
import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.common.WebDevUtils;

import net.sf.json.JSONObject;

/**
 * 扩展shiro认证过滤器
 * 
 * @author jihuaizhi
 * @since 2018-10-01
 */
public class ShiroAuthcFilter extends FormAuthenticationFilter {

	// private final Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * 验证是否正常登录系统
	 * 
	 */
	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {

		boolean isAccessAllowed = super.isAccessAllowed(request, response, mappedValue);
		return isAccessAllowed;
	}

	/**
	 * 身份认证异常处理
	 * 
	 */
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
		if (WebDevUtils.isAjax(request)) {
			// ajax请求的场合,返回json
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
			return super.onAccessDenied(request, response);
		}

	}

}