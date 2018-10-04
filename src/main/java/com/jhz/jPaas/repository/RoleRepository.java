package com.jhz.jPaas.repository;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jhz.jPaas.entity.RoleEntity;

/**
 * 数据库操作类
 * 
 * @author jihuaizhi
 * @since 2018-09-20
 */
@Repository
public interface RoleRepository extends JpaRepository<RoleEntity, String> {

	@Query(value = "select role_code from auth_role r,auth_account a,auth_role_account ra "
			+ "where r.uuid=ra.role_uuid and a.uuid=ra.account_uuid and a.account_code=?1", nativeQuery = true)
	Set<String> findRoleCodeByAccoountCode(String accountCode);

	@Query(value = "select r.* from auth_role r,auth_role_account ra "
			+ "where r.uuid=ra.role_uuid and ra.account_uuid=?1", nativeQuery = true)
	List<RoleEntity> findByAccountUuid(String accountUuid);

}