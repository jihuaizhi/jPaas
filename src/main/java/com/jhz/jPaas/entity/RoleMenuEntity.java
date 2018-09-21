package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 角色菜单关联表Entity
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "auth_role_menu")
public class RoleMenuEntity extends BaseEntity {

	/**
	 * 角色uuid
	 */
	@Column(nullable = false)
	private String roleUuid;

	/**
	 * 菜单uuid
	 */
	@Column(nullable = false)
	private String menuUuid;

	public String getRoleUuid() {
		return roleUuid;
	}

	public void setRoleUuid(String roleUuid) {
		this.roleUuid = roleUuid;
	}

	public String getMenuUuid() {
		return menuUuid;
	}

	public void setMenuUuid(String menuUuid) {
		this.menuUuid = menuUuid;
	}

}
