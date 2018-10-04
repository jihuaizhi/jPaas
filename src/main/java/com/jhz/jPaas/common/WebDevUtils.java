package com.jhz.jPaas.common;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

/**
 * web开发工具类
 * 
 * @author jihuaizhi
 * @since 2018-10-03
 */
public class WebDevUtils {

	/**
	 * 验证是否是ajax异步请求
	 * 
	 * @param request
	 * @return
	 */
	public static boolean isAjax(ServletRequest request) {
		String header = ((HttpServletRequest) request).getHeader("X-Requested-With");
		if (null != header && "XMLHttpRequest".equalsIgnoreCase(header)) {
			return true;
		}
		return false;
	}
}