package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 权限表Entity
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "auth_permission")
public class PermissionEntity extends BaseEntity {

	/**
	 * permissionType 选项
	 */
	public static final String P_TYPE_URL = "1"; // URL
	public static final String P_TYPE_OP = "2"; // 操作
	public static final String P_TYPE_MENU = "3"; // 菜单
	public static final String P_TYPE_UI = "4"; // UI可见性
	public static final String P_TYPE_TABLE = "5"; // 数据库对象
	public static final String P_TYPE_DATA = "6"; // 数据过滤

	/**
	 * 权限编码 URL地址
	 */
	@Column(nullable = false, unique = true)
	private String permissionCode;

	/**
	 * 权限名称 中文简短名称
	 */
	@Column(nullable = false, unique = true)
	private String permissionName;

	/**
	 * 权限类型(1:URL 2:菜单项 3:UI/UI部件 4:数据库表 5:数据过滤)
	 */
	@Column(nullable = false)
	private String permissionType;

	/**
	 * 权限说明 权限详细描述
	 */
	@Column
	private String permissionDescription;

	public String getPermissionCode() {
		return permissionCode;
	}

	public String getPermissionName() {
		return permissionName;
	}

	public String getPermissionType() {
		return permissionType;
	}

	public String getPermissionDescription() {
		return permissionDescription;
	}

	public void setPermissionCode(String permissionCode) {
		this.permissionCode = permissionCode;
	}

	public void setPermissionName(String permissionName) {
		this.permissionName = permissionName;
	}

	public void setPermissionType(String permissionType) {
		this.permissionType = permissionType;
	}

	public void setPermissionDescription(String permissionDescription) {
		this.permissionDescription = permissionDescription;
	}
}
