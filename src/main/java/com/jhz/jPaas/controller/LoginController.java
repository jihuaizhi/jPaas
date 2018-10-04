package com.jhz.jPaas.controller;

import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.common.base.BaseController;
import com.jhz.jPaas.entity.AccountEntity;
import com.jhz.jPaas.service.AccountService;

/**
 * 系统登录控制器
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Controller
public class LoginController extends BaseController {

	@Autowired
	private AccountService accountService;

	/**
	 * 跳转登录页
	 * 
	 * @return
	 */
	@RequestMapping("/")
	public String root() throws Exception {
		return "/login.html";
	}

	/**
	 * 登录验证
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/login")
	public ReturnModel login(@RequestBody Map<String, Object> paraMap) throws Exception {
		String accountCode = paraMap.get("accountCode").toString();
		String password = paraMap.get("password").toString();
		// 1、获取Subject实例对象
		Subject currentUser = SecurityUtils.getSubject();

		// 2、判断当前用户是否登录
		if (currentUser.isAuthenticated() == false) {
			// 3、将用户名和密码封装到 UsernamePasswordToken
			UsernamePasswordToken token = new UsernamePasswordToken(accountCode, password);
			// 4、传到MyAuthorizingRealm类中的doGetAuthenticationInfo方法进行认证
			currentUser.login(token);
			Session session = currentUser.getSession();
			AccountEntity accountEntity = accountService.getAccountByCode(accountCode);
			session.setAttribute("accountEntity", accountEntity);
		}
		return returnModel;
	}

	/**
	 * 获取当前登录用户信息
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getloginUser")
	public ReturnModel getloginUser() throws Exception {
		Subject loginUser = SecurityUtils.getSubject();
		Session session = loginUser.getSession();
		AccountEntity accountEntity = (AccountEntity) session.getAttribute("accountEntity");
		returnModel.put("account", accountEntity);
		returnModel.put("startTime", session.getStartTimestamp());
		return returnModel;
	}

}
