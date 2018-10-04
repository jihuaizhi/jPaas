package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 角色Entity<br>
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "auth_role")
public class RoleEntity extends BaseEntity {

	/**
	 * 超级管理员角色名
	 */
	public static final String SUPER_ADMINISTRATOR = "administrator";

	/**
	 * 角色编号
	 */
	@Column(nullable = false, unique = true)
	private String roleCode;

	/**
	 * 角色名称
	 */
	@Column(nullable = false, unique = true)
	private String roleName;

	/**
	 * 角色描述
	 */
	@Column
	private String roleDescription;

	public String getRoleCode() {
		return roleCode;
	}

	public String getRoleName() {
		return roleName;
	}

	public String getRoleDescription() {
		return roleDescription;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public void setRoleDescription(String roleDescription) {
		this.roleDescription = roleDescription;
	}

}
