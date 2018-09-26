package com.jhz.jPaas.config;

import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.codec.Base64;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * shiro配置类
 * 
 * @author jihuaizhi
 * @since 2018-09-25
 *
 */
@Configuration
public class ShiroConfig {

	public ShiroConfig() {
		System.out.println("ShiroConfig  init ....");
	}

	@Bean
	public ShiroFilterFactoryBean shirFilter(SecurityManager securityManager) {

		ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
		// 必须设置 SecurityManager
		shiroFilterFactoryBean.setSecurityManager(securityManager);

		// 设置拦截器
		Map<String, String> filterChainDefinitionMap = new LinkedHashMap<>();
		// filterChainDefinitionMap.put("/stu/addStu","perms[student:aaaa]");
		// 配置不会被拦截的链接 顺序判断 相关静态资源
		filterChainDefinitionMap.put("/css/**", "anon");
		filterChainDefinitionMap.put("/images/**", "anon");
		filterChainDefinitionMap.put("/js/**", "anon");
		filterChainDefinitionMap.put("/plugins/**", "anon");

		// 登录入口
		filterChainDefinitionMap.put("/", "anon");
		filterChainDefinitionMap.put("/login", "anon");
		// 配置退出 过滤器,其中的具体的退出代码Shiro已经替我们实现了
		// filterChainDefinitionMap.put("/logout", "logout");
		//
		// // 游客，开发权限
		// filterChainDefinitionMap.put("/views/error/**", "anon");
		// // 管理员，需要角色权限 “admin”
		// filterChainDefinitionMap.put("/views/auth/**", "roles[admin]");
		// // 用户，需要角色权限 “user”
		// filterChainDefinitionMap.put("/views/**", "roles[user]");
		// authc:所有url都必须认证通过才可以访问; anon:所有url都都可以匿名访问,这行代码必须放在所有权限设置的最后，不然会导致所有 url 都被拦截
		filterChainDefinitionMap.put("/**", "anon");

		// setLoginUrl 如果不设置值，默认会自动寻找Web工程根目录下的"/login.jsp"页面 或 "/login" 映射
		// shiroFilterFactoryBean.setLoginUrl("login.html");
		// 登录成功后要跳转的链接
		// shiroFilterFactoryBean.setSuccessUrl("/views/index.html");
		// 设置无权限时跳转的 url;
		shiroFilterFactoryBean.setUnauthorizedUrl("/views/error/notRole.html");
		// shiroFilterFactoryBean.setLoginUrl("/views/error/noLogin.html");

		shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
		return shiroFilterFactoryBean;
	}

	/*
	 * 加密方式配置
	 */
	@Bean
	public HashedCredentialsMatcher hashedCredentialsMatcher() {
		HashedCredentialsMatcher hashedCredentialsMatcher = new HashedCredentialsMatcher();
		hashedCredentialsMatcher.setHashAlgorithmName("md5");// 散列算法:这里使用MD5算法;
		hashedCredentialsMatcher.setHashIterations(2);// 散列的次数，比如散列两次，相当于 md5(md5(""));
		return hashedCredentialsMatcher;
	}

	/**
	 * 注入 securityManager
	 */
	@Bean
	public SecurityManager securityManager() {
		DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
		securityManager.setRealm(appRealm());
		return securityManager;
	}

	/**
	 * 自定义身份认证 realm;
	 * 必须写这个类，并加上 @Bean 注解，目的是注入 CustomRealm，
	 * 否则会影响 CustomRealm类 中其他类的依赖注入
	 */
	@Bean
	public AppRealm appRealm() {
		AppRealm appRealm = new AppRealm();
		// appRealm.setCredentialsMatcher(hashedCredentialsMatcher());
		return appRealm;

	}

	/**
	 * cookie对象;
	 * 
	 * @return
	 */
	public SimpleCookie rememberMeCookie() {
		// 这个参数是cookie的名称，对应前端的checkbox的name = rememberMe
		SimpleCookie simpleCookie = new SimpleCookie("rememberMe");
		// <!-- 记住我cookie生效时间30天 ,单位秒;-->
		simpleCookie.setMaxAge(2592000);
		return simpleCookie;
	}

	/**
	 * cookie管理对象;记住我功能
	 * 
	 * @return
	 */
	public CookieRememberMeManager rememberMeManager() {
		System.out.println("cookieManager11111");
		CookieRememberMeManager cookieRememberMeManager = new CookieRememberMeManager();
		cookieRememberMeManager.setCookie(rememberMeCookie());
		// rememberMe cookie加密的密钥 建议每个项目都不一样 默认AES算法 密钥长度(128 256 512 位)
		cookieRememberMeManager.setCipherKey(Base64.decode("3AvVhmFLUs0KTA3Kprsdag=="));
		return cookieRememberMeManager;
	}

	/*
	 * 开启@RequirePermission注解的配置，要结合DefaultAdvisorAutoProxyCreator一起使用，或者导入aop的依赖
	 */
	@Bean
	public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(SecurityManager securityManager) {
		AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
		authorizationAttributeSourceAdvisor.setSecurityManager(securityManager);
		return authorizationAttributeSourceAdvisor;
	}

	/*
	 * @Bean
	 * public DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator(){
	 * DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator = new DefaultAdvisorAutoProxyCreator();
	 * advisorAutoProxyCreator.setProxyTargetClass(true);
	 * return advisorAutoProxyCreator;
	 * }
	 */

	// /*
	// * 定义Spring MVC的异常处理器
	// */
	// @Bean
	// public SimpleMappingExceptionResolver createSimpleMappingExceptionResolver() {
	// SimpleMappingExceptionResolver r = new SimpleMappingExceptionResolver();
	// Properties mappings = new Properties();
	// mappings.setProperty("DatabaseException", "databaseError");// 数据库异常处理
	// mappings.setProperty("UnauthorizedException", "403");// 处理shiro的认证未通过异常
	// r.setExceptionMappings(mappings); // None by default
	// r.setDefaultErrorView("error"); // No default
	// r.setExceptionAttribute("ex"); // Default is "exception"
	// return r;
	// }

}
