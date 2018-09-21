package com.jhz.jPaas.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.handler.SimpleUrlHandlerMapping;
import org.springframework.web.servlet.resource.ResourceHttpRequestHandler;

/**
 * springMVC配置类
 * 
 * @author jihuaizhi
 * @since 2018-09-16
 */
// @Configuration
public class SpringMvcConfigure implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {

		registry.addResourceHandler("/public/**").addResourceLocations("classpath:/public/");
	}

	@Bean
	public SimpleUrlHandlerMapping simpleUrlHandlerMapping() {
		SimpleUrlHandlerMapping simpleUrlHandlerMapping = new SimpleUrlHandlerMapping();
		Map<String, ResourceHttpRequestHandler> urlMap = new HashMap<String, ResourceHttpRequestHandler>();
		urlMap.put("classpath:/public/", resourceHttpRequestHandler());
		return simpleUrlHandlerMapping;

	}

	@Bean
	public ResourceHttpRequestHandler resourceHttpRequestHandler() {
		ResourceHttpRequestHandler resourceHttpRequestHandler = new ResourceHttpRequestHandler();
		List<String> localList = new ArrayList<String>();
		localList.add("/public");
		resourceHttpRequestHandler.setLocationValues(localList);
		resourceHttpRequestHandler.setSupportedMethods("GET", "HEAD", "POST");
		return resourceHttpRequestHandler;

	}

}

// <bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
// <property name="urlMap">
// <map>
// <entry key="/请求的文件路径/**" value="myResourceHandler" />
// </map>
// </property>
// <property name="order" value="100000" />
// </bean>
//
//
// <bean id="myResourceHandler" name="myResourceHandler"
// class="org.springframework.web.servlet.resource.ResourceHttpRequestHandler">
// <property name="locations" value="/请求的文件路径/" />
// <property name="supportedMethods">
// <list>
// <value>GET</value>
// <value>HEAD</value>
// <value>POST</value>
// </list>
// </property>
//
// </bean>