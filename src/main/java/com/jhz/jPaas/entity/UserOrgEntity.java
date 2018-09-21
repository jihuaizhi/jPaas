package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 用户组织机构关联表Entity
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "auth_user_org")
public class UserOrgEntity extends BaseEntity {

	/**
	 * 用户uuid
	 */
	@Column(nullable = false)
	private String userUuid;

	/**
	 * 组织机构uuid
	 */
	@Column(nullable = false)
	private String orgUuid;

	/**
	 * 组织机构类型 1:默认部门 2:兼职部门
	 */
	@Column(nullable = false)
	private String orgType;

	public String getUserUuid() {
		return userUuid;
	}

	public void setUserUuid(String userUuid) {
		this.userUuid = userUuid;
	}

	public String getOrgUuid() {
		return orgUuid;
	}

	public void setOrgUuid(String orgUuid) {
		this.orgUuid = orgUuid;
	}

	public String getOrgType() {
		return orgType;
	}

	public void setOrgType(String orgType) {
		this.orgType = orgType;
	}

}
