package com.jhz.jPaas.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * 测试用过滤器
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
public class TestFilter implements Filter {

	// private final Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest srequest, ServletResponse sresponse, FilterChain filterChain)
			throws IOException, ServletException {
		// HttpServletRequest request = (HttpServletRequest) srequest;
		// logger.info("这是一个测试用的过滤器,请求的URL地址是 :" + request.getRequestURI());
		filterChain.doFilter(srequest, sresponse);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
