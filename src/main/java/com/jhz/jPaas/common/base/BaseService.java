package com.jhz.jPaas.common.base;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Service父类
 * 业务逻辑处理公共方法
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
public abstract class BaseService {
	/**
	 * 日志处理对象
	 */
	protected final Logger logger = LoggerFactory.getLogger(getClass());

}
