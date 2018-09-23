package com.jhz.jPaas.repository;

import org.springframework.data.jpa.repository.JpaRepository;
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

}