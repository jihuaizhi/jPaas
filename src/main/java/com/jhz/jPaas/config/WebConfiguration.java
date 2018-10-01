package com.jhz.jPaas.config;

import javax.servlet.Filter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.jhz.jPaas.common.filter.TestFilter;

/**
 * 测试用配置文件
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Configuration
public class WebConfiguration {

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	@Bean
	public FilterRegistrationBean<Filter> testFilterRegistration() {

		FilterRegistrationBean<Filter> registration = new FilterRegistrationBean<Filter>();
		registration.setFilter((Filter) new TestFilter());
		registration.addUrlPatterns("/*");
		registration.addInitParameter("paramName", "paramValue");
		registration.setName("TestFilter");
		registration.setOrder(1);
		return registration;

	}

}