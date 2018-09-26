package com.jhz.jPaas.controller;

import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.common.base.BaseController;

/**
 * 系统登录控制器
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Controller
public class LoginController extends BaseController {

	/**
	 * 跳转登录页
	 * 
	 * @return
	 */
	@RequestMapping("/")
	public String root() {
		return "login.html";
	}

	/**
	 * 登录验证
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/login")
	public ReturnModel login(@RequestBody Map<String, Object> paraMap) {
		// System.out.println("user login .....");
		// String exception = (String) request.getAttribute("shiroLoginFailure");
		// System.out.println("exception=" + exception);
		// String msg = "";
		// if (exception != null) {
		// if (UnknownAccountException.class.getName().equals(exception)) {
		// System.out.println("UnknownAccountException -- > 账号不存在：");
		// msg = "unknownAccount";
		// } else if (IncorrectCredentialsException.class.getName().equals(exception)) {
		// msg = "incorrectPassword";
		// } else if ("kaptchaValidateFailed".equals(exception)) {
		// System.out.println("kaptchaValidateFailed -- > 验证码错误");
		// msg = "kaptchaValidateFailed -- > 验证码错误";
		// } else {
		// msg = "else >> " + exception;
		// System.out.println("else -- >" + exception);
		// }
		// }
		// map.put("msg", msg);
		// 认证成功由shiro框架自行处理
		// return "/views/index.html";

		String accountCode = paraMap.get("accountCode").toString();
		String password = paraMap.get("password").toString();
		// 1、获取Subject实例对象
		Subject currentUser = SecurityUtils.getSubject();

		// 2、判断当前用户是否登录
		if (currentUser.isAuthenticated() == false) {
			// 3、将用户名和密码封装到 UsernamePasswordToken
			UsernamePasswordToken token = new UsernamePasswordToken(accountCode, password);
			// 4、认证
			try {
				currentUser.login(token);// 传到MyAuthorizingRealm类中的方法进行认证
				Session session = currentUser.getSession();
				session.setAttribute("accountCode", accountCode);
			} catch (AuthenticationException e) {
				returnModel.putError("", "密码或用户名错误！");
			}
		}
		return returnModel;
	}

	// 访问此连接时会触发MyShiroRealm中的权限分配方法
	@RequestMapping("/permission")
	@RequiresPermissions("student:test")
	public void test() {
		System.out.println("permission  test");
	}
}
