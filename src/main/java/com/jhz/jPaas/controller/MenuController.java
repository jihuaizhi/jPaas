package com.jhz.jPaas.controller;

import java.util.Date;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.common.base.BaseController;
import com.jhz.jPaas.entity.MenuEntity;
import com.jhz.jPaas.service.MenuService;

/**
 * 菜单管理控制器
 * 
 * @author jihuaizhi
 * @since 2018-09-20
 */
@Controller
@RequestMapping("/menu")
public class MenuController extends BaseController {

	/**
	 * 注入Service
	 */
	@Autowired
	private MenuService menuService;

	/**
	 * 查询菜单列表
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getList")
	public ReturnModel getList() throws Exception {
		returnModel.put("menuList", menuService.getList());
		return returnModel;
	}

	/**
	 * 查询菜单信息
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getById")
	public ReturnModel getById(@RequestBody Map<String, Object> paraMap) throws Exception {
		String uuid = paraMap.get("uuid").toString();
		MenuEntity entity = menuService.getById(uuid);
		returnModel.put("menu", entity);
		return returnModel;
	}

	/**
	 * 删除菜单
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/delete")
	public ReturnModel delete(@RequestBody Map<String, Object> paraMap) throws Exception {
		String uuid = paraMap.get("uuid").toString();
		menuService.delete(uuid);
		return returnModel;
	}

	/**
	 * 新增菜单
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/insert")
	public ReturnModel insert(@RequestBody Map<String, Object> paraMap) throws Exception {
		MenuEntity entity = new MenuEntity();
		entity.setUuid(UUID.randomUUID().toString());
		entity.setMenuName(paraMap.get("meuName").toString());
		entity.setMenuLink(paraMap.get("menuLink").toString());
		entity.setMenuIcon(paraMap.get("menuIcon").toString());
		entity.setCreatedBy("1234567890");
		entity.setCreatedAt(new Date());
		menuService.save(entity);
		return returnModel;
	}

	/**
	 * 更新菜单
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/update")
	public ReturnModel update(@RequestBody Map<String, Object> paraMap) throws Exception {
		String uuid = paraMap.get("uuid").toString();
		MenuEntity entity = menuService.getById(uuid);
		entity.setMenuName(paraMap.get("meuName").toString());
		entity.setMenuLink(paraMap.get("menuLink").toString());
		entity.setMenuIcon(paraMap.get("menuIcon").toString());
		entity.setUpdatedBy("updaeby");
		entity.setUpdatedAt(new Date());
		menuService.save(entity);
		return returnModel;
	}

}
