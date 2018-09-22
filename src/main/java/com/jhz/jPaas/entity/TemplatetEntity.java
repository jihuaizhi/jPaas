package com.jhz.jPaas.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;

/**
 * 测试用表
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 *
 */
@Entity(name = "test_entity")
@GenericGenerator(name = "jpa-uuid", strategy = "uuid")
public class TemplatetEntity implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * 物理主键
	 */
	@Id
	@GeneratedValue(generator = "jpa-uuid")
	private String uuid;

	/**
	 * 账户名
	 */
	@Column(nullable = false, unique = true)
	private String accountName;

	/**
	 * 用户姓名
	 */
	@Column(nullable = false, unique = false)
	private String userName;

	/**
	 * 登录密码
	 */
	@Column(nullable = false)
	private String password;

	/**
	 * 电子邮箱
	 */
	@Column
	private String email;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * 创建时间
	 */
	@Column(nullable = false)
	private Date createdAt;

	/**
	 * 创建人uuid
	 */
	@Column(nullable = false)
	private String createdBy;

	/**
	 * 更新时间
	 */
	@Column(nullable = true)
	private Date updatedAt;

	/**
	 * 创建人uuid
	 */
	@Column(nullable = true)
	private Date updatedBy;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public Date getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(Date updatedBy) {
		this.updatedBy = updatedBy;
	}

}