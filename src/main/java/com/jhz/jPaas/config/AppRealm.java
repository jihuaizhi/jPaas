package com.jhz.jPaas.config;

import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jhz.jPaas.entity.AccountEntity;
import com.jhz.jPaas.repository.AccountRepository;
import com.jhz.jPaas.repository.PermissionRepository;
import com.jhz.jPaas.repository.RoleRepository;

/**
 * shiro认证和授权校验器
 * 
 * @author jihuaizhi
 * @since 2018-10-01
 *
 */
public class AppRealm extends AuthorizingRealm {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private AccountRepository accountRepository;

	@Autowired
	private RoleRepository roleRepository;

	@Autowired
	private PermissionRepository permissionRepository;

	/*
	 * 获取授权信息
	 *
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) throws AuthorizationException {
		SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
		// 获取当前登录账号的凭证
		AccountEntity currentAccountEntity = (AccountEntity) SecurityUtils.getSubject().getPrincipal();
		// 从数据库中获取账号实体信息
		AccountEntity accountEntity = accountRepository.findByAccountCode(currentAccountEntity.getAccountCode());
		if (null != accountEntity) {
			// 获取该账号的角色集合
			Set<String> roleSet = roleRepository.findRoleCodeByAccoountCode(currentAccountEntity.getAccountCode());
			Set<String> permissionSet = permissionRepository
					.findPermissionCodeByAccoountCode(currentAccountEntity.getAccountCode());
			authorizationInfo.setRoles(roleSet);
			authorizationInfo.setStringPermissions(permissionSet);
		} else {
			throw new AuthorizationException();
		}

		logger.info("用户" + accountEntity.getAccountName() + "具有的角色:" + authorizationInfo.getRoles());
		logger.info("用户" + accountEntity.getAccountName() + "具有的权限：" + authorizationInfo.getStringPermissions());

		return authorizationInfo;
	}

	/**
	 * 登录认证,执行登录操作currentUser.login(token);的时候会调用此方法
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken)
			throws AuthenticationException {
		// 获取登录账号
		String accountCode = authcToken.getPrincipal().toString();
		// 得到密码
		// String password = authcToken.getCredentials().toString();

		logger.info("账号:" + accountCode + "  正在登录系统 ");
		// 通过账号查询数据库账号信息
		AccountEntity accountEntity = accountRepository.findByAccountCode(accountCode);
		if (null != accountEntity) {
			// 若存在，将此用户存放到登录认证info中，无需自己做密码对比，Shiro会为我们进行密码对比校验
			SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(accountEntity,
					accountEntity.getPassword(), getName());
			return authenticationInfo;
		}
		// 如果查询无结果则返回null
		return null;
	}

}