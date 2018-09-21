package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 规则条件表Entity
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "rule_condition")
public class RuleConditionEntity extends BaseEntity {

	/**
	 * 条件类型
	 */
	@Column
	private String conditionType;

	/**
	 * 字段名称
	 */
	@Column
	private String fieldName;

	/**
	 * 逻辑比较符
	 */
	@Column
	private String logicalOperator;

	/**
	 * 字段比较值
	 */
	@Column
	private String fieldValue;

	public String getConditionType() {
		return conditionType;
	}

	public String getFieldName() {
		return fieldName;
	}

	public String getLogicalOperator() {
		return logicalOperator;
	}

	public String getFieldValue() {
		return fieldValue;
	}

	public void setConditionType(String conditionType) {
		this.conditionType = conditionType;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public void setLogicalOperator(String logicalOperator) {
		this.logicalOperator = logicalOperator;
	}

	public void setFieldValue(String fieldValue) {
		this.fieldValue = fieldValue;
	}

}
