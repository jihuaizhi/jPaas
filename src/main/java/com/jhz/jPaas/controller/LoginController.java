package com.jhz.jPaas.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String gotoLogin() {
		return "login.html";
	}

	/**
	 * 登录跳转首页
	 * 
	 * @return
	 */
	@RequestMapping("/login")
	public String login() {
		return "/views/index.html";
	}

	/**
	 * 跳转登录页
	 * 
	 * @return
	 */
	@RequestMapping("/logout")
	public String logout() {
		return "login.html";
	}

}
