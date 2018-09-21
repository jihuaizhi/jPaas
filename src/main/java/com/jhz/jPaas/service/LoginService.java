package com.jhz.jPaas.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jhz.jPaas.common.base.BaseService;

/**
 * 登录认证service
 * 
 * @author jihuaizhi
 * @since 2018-09-16
 */
@Service
@Transactional
public class LoginService extends BaseService {

	@Transactional(readOnly = true) // 配置事务 查询使用只读
	public boolean Login() throws Exception {
		return false;

	}

	@Transactional(readOnly = false) // (增删改要写 ReadOnly=false 为可写 默认值)
	public boolean InsertUser() throws Exception {
		return false;

	}

}
