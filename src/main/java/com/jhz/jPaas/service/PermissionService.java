package com.jhz.jPaas.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import com.jhz.jPaas.common.base.BaseService;
import com.jhz.jPaas.entity.PermissionEntity;
import com.jhz.jPaas.repository.PermissionRepository;
import com.jhz.jPaas.repository.RolePermissionRepository;

/**
 * 测试用service
 * 
 * @author jihuaizhi
 * @since 2018-09-20
 */
@Service
@Transactional
public class PermissionService extends BaseService {

	/**
	 * 注入Repository
	 */
	@Autowired
	private PermissionRepository repository;

	@Autowired
	private RolePermissionRepository rolePermissionRepository;

	/**
	 * 查询列表
	 * 
	 * @return entityList
	 */
	public List<PermissionEntity> getList() throws Exception {
		Sort sort = new Sort(Sort.Direction.ASC, "permissionCode");
		List<PermissionEntity> entityList = repository.findAll(sort);
		return entityList;

	}

	/**
	 * 新增/更新
	 * 
	 * @param entity
	 */
	public void save(PermissionEntity entity) throws Exception {
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
	public PermissionEntity getById(String uuid) throws Exception {
		Optional<PermissionEntity> entity = repository.findById(uuid);
		return entity.get();
	}

	/**
	 * 扫描系统URL
	 * 
	 * @param handlerMapping
	 */
	public void scanURL(RequestMappingHandlerMapping handlerMapping) throws Exception {
		// 获取所有Controller的@RequestMapping映射路径信息
		Map<RequestMappingInfo, HandlerMethod> map = handlerMapping.getHandlerMethods();
		Iterator<?> iterator = map.entrySet().iterator();
		List<String> validCodeList = new ArrayList<>();
		while (iterator.hasNext()) {
			@SuppressWarnings("rawtypes")
			Map.Entry entry = (Map.Entry) iterator.next();
			// Controller的@RequestMapping信息对象
			// RequestMappingInfo urlPath = (RequestMappingInfo) entry.getKey();
			String urlKey = entry.getKey().toString();
			// 提取url部分的字符串
			int strStartIndex = urlKey.indexOf("[");
			int strEndIndex = urlKey.indexOf("]");
			String permissionCode = urlKey.substring(strStartIndex, strEndIndex).substring(1);
			validCodeList.add(permissionCode);
			// 查询是否已经存在相同的url数据
			PermissionEntity pEntity = repository.findByPermissionCode(permissionCode);
			if (pEntity == null) {
				pEntity = new PermissionEntity();
				pEntity.setUuid(UUID.randomUUID().toString());
				pEntity.setPermissionCode(permissionCode);
				pEntity.setDataState(PermissionEntity.DATA_STATE_NORMAL);
				pEntity.setPermissionType(PermissionEntity.P_TYPE_URL);
				pEntity.setCreatedAt(new Date());
				pEntity.setCreatedBy("11111111");
				repository.saveAndFlush(pEntity);
			} else {
				pEntity.setDataState(PermissionEntity.DATA_STATE_NORMAL);
				pEntity.setPermissionType(PermissionEntity.P_TYPE_URL);
				pEntity.setUpdatedAt(new Date());
				pEntity.setUpdatedBy("11111111");
				repository.saveAndFlush(pEntity);
			}
		}
		// 删除关联表无效数据
		rolePermissionRepository.deleteInvalidURL(validCodeList);
		// 删除权限表中无效数据
		repository.deleteInvalidURL(validCodeList);
	}
}
