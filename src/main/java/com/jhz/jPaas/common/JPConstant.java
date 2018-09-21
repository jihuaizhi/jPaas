package com.jhz.jPaas.common;

/**
 * 全局常量类
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
public class JPConstant {

	/****************************************** 后端向前端进行异常传递时使用的一般错误代码 *********************************************/
	/**
	 * 异常分类 一般业务异常：ERROR 前端不中断用户当前操作，将错误信息反馈给操作客户即可,或者根据业务进行画面迁移 系统致命异常：FATAL
	 * 前端需要退出系统，跳转到专用的异常页面，将异常信息告知用户，故障解决后重新进入系统才能继续业务
	 * 
	 */

	/**
	 * 主键冲突，存在重复记录
	 */
	public static final String ERR_001 = "ERR_001";

	/**
	 * 外键冲突,约束性异常
	 */
	public static final String ERR_002 = "ERR_002";

	/**
	 * 字段为空 缺少必填信息
	 */
	public static final String ERR_003 = "ERR_003";

	/**
	 * 查询结果为0
	 */
	public static final String ERR_010 = "ERR_010";

	/**
	 * 类型转换失败
	 */
	public static final String ERR_020 = "ERR_020";

	/**
	 * 数据格式异常
	 */
	public static final String ERR_021 = "ERR_021";

	/**
	 * 软件授权异常
	 */
	public static final String FTL_001 = "FTL_001";

	/**
	 * 身份认证异常
	 */
	public static final String FTL_002 = "FTL_002";

	/**
	 * 访问权限异常
	 */
	public static final String FTL_003 = "FTL_003";

	/**
	 * WEB服务器系统异常
	 */
	public static final String FTL_888 = "FTL_888";

	/**
	 * 未知原因的系统异常
	 */
	public static final String FTL_999 = "FTL_999";

}
