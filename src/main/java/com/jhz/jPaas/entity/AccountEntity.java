package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 用户Entity<br>
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "auth_account")
public class AccountEntity extends BaseEntity {

	/**
	 * 超级管理员用户名
	 */
	public static final String SUPER_ADMIN = "admin";

	public static final String DATA_STATE_STOP = "0";
	public static final String DATA_STATE_NORMAL = "1";

	/**
	 * 数据状态
	 */
	@Column(length = 1, nullable = false)
	protected String dataState = "1";

	/**
	 * 登录账号
	 */
	@Column(nullable = false, unique = true)
	private String accountCode;

	/**
	 * 帐号显示名称
	 */
	@Column(nullable = false)
	private String accountName;

	/**
	 * 密码
	 */
	@Column(nullable = false)
	private String password;

	public String getAccountName() {
		return accountName;
	}

	public String getPassword() {
		return password;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAccountCode() {
		return accountCode;
	}

	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}

	public String getDataState() {
		return dataState;
	}

	public void setDataState(String dataState) {
		this.dataState = dataState;
	}

}
