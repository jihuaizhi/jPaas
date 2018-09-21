package com.jhz.jPaas.common.exception;

/**
 * 自定义业务异常 待整理
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
public class BusinessException extends Exception {

	private static final long serialVersionUID = -4261641683869273758L;

	private String errCode;
	private String errMessage;

	/**
	 * 带错误信息的构造方法
	 * 
	 * @author jihuaizhi
	 * @param message
	 */
	public BusinessException(String errCode, String errMessage) {
		super(errMessage);
		this.errCode = errCode;
		this.errMessage = errMessage;
	}

	public String getErrCode() {
		return errCode;
	}

	public String getErrMessage() {
		return errMessage;
	}

}
