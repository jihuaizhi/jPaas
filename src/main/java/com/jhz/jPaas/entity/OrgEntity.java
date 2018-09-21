package com.jhz.jPaas.entity;

import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 组织机构表Entity
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "auth_org")
public class OrgEntity extends BaseEntity {

	/**
	 * 组织机构编号
	 */
	private String orgCode;

	/**
	 * 组织机构名称
	 */
	private String orgName;

	public String getOrgCode() {
		return orgCode;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

}
