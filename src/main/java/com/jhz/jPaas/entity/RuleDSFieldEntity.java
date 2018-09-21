package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 规则数据集字段映射表Entity
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "rule_ds_field")
public class RuleDSFieldEntity extends BaseEntity {

	/**
	 * 字段英文代码
	 */
	@Column
	private String fieldCode;

	/**
	 * 字段显示名称
	 */
	@Column
	private String fieldName;


	public String getFieldCode() {
		return fieldCode;
	}

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldCode(String fieldCode) {
		this.fieldCode = fieldCode;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

}
