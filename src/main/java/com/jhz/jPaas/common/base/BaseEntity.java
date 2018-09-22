package com.jhz.jPaas.common.base;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * Entity父类
 * 声明所有表都有的公共字段
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@MappedSuperclass
public abstract class BaseEntity implements Serializable {

	public static final long serialVersionUID = 1L;

	/**
	 * 物理主键
	 */
	@Id
	@Column(length = 36)
	protected String uuid;

	/**
	 * 创建者uuid
	 */
	@Column(length = 36, nullable = false, updatable = false)
	protected String createdBy;

	/**
	 * 创建时间
	 */
	@Column(nullable = false, updatable = false)
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	protected Date createdAt = new Date();

	/**
	 * 更新者uuid
	 */
	@Column(length = 36)
	protected String updatedBy;

	/**
	 * 更新时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	protected Date updatedAt = new Date();

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

}
