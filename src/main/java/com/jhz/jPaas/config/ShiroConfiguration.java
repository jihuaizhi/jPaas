package com.jhz.jPaas.config;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.Filter;

import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.jhz.jPaas.common.filter.ShiroAuthcFilter;
import com.jhz.jPaas.common.filter.ShiroPermsFilter;

/**
 * shiro配置类
 * 
 * @author jihuaizhi
 * @since 2018-09-25
 *
 */
@Configuration
public class ShiroConfiguration {

	@Bean(name = "shiroFilter")
	public ShiroFilterFactoryBean shirFilter(SecurityManager securityManager) {
		ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
		// Shiro的核心安全接口,这个属性是必须的
		shiroFilterFactoryBean.setSecurityManager(securityManager);

		// 设置拦截器
		Map<String, String> filterChainDefinitionMap = new LinkedHashMap<>();
		// 配置不会被拦截的链接 顺序判断 静态资源
		filterChainDefinitionMap.put("/css/**", "anon");
		filterChainDefinitionMap.put("/images/**", "anon");
		filterChainDefinitionMap.put("/js/**", "anon");
		filterChainDefinitionMap.put("/plugins/**", "anon");

		// 不拦截系统入口和登录请求
		filterChainDefinitionMap.put("/", "anon");
		filterChainDefinitionMap.put("/login", "anon");

		// 不拦截错误信息页面
		filterChainDefinitionMap.put("/views/error/**", "anon");

		// 不拦截所有view层的html和js文件
		// filterChainDefinitionMap.put("/**/*.html", "anon");
		filterChainDefinitionMap.put("/**/*.js", "anon");
		filterChainDefinitionMap.put("/**/*.ico", "anon");

		// 退出登录,shiro自动处理
		filterChainDefinitionMap.put("/logout", "logout");

		// authc:所有url都必须认证通过才可以访问;
		filterChainDefinitionMap.put("/**", "authc");

		// 要求登录时的链接(可根据项目的URL进行替换),非必须的属性,默认会自动寻找Web工程根目录下的"/login.jsp"页面
		shiroFilterFactoryBean.setLoginUrl("/login.html");
		// 设置无权限时跳转的 url;
		shiroFilterFactoryBean.setUnauthorizedUrl("/views/error/noRole.html");

		// 自定义过滤器
		Map<String, Filter> filterMap = shiroFilterFactoryBean.getFilters();
		// 注入登录校验过滤器,在上面标记为authc的拦截配置的URL会被此过滤器监听
		filterMap.put("authc", new ShiroAuthcFilter());
		// 注入权限校验过滤器,在所有请求前判定是否具备相关操作权限
		filterMap.put("perms", new ShiroPermsFilter());
		shiroFilterFactoryBean.setFilters(filterMap);

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
	 */
	@Bean
	public AppRealm appRealm() {
		AppRealm appRealm = new AppRealm();
		// 定义密码加密验证算法,与帐号录入系统时的加密对法一致
		appRealm.setCredentialsMatcher(hashedCredentialsMatcher());
		return appRealm;

	}

	/**
	 * cookie对象;
	 * 
	 * @return
	 */
	// public SimpleCookie rememberMeCookie() {
	// // 这个参数是cookie的名称，对应前端的checkbox的name = rememberMe
	// SimpleCookie simpleCookie = new SimpleCookie("rememberMe");
	// // <!-- 记住我cookie生效时间30天 ,单位秒;-->
	// simpleCookie.setMaxAge(2592000);
	// return simpleCookie;
	// }

	/**
	 * cookie管理对象;记住我功能
	 * 
	 * @return
	 */
	// public CookieRememberMeManager rememberMeManager() {
	// System.out.println("cookieManager11111");
	// CookieRememberMeManager cookieRememberMeManager = new CookieRememberMeManager();
	// cookieRememberMeManager.setCookie(rememberMeCookie());
	// // rememberMe cookie加密的密钥 建议每个项目都不一样 默认AES算法 密钥长度(128 256 512 位)
	// cookieRememberMeManager.setCipherKey(Base64.decode("3AvVhmFLUs0KTA3Kprsdag=="));
	// return cookieRememberMeManager;
	// }

	/*
	 * 开启@RequirePermission注解的配置，要结合DefaultAdvisorAutoProxyCreator一起使用，或者导入aop的依赖
	 */
	// @Bean
	// public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(SecurityManager securityManager) {
	// AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new
	// AuthorizationAttributeSourceAdvisor();
	// authorizationAttributeSourceAdvisor.setSecurityManager(securityManager);
	// return authorizationAttributeSourceAdvisor;
	// }

}
