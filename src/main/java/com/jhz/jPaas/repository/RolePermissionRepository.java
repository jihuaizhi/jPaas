package com.jhz.jPaas.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jhz.jPaas.entity.RolePermissionEntity;

/**
 * 数据库操作类
 * 
 * @author jihuaizhi
 * @since 2018-09-23
 */
@Repository
public interface RolePermissionRepository extends JpaRepository<RolePermissionEntity, String> {

	@Modifying
	@Query(value = "delete rp from auth_permission p,auth_role_permission rp where p.uuid=rp.permission_uuid and p.permission_code not in(?1)", nativeQuery = true)
	void deleteInvalidURL(List<String> validCodeList);

	void deleteByPermissionUuid(String uuid);

	List<RolePermissionEntity> findByRoleUuid(String uuid);

	void deleteByRoleUuid(String uuid);

}