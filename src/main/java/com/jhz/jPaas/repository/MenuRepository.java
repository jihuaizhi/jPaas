package com.jhz.jPaas.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jhz.jPaas.entity.MenuEntity;

/**
 * 角色管理数据库操作类
 * 
 * @author jihuaizhi
 * @since 2018-09-20
 */
@Repository
public interface MenuRepository extends JpaRepository<MenuEntity, String> {

}