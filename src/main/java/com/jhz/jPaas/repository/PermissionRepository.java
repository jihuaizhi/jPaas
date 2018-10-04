package com.jhz.jPaas.repository;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jhz.jPaas.entity.PermissionEntity;

/**
 * 数据库操作类
 * 
 * @author jihuaizhi
 * @since 2018-09-23
 */
@Repository
public interface PermissionRepository extends JpaRepository<PermissionEntity, String> {

	PermissionEntity findByPermissionCode(String permissionCode);

	@Modifying
	@Query(value = "delete from auth_permission where permission_code not in(?1)", nativeQuery = true)
	void deleteInvalidURL(List<String> validCodeList);

	List<PermissionEntity> findByDataStateOrderByPermissionCode(String dataState);

	@Query(value = "select p.permission_code from  auth_account a,auth_role_account ra,auth_role r,auth_role_permission rp,auth_permission p "
			+ " where a.uuid=ra.account_uuid and ra.role_uuid=r.uuid and r.uuid=rp.role_uuid and rp.permission_uuid=p.uuid and "
			+ " a.account_code=?1", nativeQuery = true)
	Set<String> findPermissionCodeByAccoountCode(String accountCode);

}