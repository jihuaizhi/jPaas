package com.jhz.jPaas.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jhz.jPaas.common.base.BaseService;
import com.jhz.jPaas.entity.RoleEntity;
import com.jhz.jPaas.entity.RoleMenuEntity;
import com.jhz.jPaas.entity.RolePermissionEntity;
import com.jhz.jPaas.repository.RoleMenuRepository;
import com.jhz.jPaas.repository.RolePermissionRepository;
import com.jhz.jPaas.repository.RoleRepository;

/**
 * 角色管理service
 * 
 * @author jihuaizhi
 * @since 2018-09-20
 */
@Service
@Transactional
public class RoleService extends BaseService {

	/**
	 * 注入Repository
	 */
	@Autowired
	private RoleRepository repository;

	@Autowired
	private RoleMenuRepository roleMenuRepository;

	@Autowired
	private RolePermissionRepository rolePermissionRepository;

	// @Autowired
	// private RoleRepository repository;

	/**
	 * 查询列表
	 * 
	 * @return entityList
	 */
	public List<RoleEntity> getList() throws Exception {
		List<RoleEntity> entityList = repository.findAll();
		return entityList;

	}

	/**
	 * 新增
	 * 
	 * @param entity
	 * @param permissionUuid
	 * @param menuUuids
	 */
	public void insert(RoleEntity entity, String[] menuUuid, String[] permissionUuid) throws Exception {
		repository.save(entity);
		roleMenuRepository.deleteByRoleUuid(entity.getUuid());
		for (int i = 0; i < menuUuid.length; i++) {
			RoleMenuEntity roleMenuEntity = new RoleMenuEntity();
			roleMenuEntity.setUuid(UUID.randomUUID().toString());
			roleMenuEntity.setRoleUuid(entity.getUuid());
			roleMenuEntity.setMenuUuid(menuUuid[i]);
			roleMenuEntity.setCreatedAt(new Date());
			roleMenuEntity.setCreatedBy("");
			roleMenuRepository.save(roleMenuEntity);
		}
		rolePermissionRepository.deleteByRoleUuid(entity.getUuid());
		for (int i = 0; i < permissionUuid.length; i++) {
			RolePermissionEntity rolePermisiionEntity = new RolePermissionEntity();
			rolePermisiionEntity.setUuid(UUID.randomUUID().toString());
			rolePermisiionEntity.setRoleUuid(entity.getUuid());
			rolePermisiionEntity.setPermissionUuid(permissionUuid[i]);
			rolePermisiionEntity.setCreatedAt(new Date());
			rolePermisiionEntity.setCreatedBy("");
			rolePermissionRepository.save(rolePermisiionEntity);
		}

	}

	/**
	 * 更新
	 * 
	 * @param entity
	 * @param menuUuid
	 * @param permissionUuid
	 */
	public void update(RoleEntity entity, String[] menuUuid, String[] permissionUuid) throws Exception {
		repository.save(entity);
		roleMenuRepository.deleteByRoleUuid(entity.getUuid());
		for (int i = 0; i < menuUuid.length; i++) {
			RoleMenuEntity roleMenuEntity = new RoleMenuEntity();
			roleMenuEntity.setUuid(UUID.randomUUID().toString());
			roleMenuEntity.setRoleUuid(entity.getUuid());
			roleMenuEntity.setMenuUuid(menuUuid[i]);
			roleMenuEntity.setCreatedAt(new Date());
			roleMenuEntity.setCreatedBy("");
			roleMenuRepository.save(roleMenuEntity);
		}
		rolePermissionRepository.deleteByRoleUuid(entity.getUuid());
		for (int i = 0; i < permissionUuid.length; i++) {
			RolePermissionEntity rolePermisiionEntity = new RolePermissionEntity();
			rolePermisiionEntity.setUuid(UUID.randomUUID().toString());
			rolePermisiionEntity.setRoleUuid(entity.getUuid());
			rolePermisiionEntity.setPermissionUuid(permissionUuid[i]);
			rolePermisiionEntity.setCreatedAt(new Date());
			rolePermisiionEntity.setCreatedBy("");
			rolePermissionRepository.save(rolePermisiionEntity);
		}
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
	 * 查询by uuid
	 * 
	 * @param uuid
	 */
	public RoleEntity getById(String uuid) throws Exception {
		Optional<RoleEntity> entity = repository.findById(uuid);
		return entity.get();
	}

	/**
	 * 查询某角色的所属菜单
	 * 
	 * @param uuid
	 * @throws Exception
	 */
	public List<RoleMenuEntity> findMenuByRoleUuid(String uuid) throws Exception {
		List<RoleMenuEntity> menuList = roleMenuRepository.findByRoleUuid(uuid);
		return menuList;
	}

	/**
	 * 查询某角色的所属URL
	 * 
	 * @param uuid
	 * @return
	 * @throws Exception
	 */
	public List<RolePermissionEntity> findPermissionByRoleUuid(String uuid) throws Exception {
		List<RolePermissionEntity> permissionList = rolePermissionRepository.findByRoleUuid(uuid);
		return permissionList;
	}

}
