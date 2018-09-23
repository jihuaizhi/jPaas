package com.jhz.jPaas.repository;

import java.util.List;

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

}