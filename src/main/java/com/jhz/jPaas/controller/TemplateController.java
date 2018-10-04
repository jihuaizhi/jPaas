package com.jhz.jPaas.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhz.jPaas.common.NeoProperties;
import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.common.base.BaseController;
import com.jhz.jPaas.entity.AccountEntity;
import com.jhz.jPaas.entity.TemplatetEntity;
import com.jhz.jPaas.repository.TemplateRepository;
import com.jhz.jPaas.service.AccountService;

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
	 * 注入Service
	 */
	@Autowired
	private AccountService accountService;

	/**
	 * 查询帐号列表
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getList")
	public ReturnModel getList() throws Exception {
		List<AccountEntity> list = accountService.getAccountList();
		returnModel.put("objList", list);
		return returnModel;
	}

	/**
	 * 新增帐号
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/insert")
	public ReturnModel insert(@RequestBody Map<String, Object> paraMap) throws Exception {
		AccountEntity accountEntity = new AccountEntity();
		accountEntity.setUuid(UUID.randomUUID().toString());
		accountEntity.setAccountCode(paraMap.get("accountCode").toString());
		accountEntity.setAccountName(paraMap.get("accountName").toString());
		accountEntity.setPassword(paraMap.get("password1").toString());
		accountEntity.setDataState(paraMap.get("dataState").toString());
		accountEntity.setCreatedBy("1234567890");
		accountEntity.setCreatedAt(new Date());
		// accountService.save(accountEntity);
		return returnModel;
	}

	/**
	 * 更新帐号
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/update")
	public ReturnModel update(@RequestBody Map<String, Object> paraMap) throws Exception {
		String uuid = paraMap.get("uuid").toString();
		AccountEntity accountEntity = accountService.getById(uuid);
		accountEntity.setAccountName(paraMap.get("accountName").toString());
		String password = paraMap.get("password1").toString();
		// 更新的时候如果没有输入密码，则不更新密码
		if (!StringUtils.isEmpty(password)) {
			accountEntity.setPassword(password);
		}
		accountEntity.setDataState(paraMap.get("dataState").toString());
		accountEntity.setUpdatedBy("updaeby");
		accountEntity.setUpdatedAt(new Date());
		// accountService.save(accountEntity);
		return returnModel;
	}

	/**
	 * 删除帐号
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/delete")
	public ReturnModel delete(@RequestBody Map<String, Object> paraMap) throws Exception {
		String uuid = paraMap.get("uuid").toString();
		AccountEntity accountEntity = accountService.getById(uuid);
		if (accountEntity.getAccountCode().equalsIgnoreCase(AccountEntity.SUPER_ADMIN)) {
			returnModel.putError("", "内置系统管理帐号不能删除！");
		} else {
			accountService.delete(uuid);
		}
		return returnModel;
	}

	/**
	 * 查询帐号信息
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getById")
	public ReturnModel getById(@RequestBody Map<String, Object> paraMap) throws Exception {
		String uuid = paraMap.get("uuid").toString();
		AccountEntity entity = accountService.getById(uuid);
		returnModel.put("obj", entity);
		return returnModel;
	}

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
		// if (true) {
		// throw new Exception("手工跑出异常2");
		//
		// }

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
		// if (true) {
		// throw new Exception("手工跑出异常1");
		//
		// }
		return list;
	}

}