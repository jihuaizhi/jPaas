package com.jhz.jPaas.service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
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
	public List<MenuEntity> getMenuList() throws Exception {
		Sort sort = new Sort(Sort.Direction.ASC, "createdAt");
		List<MenuEntity> entityList = repository.findAll(sort);
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
		// TODO 尚未实现二叉树删除
		repository.deleteById(uuid);
	}

	/**
	 * 查询by uuid
	 * 
	 * @param uuid
	 */
	public MenuEntity getById(String uuid) throws Exception {
		Optional<MenuEntity> entity = repository.findById(uuid);
		return entity.get();
	}

	/**
	 * 查询下级菜单by uuid
	 * 
	 * @param uuid
	 */
	public List<MenuEntity> getChirdMenu(String uuid) throws Exception {
		List<MenuEntity> entityList = repository.findByParentUuid(uuid);
		return entityList;
	}

	/**
	 * 查询最大排序号
	 * 
	 */
	public Integer getMaxSortNum() throws Exception {
		return repository.getMaxSortNum();
	}

	/**
	 * 菜单手工排序更新
	 * 
	 * @throws Exception
	 * 
	 */
	public void saveSort(Map<String, Object> paraMap) throws Exception {
		String uuid = paraMap.get("uuid").toString();
		String parentUuid = paraMap.get("parentUuid").toString();
		MenuEntity entity = this.getById(uuid);
		entity.setParentUuid(parentUuid);
		entity.setUpdatedAt(new Date());
		entity.setUpdatedBy("updateBy");
		repository.save(entity);
		@SuppressWarnings("unchecked")
		List<String> idList = (List<String>) paraMap.get("idList");
		for (int i = 0; i < idList.size(); i++) {
			MenuEntity entityTmp = this.getById(idList.get(i));
			entityTmp.setSortNum(i);
			repository.save(entityTmp);
		}

	}

}
