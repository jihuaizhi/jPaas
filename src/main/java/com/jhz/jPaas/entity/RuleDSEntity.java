package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 规则数据集表Entity<br>
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "rule_ds")
public class RuleDSEntity extends BaseEntity {

	/**
	 * 数据集名称
	 */
	@Column
	private String dsName;

	/**
	 * 数据集描述
	 */
	@Column
	private String dsDescription;

	/**
	 * 数据集对象名称？？？
	 */
	@Column
	private String dsObjectName;

	public String getDsName() {
		return dsName;
	}

	public String getDsDescription() {
		return dsDescription;
	}

	public String getDsObjectName() {
		return dsObjectName;
	}

	public void setDsName(String dsName) {
		this.dsName = dsName;
	}

	public void setDsDescription(String dsDescription) {
		this.dsDescription = dsDescription;
	}

	public void setDsObjectName(String dsObjectName) {
		this.dsObjectName = dsObjectName;
	}

}
