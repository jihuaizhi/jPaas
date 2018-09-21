package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 字典数据表Entity
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "sys_dict_data")
public class DictDataEntity extends BaseEntity {

	/**
	 * 字典数据项代码
	 */
	@Column(nullable = false)
	private String dictDataCode;

	/**
	 * 字典数据项名称
	 */
	@Column(nullable = false)
	private String dictDataName;

	public String getDictDataCode() {
		return dictDataCode;
	}

	public String getDictDataName() {
		return dictDataName;
	}

	public void setDictDataCode(String dictDataCode) {
		this.dictDataCode = dictDataCode;
	}

	public void setDictDataName(String dictDataName) {
		this.dictDataName = dictDataName;
	}

}