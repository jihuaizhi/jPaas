package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 用户角色关联表Entity
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "auth_user_role")
public class UserRoleEntity extends BaseEntity {

	/**
	 * 用户uuid
	 */
	@Column(nullable = false)
	private String userUuid;

	/**
	 * 角色uuid
	 */
	@Column(nullable = false)
	private String roleUuid;

	public String getUserUuid() {
		return userUuid;
	}

	public void setUserUuid(String userUuid) {
		this.userUuid = userUuid;
	}

	public String getRoleUuid() {
		return roleUuid;
	}

	public void setRoleUuid(String roleUuid) {
		this.roleUuid = roleUuid;
	}

}
