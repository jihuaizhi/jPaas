package com.jhz.jPaas.config;

import javax.servlet.Filter;

import org.apache.catalina.filters.RemoteIpFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.jhz.jPaas.common.filter.FilterTest;

/**
 * 
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Configuration
public class WebConfigure {
	@Bean
	public RemoteIpFilter remoteIpFilter() {
		return new RemoteIpFilter();
	}

	@Bean
	public FilterRegistrationBean<Filter> testFilterRegistration() {

		FilterRegistrationBean<Filter> registration = new FilterRegistrationBean<Filter>();
		registration.setFilter((Filter) new FilterTest());
		registration.addUrlPatterns("/*");
		registration.addInitParameter("paramName", "paramValue");
		registration.setName("FilterTest");
		registration.setOrder(1);
		return registration;

	}

}