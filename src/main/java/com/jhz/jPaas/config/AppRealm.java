package com.jhz.jPaas.config;

import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
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
	 * 验证用户登录身份,如果验证失败，返回null或者异常，跳转到login的
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken)
			throws AuthenticationException {
		String accountCode = (String) authcToken.getPrincipal();
		System.out.println("登录用户名： " + accountCode);
		System.out.println(authcToken.getCredentials());
		// 从数据库查询出User信息及用户关联的角色，权限信息，以备权限分配时使用
		AccountEntity accountEntity = accountRepository.findByAccountCode(accountCode);
		if (null == accountEntity)
			return null;
		System.out.println(
				"username: " + accountEntity.getAccountCode() + " ; password : " + accountEntity.getPassword());
		SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(accountEntity,
				accountEntity.getPassword(), getName());
		return authenticationInfo;

	}

	// /**
	// * 获取身份验证信息
	// * Shiro中，最终是通过 Realm 来获取应用程序中的用户、角色及权限信息的。
	// *
	// * @param authenticationToken 用户身份信息 token
	// * @return 返回封装了用户信息的 AuthenticationInfo 实例
	// */
	// protected AuthenticationInfo doGetAuthorizationInfo(AuthenticationToken authenticationToken)
	// throws AuthenticationException {
	// // 身份认证方法
	// UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
	// // 从数据库获取对应用户名密码的用户
	// String password = accountRepository.findByAccountCode(token.getUsername()).getPassword();
	// if (null == password) {
	// throw new AccountException("用户名不正确");
	// } else if (!password.equals(new String((char[]) token.getCredentials()))) {
	// throw new AccountException("密码不正确");
	// }
	// return new SimpleAuthenticationInfo(token.getPrincipal(), password, getName());
	// }

}