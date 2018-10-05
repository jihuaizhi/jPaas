package com.jhz.jPaas.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.common.base.BaseController;
import com.jhz.jPaas.entity.AccountEntity;
import com.jhz.jPaas.service.AccountService;
import com.jhz.jPaas.service.RoleService;

/**
 * 账户管理控制器
 * 
 * @author jihuaizhi
 * @since 2018-09-16
 */
@Controller
@RequestMapping("/account")
public class AccountController extends BaseController {

	/**
	 * 注入Service
	 */
	@Autowired
	private AccountService accountService;

	@Autowired
	private RoleService roleService;

	/**
	 * 查询帐号列表
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getAccountList")
	public ReturnModel getAccountList() throws Exception {
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
		String roleUuids = paraMap.get("roleUuid").toString();
		// 解决空字符串split之后变成包含一个空字符串元素的数组的问题
		String[] roleUuid = roleUuids.isEmpty() ? new String[0] : roleUuids.split(",");
		accountEntity.setPassword(getEncryptedPwd(paraMap.get("password1").toString()));
		accountEntity.setDataState(paraMap.get("dataState").toString());
		accountEntity.setCreatedBy("1234567890");
		accountEntity.setCreatedAt(new Date());
		accountService.save(accountEntity, roleUuid);
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

		String strRoleUuids = paraMap.get("roleUuid").toString();
		String[] roleUuid = null;
		if (null == strRoleUuids) {
			roleUuid = new String[0];
		} else {
			// 获取select2组件返回的数值,去掉方括号和多余的空格
			roleUuid = strRoleUuids.replaceAll("\\[|\\]| ", "").split(",");
		}

		String pwd = paraMap.get("password1").toString();
		// 更新的时候如果没有输入密码，则不更新密码
		if (!StringUtils.isEmpty(pwd)) {
			accountEntity.setPassword(getEncryptedPwd(pwd));
		}
		accountEntity.setDataState(paraMap.get("dataState").toString());
		accountEntity.setUpdatedBy("updaeby");
		accountEntity.setUpdatedAt(new Date());
		accountService.save(accountEntity, roleUuid);
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
		List<String> list = roleService.getListByAccountUuid(uuid);
		returnModel.put("obj", entity);
		returnModel.put("roleUuidList", list);
		return returnModel;
	}

	/**
	 * 重置密码
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/resetPwd")
	public ReturnModel resetPwd(@RequestBody Map<String, Object> paraMap) throws Exception {
		String uuid = paraMap.get("uuid").toString();
		String oldPassword = paraMap.get("oldPassword").toString();
		String newPassword = paraMap.get("newPassword").toString();
		AccountEntity accountEntity = accountService.getById(uuid);
		if (accountEntity.getPassword().equals(oldPassword)) {
			String newPwd = getEncryptedPwd(newPassword);
			accountService.resetPwd(uuid, newPwd);
		} else {
			returnModel.putError("", "旧密码输入错误！");
		}
		return returnModel;
	}

	/**
	 * 对密码进行加密
	 * 
	 * @param pwd
	 * @return
	 */
	private String getEncryptedPwd(String pwd) {
		String pwdMD5 = new Md5Hash(new Md5Hash(pwd)).toString();
		return pwdMD5;
	}
}
