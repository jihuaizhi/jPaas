package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.validation.constraints.NotBlank;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 字典表Eetity
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "sys_dict")
public class DictEntity extends BaseEntity {

	/**
	 * 字典代码
	 */
	@Column(nullable = false, unique = true)
	@NotBlank(message = "字典代码不能为空!")
	private String dictCode;

	/**
	 * 字典名称
	 */
	@Column(nullable = false, unique = true)
	@NotBlank(message = "字典名称不能为空!")
	private String dictName;

	public String getDictCode() {
		return dictCode;
	}

	public String getDictName() {
		return dictName;
	}

	public void setDictCode(String dictCode) {
		this.dictCode = dictCode;
	}

	public void setDictName(String dictName) {
		this.dictName = dictName;
	}

}