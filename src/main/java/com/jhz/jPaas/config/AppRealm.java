package com.jhz.jPaas.config;

import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jhz.jPaas.entity.AccountEntity;
import com.jhz.jPaas.repository.AccountRepository;
import com.jhz.jPaas.repository.RoleRepository;

public class AppRealm extends AuthorizingRealm {

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private AccountRepository accountRepository;

	@Autowired
	private RoleRepository roleRepository;

	/*
	 * 获取身份验证信息
	 *
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
		// 权限认证
		AccountEntity accountEntity = (AccountEntity) SecurityUtils.getSubject().getPrincipal();
		// 获得该用户角色
		Set<String> roleSet = roleRepository.findRoleCodeByAccoountCode(accountEntity.getAccountCode());
		// 设置该用户拥有的角色
		authorizationInfo.setRoles(roleSet);
		logger.info("用户" + accountEntity.getAccountName() + "具有的角色:" + authorizationInfo.getRoles());
		logger.info("用户" + accountEntity.getAccountName() + "具有的权限：" + authorizationInfo.getStringPermissions());

		return authorizationInfo;
	}

	/**
	 * 用于验证登录用户的账号和密码；
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) {
		// 获取登录账号
		String accountCode = (String) authcToken.getPrincipal();
		logger.info(accountCode + "  登录系统 ");
		// 通过账号查询数据库账号信息
		AccountEntity accountEntity = accountRepository.findByAccountCode(accountCode);
		// 如果查询无结果则返回null
		if (null == accountEntity) {
			return null;
		}
		SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(accountEntity,
				accountEntity.getPassword(), getName());
		return authenticationInfo;

	}

}