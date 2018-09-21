package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 规则检查记录表Entity
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "rule_check_record")
public class RuleCheckRecordEntity extends BaseEntity {

	/**
	 * 前置条件检查结果
	 */
	@Column
	private String prefixResult;

	/**
	 * 后置条件检查结果
	 */
	@Column
	private String decideResult;

	public String getPrefixResult() {
		return prefixResult;
	}

	public String getDecideResult() {
		return decideResult;
	}

	public void setPrefixResult(String prefixResult) {
		this.prefixResult = prefixResult;
	}

	public void setDecideResult(String decideResult) {
		this.decideResult = decideResult;
	}

}
