package com.jhz.jPaas.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jhz.jPaas.entity.MenuEntity;

/**
 * 数据库操作类
 * 
 * @author jihuaizhi
 * @since 2018-09-20
 */
@Repository
public interface MenuRepository extends JpaRepository<MenuEntity, String> {

	List<MenuEntity> findByParentUuid(String uuid);

	@Query(value = "select IFNULL(max(sort_num),0)  from auth_menu", nativeQuery = true)
	Integer getMaxSortNum();

	@Query(value = "select m.* from auth_account a,auth_role_account ra,auth_role r,auth_role_menu rm,auth_menu m "
			+ "where a.uuid=	ra.account_uuid and ra.role_uuid=r.uuid and r.uuid=rm.role_uuid and rm.menu_uuid=	m.uuid and "
			+ "a.uuid=?1 order by m.sort_num", nativeQuery = true)

	List<MenuEntity> findAccountMenuList(String accountUuid);

}