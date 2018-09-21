package com.jhz.jPaas.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 用户信息表Entity
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "auth_user_info")
public class UserInfoEntity extends BaseEntity {

	/**
	 * 用户姓名
	 */
	@Column(nullable = false)
	private String userName;

	/**
	 * 电子邮件
	 */
	@Column
	private String email;

	/**
	 * 性别
	 */
	@Column
	private String sex;

	/**
	 * 出生日期
	 */
	@Column
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date birthday;

	public String getUserName() {
		return userName;
	}

	public String getEmail() {
		return email;
	}

	public String getSex() {
		return sex;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
