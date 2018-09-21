package com.jhz.jPaas.utils;

import java.util.Map;

/**
 * 使用org.apache.commons.beanutils进行转换
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
public class ObjectMapUtils {

	public static Object mapToObject(Map<String, Object> map, Class<?> beanClass) throws Exception {
		if (map == null)
			return null;

		Object obj = beanClass.newInstance();

		org.apache.commons.beanutils.BeanUtils.populate(obj, map);

		return obj;
	}

	public static Map<?, ?> objectToMap(Object obj) {
		if (obj == null)
			return null;

		return new org.apache.commons.beanutils.BeanMap(obj);
	}

}