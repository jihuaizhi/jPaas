package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 角色账号关联表Entity
 * 
 * @author jihuaizhi
 * @since 2018-09-24
 */
@Entity(name = "auth_role_account")
public class RoleAccountEntity extends BaseEntity {

	/**
	 * 角色uuid
	 */
	@Column(nullable = false)
	private String roleUuid;

	/**
	 * 账号uuid
	 */
	@Column(nullable = false)
	private String accountUuid;

	public String getRoleUuid() {
		return roleUuid;
	}

	public void setRoleUuid(String roleUuid) {
		this.roleUuid = roleUuid;
	}

	public String getAccountUuid() {
		return accountUuid;
	}

	public void setAccountUuid(String accountUuid) {
		this.accountUuid = accountUuid;
	}

}
