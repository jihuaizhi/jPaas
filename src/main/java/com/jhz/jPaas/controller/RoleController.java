package com.jhz.jPaas.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.common.base.BaseController;
import com.jhz.jPaas.entity.RoleEntity;
import com.jhz.jPaas.entity.RoleMenuEntity;
import com.jhz.jPaas.entity.RolePermissionEntity;
import com.jhz.jPaas.service.RoleService;

/**
 * 角色管理控制器
 * 
 * @author jihuaizhi
 * @since 2018-09-20
 */
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {

	/**
	 * 注入Service
	 */
	@Autowired
	private RoleService roleService;

	/**
	 * 查询角色列表
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getList")
	public ReturnModel getList() throws Exception {
		List<RoleEntity> entityList = roleService.getList();
		returnModel.put("objList", entityList);
		return returnModel;
	}

	/**
	 * 查询角色信息
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getById")
	public ReturnModel getById(@RequestBody Map<String, Object> paraMap) throws Exception {
		String uuid = paraMap.get("uuid").toString();
		RoleEntity entity = roleService.getById(uuid);
		returnModel.put("obj", entity);
		List<RoleMenuEntity> menuList = roleService.findMenuByRoleUuid(uuid);
		List<RolePermissionEntity> permissionList = roleService.findPermissionByRoleUuid(uuid);
		returnModel.put("menuList", menuList);
		returnModel.put("permissionList", permissionList);
		return returnModel;
	}

	/**
	 * 删除角色
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/delete")
	public ReturnModel delete(@RequestBody Map<String, Object> paraMap) throws Exception {
		String uuid = paraMap.get("uuid").toString();
		RoleEntity entity = roleService.getById(uuid);
		if (entity.getRoleCode().equalsIgnoreCase(RoleEntity.SUPER_ADMINISTRATOR)) {
			returnModel.putError("", "内置系统管理角色不能删除！");
		} else {
			roleService.delete(uuid);
		}
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
		RoleEntity entity = new RoleEntity();
		entity.setUuid(UUID.randomUUID().toString());
		entity.setRoleCode(paraMap.get("roleCode").toString());
		entity.setRoleName(paraMap.get("roleName").toString());
		entity.setRoleDescription(paraMap.get("roleDescription").toString());
		entity.setCreatedBy("1234567890");
		entity.setCreatedAt(new Date());
		String menuUuids = paraMap.get("checkedMenuUuid").toString();
		// 解决空字符串split之后变成包含一个空字符串元素的数组的问题
		String[] menuUuid = menuUuids.isEmpty() ? new String[0] : menuUuids.split(",");
		String permissionUuids = paraMap.get("selectedPermissionUuid").toString();
		// 解决空字符串split之后变成包含一个空字符串元素的数组的问题
		String[] permissionUuid = permissionUuids.isEmpty() ? new String[0] : permissionUuids.split(",");
		roleService.insert(entity, menuUuid, permissionUuid);
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
		RoleEntity entity = roleService.getById(uuid);
		entity.setRoleName(paraMap.get("roleName").toString());
		entity.setRoleDescription(paraMap.get("roleDescription").toString());
		entity.setUpdatedBy("updaeby");
		entity.setUpdatedAt(new Date());
		String[] menuUuid = paraMap.get("checkedMenuUuid").toString().split(",");
		String[] permissionUuid = paraMap.get("selectedPermissionUuid").toString().split(",");
		roleService.update(entity, menuUuid, permissionUuid);
		return returnModel;
	}

	// /**
	// *
	// * @author jihuaizhi
	// * @param paraMap
	// * @return
	// * @throws Exception
	// */
	// @RequestMapping(value = "/getPermissionListVisible", name = "查询系统所有有效的URL数据")
	// public ModelResult getPermissionListVisible() throws Exception {
	// ModelResult returnModel = new ModelResult();
	// List<PermissionEntity> list = new ArrayList<>();
	// list = permissionService.getPermissionListVisible();
	// returnModel.put("objList", list);
	// return returnModel;
	// }

}
