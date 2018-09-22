package com.jhz.jPaas.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jhz.jPaas.common.base.BaseService;
import com.jhz.jPaas.entity.TemplatetEntity;
import com.jhz.jPaas.repository.TemplateRepository;

/**
 * 测试用service
 * 
 * @author jihuaizhi
 * @since 2018-09-20
 */
@Service
@Transactional
public class TemplateService extends BaseService {

	// @Transactional(readOnly = true) // 配置事务 查询使用只读
	// public boolean Login() throws Exception {
	// return false;
	//
	// }
	//
	// @Transactional(readOnly = false) // (增删改要写 ReadOnly=false 为可写 默认值)
	// public boolean InsertUser() throws Exception {
	// return false;
	//
	// }

	/**
	 * 注入Repository
	 */
	@Autowired
	private TemplateRepository repository;

	/**
	 * 查询列表
	 * 
	 * @return entityList
	 */
	public List<TemplatetEntity> getList() throws Exception {
		List<TemplatetEntity> entityList = repository.findAll();
		return entityList;

	}

	/**
	 * 新增/更新
	 * 
	 * @param entity
	 */
	public void save(TemplatetEntity entity) throws Exception {
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
	public TemplatetEntity getById(String uuid) throws Exception {
		Optional<TemplatetEntity> entity = repository.findById(uuid);
		return entity.get();
	}

}
