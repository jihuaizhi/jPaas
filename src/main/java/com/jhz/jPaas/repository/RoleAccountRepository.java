package com.jhz.jPaas.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jhz.jPaas.entity.RoleAccountEntity;

/**
 * 数据库操作类
 * 
 * @author jihuaizhi
 * @since 2018-09-24
 */
@Repository
public interface RoleAccountRepository extends JpaRepository<RoleAccountEntity, String> {

	void deleteByAccountUuid(String roleUuid);

	@Query(value = "select ra.role_uuid from auth_role_account ra where  ra.account_uuid=?1", nativeQuery = true)
	List<String> findRoleUuidByAccountUuid(String accountUuid);

}