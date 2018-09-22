package com.jhz.jPaas.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.common.base.BaseController;
import com.jhz.jPaas.entity.TemplatetEntity;
import com.jhz.jPaas.repository.TemplateRepository;
import com.jhz.jPaas.utils.NeoProperties;

/**
 * 测试用控制器
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Controller
@RequestMapping("/hello")
public class TemplateController extends BaseController {

	/**
	 * 注入属性文件读取类
	 */
	@Autowired
	private NeoProperties neoProperties;

	/**
	 * 注入数据库操作类
	 */
	@Autowired
	private TemplateRepository userRepository;

	/**
	 * 跳转首页
	 * 
	 * @return
	 */
	@RequestMapping("/tmp")
	public String homePage() {
		return "/tmp/index.html";
	}

	/**
	 * 使用标准返回值封装模型返回前端数据
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/uuid")
	public ReturnModel uuid() throws Exception {
		String uuid = UUID.randomUUID().toString();
		returnModel.put("uuid", uuid);
		return returnModel;
	}

	/**
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getUser")
	public ReturnModel getUser() throws Exception {
		TemplatetEntity user = new TemplatetEntity();
		user.setUserName("小明");
		user.setPassword("xxxx");
		returnModel.put("user", user);
		return returnModel;
	}

	/**
	 * 
	 * 读取属性文件的值
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getPara")
	public String getPara() throws Exception {
		return neoProperties.getTitle() + neoProperties.getDescription();
	}

	/**
	 * 进行数据库操作
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/qqq")
	public List<?> testBaseQuery() throws Exception {
		for (int i = 0; i < 10; i++) {
			TemplatetEntity user = new TemplatetEntity();
			user.setAccountName("小明的账号" + i);
			user.setUserName("小明的姓名" + i);
			user.setPassword("xxxx" + i);
			user.setCreatedAt(new Date());
			user.setCreatedBy("创建人uuid" + 1);
			userRepository.save(user);
		}
//		if (true) {
//			throw new Exception("手工跑出异常2");
//
//		}

		userRepository.findAll();
		// userRepository.findById("11");
		userRepository.count();
		// userRepository.existsById(1l);
		return userRepository.findByUserNameLike("小明的姓名1");
		// return userRepository.findAll();
	}

	/**
	 * 带参数的数据库操作
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	public List<Map<String, Object>> testSqlQuery() throws Exception {

		List<Map<String, Object>> list = userRepository.getUserEmailByAccount("小明");
//		if (true) {
//			throw new Exception("手工跑出异常1");
//
//		}
		return list;
	}

}