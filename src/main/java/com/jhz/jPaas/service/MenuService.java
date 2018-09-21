package com.jhz.jPaas.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jhz.jPaas.common.base.BaseService;
import com.jhz.jPaas.entity.MenuEntity;
import com.jhz.jPaas.repository.MenuRepository;

/**
 * 菜单管理service
 * 
 * @author jihuaizhi
 * @since 2018-09-20
 */
@Service
@Transactional
public class MenuService extends BaseService {

	/**
	 * 注入Repository
	 */
	@Autowired
	private MenuRepository repository;

	/**
	 * 查询列表
	 * 
	 * @return entityList
	 */
	public List<MenuEntity> getList() throws Exception {
		List<MenuEntity> entityList = repository.findAll();
		return entityList;

	}

	/**
	 * 新增/更新
	 * 
	 * @param entity
	 */
	public void save(MenuEntity entity) throws Exception {
		repository.save(entity);
	}

	/**
	 * 删除
	 * 
	 * @param uuid
	 */
	public void delete(String uuid) throws Exception {
		repository.deleteById(uuid);
	}

	/**
	 * 查询by id
	 * 
	 * @param uuid
	 */
	public MenuEntity getById(String uuid) throws Exception {
		Optional<MenuEntity> entity = repository.findById(uuid);
		return entity.get();
	}

}
