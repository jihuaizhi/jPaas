package com.jhz.jPaas.repository;

import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jhz.jPaas.config.Set;
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
			+ "where r.uuid=ra.role_uuid and a.uuid=ra.account_uuid and a.account_code=?1)", nativeQuery = true)
	java.util.Set<String> findRoleCodeByAccoountName(String accountName);

}