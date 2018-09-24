package com.jhz.jPaas.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jhz.jPaas.entity.RoleMenuEntity;

/**
 * 数据库操作类
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Repository
public interface RoleMenuRepository extends JpaRepository<RoleMenuEntity, String> {

	void deleteByRoleUuid(String roleUuid) throws Exception;

	List<RoleMenuEntity> findByRoleUuid(String uuid) throws Exception;

}