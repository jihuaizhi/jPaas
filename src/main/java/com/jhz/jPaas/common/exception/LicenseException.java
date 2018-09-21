package com.jhz.jPaas.common.exception;

/**
 * 软件授权异常
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
public class LicenseException extends Exception {

	private static final long serialVersionUID = 1L;

	/**
	 * 带错误信息的构造方法
	 * 
	 * @author jihuaizhi
	 * @param message
	 */
	public LicenseException(String message) {
		super(message);
	}
}
