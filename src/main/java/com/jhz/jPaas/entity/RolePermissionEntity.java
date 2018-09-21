package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 角色权限关联表Entity
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "auth_role_permission")
public class RolePermissionEntity extends BaseEntity {

	/**
	 * 角色uuid
	 */
	@Column(nullable = false)
	private String roleUuid;

	/**
	 * 权限uuid
	 */
	@Column(nullable = false)
	private String permissionUuid;

	public String getRoleUuid() {
		return roleUuid;
	}

	public void setRoleUuid(String roleUuid) {
		this.roleUuid = roleUuid;
	}

	public String getPermissionUuid() {
		return permissionUuid;
	}

	public void setPermissionUuid(String permissionUuid) {
		this.permissionUuid = permissionUuid;
	}

}
