package com.jhz.jPaas.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.common.base.BaseController;
import com.jhz.jPaas.entity.PermissionEntity;
import com.jhz.jPaas.service.PermissionService;

/**
 * URL管理控制器
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Controller
@RequestMapping("/permission")
public class PermissionController extends BaseController {

	/**
	 * 注入数据库操作类
	 */
	@Autowired
	private PermissionService service;

	@Autowired
	private RequestMappingHandlerMapping handlerMapping;

	/**
	 * 查询列表
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getList")
	public ReturnModel getList() throws Exception {
		List<PermissionEntity> list = service.getList();
		returnModel.put("objList", list);
		return returnModel;
	}

	/**
	 * 查询非隐藏列表
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getVisibilityList")
	public ReturnModel getVisibilityList() throws Exception {
		List<PermissionEntity> list = service.getVisibilityList();
		returnModel.put("objList", list);
		return returnModel;
	}

	/**
	 * 更新
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/update")
	public ReturnModel update(@RequestBody Map<String, Object> paraMap) throws Exception {
		String uuid = paraMap.get("uuid").toString();
		PermissionEntity entity = service.getById(uuid);
		entity.setPermissionName(paraMap.get("permissionName").toString());
		entity.setPermissionDescription(paraMap.get("permissionDescription").toString());
		entity.setDataState(paraMap.get("dataState").toString());
		entity.setUpdatedBy("updaeby");
		entity.setUpdatedAt(new Date());
		service.save(entity);
		return returnModel;
	}

	/**
	 * 查询 by uuid
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getById")
	public ReturnModel getById(@RequestBody Map<String, Object> paraMap) throws Exception {
		String uuid = paraMap.get("uuid").toString();
		PermissionEntity entity = service.getById(uuid);
		returnModel.put("obj", entity);
		return returnModel;
	}

	/**
	 * 扫描URL
	 * 
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/scanurl")
	public ReturnModel scanUrl() throws Exception {
		service.scanURL(handlerMapping);
		return returnModel;
	}

	/**
	 * 删除 by uuid
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/delete")
	public ReturnModel delete(@RequestBody Map<String, Object> paraMap) throws Exception {
		String uuid = paraMap.get("uuid").toString();
		service.delete(uuid);
		return returnModel;
	}

}