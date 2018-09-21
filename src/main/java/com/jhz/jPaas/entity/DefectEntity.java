package com.jhz.jPaas.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;

/**
 * 缺陷表Eetity
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Entity(name = "issue_defect")
public class DefectEntity extends BaseEntity {

	/**
	 * 缺陷编号
	 */
	@Column(unique = true)
	private String defectCode;

	/**
	 * 严重程度
	 */
	@Column
	private String defectLevel;

	/**
	 * 缺陷标题
	 */
	@Column
	private String defectTitle;

	/**
	 * 发生模块
	 */
	@Column
	private String defectModule;

	/**
	 * 缺陷内容
	 */
	@Column
	private String defectContent;

	/**
	 * 缺陷附件
	 */
	@Column
	private String defectAttachment;

	/**
	 * 解析人
	 */
	@Column
	private String analyseBy;

	/**
	 * 解析时间
	 */
	@Column
	private Date analyseAt;

	/**
	 * 解析內容
	 */
	@Column
	private String analyseContent;

	/**
	 * 修改人
	 */
	@Column
	private String modifyBy;

	/**
	 * 修改時間
	 */
	@Column
	private Date modifyAt;

	/**
	 * 修改內容
	 */
	@Column
	private String modifyContent;

	/**
	 * 验证人
	 */
	@Column
	private String validateBy;

	/**
	 * 验证时间
	 */
	@Column
	private Date validateAt;

	/**
	 * 验证内容
	 */
	@Column
	private String validateContent;

	/**
	 * 关闭类型
	 */
	@Column
	private String closeType;

	public String getDefectCode() {
		return defectCode;
	}

	public String getDefectLevel() {
		return defectLevel;
	}

	public String getDefectTitle() {
		return defectTitle;
	}

	public String getDefectModule() {
		return defectModule;
	}

	public String getDefectContent() {
		return defectContent;
	}

	public String getDefectAttachment() {
		return defectAttachment;
	}

	public String getAnalyseBy() {
		return analyseBy;
	}

	public Date getAnalyseAt() {
		return analyseAt;
	}

	public String getAnalyseContent() {
		return analyseContent;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public Date getModifyAt() {
		return modifyAt;
	}

	public String getModifyContent() {
		return modifyContent;
	}

	public String getValidateBy() {
		return validateBy;
	}

	public Date getValidateAt() {
		return validateAt;
	}

	public String getValidateContent() {
		return validateContent;
	}

	public String getCloseType() {
		return closeType;
	}

	public void setDefectLevel(String defectLevel) {
		this.defectLevel = defectLevel;
	}

	public void setDefectTitle(String defectTitle) {
		this.defectTitle = defectTitle;
	}

	public void setDefectModule(String defectModule) {
		this.defectModule = defectModule;
	}

	public void setDefectContent(String defectContent) {
		this.defectContent = defectContent;
	}

	public void setDefectAttachment(String defectAttachment) {
		this.defectAttachment = defectAttachment;
	}

	public void setAnalyseBy(String analyseBy) {
		this.analyseBy = analyseBy;
	}

	public void setAnalyseAt(Date analyseAt) {
		this.analyseAt = analyseAt;
	}

	public void setAnalyseContent(String analyseContent) {
		this.analyseContent = analyseContent;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public void setModifyAt(Date modifyAt) {
		this.modifyAt = modifyAt;
	}

	public void setModifyContent(String modifyContent) {
		this.modifyContent = modifyContent;
	}

	public void setValidateBy(String validateBy) {
		this.validateBy = validateBy;
	}

	public void setValidateAt(Date validateAt) {
		this.validateAt = validateAt;
	}

	public void setValidateContent(String validateContent) {
		this.validateContent = validateContent;
	}

	public void setCloseType(String closeType) {
		this.closeType = closeType;
	}

	public void setDefectCode(String defectCode) {
		this.defectCode = defectCode;
	}

}