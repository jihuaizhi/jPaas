package com.jhz.jPaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 菜单表Entity
 * 
 * @author jihuaizhi
 * @since 2018-09-20
 */
@Entity(name = "auth_menu")
public class MenuEntity extends BaseEntity {

	/**
	 * 父级菜单uuid，顶级菜单的父级菜单uuid=""
	 */
	@Column(length = 36, nullable = false)
	private String parentUuid;

	/**
	 * 手工排序号
	 */
	@Column(nullable = false)
	private Integer sortNum;

	/**
	 * 菜单名称
	 */
	@Column(nullable = false)
	private String menuName;

	/**
	 * 菜单链接
	 */
	@Column(nullable = false)
	private String menuLink;

	/**
	 * 菜单图标
	 */
	@Column(nullable = false)
	private String menuIcon;

	public String getMenuName() {
		return menuName;
	}

	public String getMenuLink() {
		return menuLink;
	}

	public String getMenuIcon() {
		return menuIcon;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public void setMenuLink(String menuLink) {
		this.menuLink = menuLink;
	}

	public void setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
	}

	public String getParentUuid() {
		return parentUuid;
	}

	public void setParentUuid(String parentUuid) {
		this.parentUuid = parentUuid;
	}

	public Integer getSortNum() {
		return sortNum;
	}

	public void setSortNum(Integer sortNum) {
		this.sortNum = sortNum;
	}
}
