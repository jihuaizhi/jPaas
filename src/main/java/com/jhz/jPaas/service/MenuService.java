package com.jhz.jPaas.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ResourceUtils;

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
		Sort sort = new Sort(Sort.Direction.ASC, "sortNum");
		List<MenuEntity> entityList = repository.findAll(sort);
		return entityList;

	}

	/**
	 * 查当前用户授权菜单列表
	 * 
	 * @param accountUuid
	 * 
	 * @return
	 */
	public List<MenuEntity> getAccountMenuList(String accountUuid) {
		List<MenuEntity> entityList = repository.findAccountMenuList(accountUuid);
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

	/**
	 * 扫描文件
	 * 
	 * @return
	 * @throws FileNotFoundException
	 */
	public List<Map<String, String>> scanHtml() throws FileNotFoundException {
		File file = ResourceUtils.getFile("classpath:public");
		List<Map<String, String>> list = func(file, file.getAbsolutePath());
		return list;
	}

	/**
	 * 遍历文件的递归算法
	 * 
	 * @param file
	 * @param basePath
	 * @return
	 */
	private List<Map<String, String>> func(File file, String basePath) {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		File[] fs = file.listFiles();
		for (File f : fs) {
			if (f.isDirectory()) // 若是目录，则递归打印该目录下的文件
				list.addAll(func(f, basePath));
			if (f.isFile()) {
				String fileName = f.getName();
				String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
				if ("html".equalsIgnoreCase(suffix)) {
					Map<String, String> map = new HashMap<String, String>();
					map.put("url", f.getAbsolutePath().replace(basePath, ""));
					list.add(map);
				}
			}
		}
		return list;
	}

}
