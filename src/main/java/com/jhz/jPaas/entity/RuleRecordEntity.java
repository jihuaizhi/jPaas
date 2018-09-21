package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 规则表Entity<br>
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "rule_record")
public class RuleRecordEntity extends BaseEntity {

	/**
	 * 规则名称
	 */
	@Column
	private String ruleName;

	/**
	 * 规则描述
	 */
	@Column
	private String ruleDescription;

	/**
	 * 关联数据集uuid
	 */
	@Column
	private String dsUuid;

	public String getRuleDescription() {
		return ruleDescription;
	}

	public void setRuleDescription(String ruleDescription) {
		this.ruleDescription = ruleDescription;
	}

	public String getRuleName() {
		return ruleName;
	}

	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}

	public String getDsUuid() {
		return dsUuid;
	}

	public void setDsUuid(String dsUuid) {
		this.dsUuid = dsUuid;
	}

}
