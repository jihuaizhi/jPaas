package com.jhz.jPaas.repository;

import org.springframework.data.jpa.repository.JpaRepository;
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

	void deleteByRoleUuid(String roleUuid);

}