package com.jhz.jPaas.common;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

/**
 * 读取属性文件工具类
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 *
 */
@Component
@ConfigurationProperties(prefix = "com.neo")
@PropertySource("classpath:application.properties")

public class NeoProperties {
	private String title;
	private String description;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}