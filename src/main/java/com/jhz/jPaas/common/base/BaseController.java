package com.jhz.jPaas.common.base;

import java.text.ParseException;
import java.util.NoSuchElementException;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.UnauthenticatedException;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhz.jPaas.common.JPConstant;
import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.common.exception.BusinessException;
import com.jhz.jPaas.common.exception.LicenseException;
import com.jhz.jPaas.entity.AccountEntity;

/**
 * Controller父类 注入日志处理类 logger 注入请求返回值封装类ModelResult 统一异常处理
 * 
 * TODO springboot异常处理机制需要梳理 https://www.cnblogs.com/shyroke/p/8023625.html
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@ControllerAdvice
public abstract class BaseController {

	/**
	 * 日志处理对象
	 */
	protected final Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * 注入返回值封装类
	 */
	@Autowired
	protected ReturnModel returnModel;

	/**
	 * ModelAttribute 所有controller方法执行前会执行此方法,方法内可进行公共的检查或者其它功能
	 * 
	 */
	@ModelAttribute
	public void checkAuthenticated(HttpServletRequest request) {
		// 初始化返回值封装类，否则导致多次请求的返回值累加
		returnModel = new ReturnModel();
		// logger.info("控制器请求-------,url :" + request.getRequestURI());
	}

	/**
	 * 获取当前登录帐号
	 * 
	 */
	public AccountEntity getLoginAccount() {
		Subject loginUser = SecurityUtils.getSubject();
		Session session = loginUser.getSession();
		AccountEntity entity = (AccountEntity) session.getAttribute(AccountEntity.SESSION_KEY_ACCOUNT);
		return entity;
	}

	/**
	 * 系统自定义异常，由控制器抛出，本方法统一处理
	 * 此类异常不需要跳转错误页面或者中断业务操作,仅需要向前端返回相关的错误信息
	 * 
	 * @param ex
	 * @return
	 */
	@ExceptionHandler(BusinessException.class)
	@ResponseBody
	public ReturnModel RADFExceptionHandle(Exception ex) {
		logger.error("\n业务异常:" + ex.toString());
		ReturnModel rModel = new ReturnModel();
		if (ex instanceof BusinessException) {
			BusinessException businessException = (BusinessException) ex;
			rModel.putError(businessException.getErrCode(), businessException.getErrMessage());
		}
		return rModel;
	}

	/**
	 * 系统身份认证异常
	 * 
	 * @return
	 */
	@ExceptionHandler({ AuthenticationException.class, UnknownAccountException.class,
			IncorrectCredentialsException.class, LockedAccountException.class, UnauthenticatedException.class })
	@ResponseBody
	public ReturnModel authenticationExceptionHandle(Exception ex) {
		// 记录错误日志到控制台,文件,数据库等处理
		logger.error("\n系统身份认证异常:" + ex.toString());
		ReturnModel rModel = new ReturnModel();
		if (ex instanceof UnknownAccountException) {
			rModel.putError(JPConstant.FTL_002, "用户名或密码错误!");
		} else if (ex instanceof IncorrectCredentialsException) {
			rModel.putError(JPConstant.FTL_002, "用户名或密码错误!");
		} else if (ex instanceof LockedAccountException) {
			rModel.putError(JPConstant.FTL_002, "账号已经被锁定!");
		} else if (ex instanceof UnauthenticatedException) {
			rModel.putError(JPConstant.FTL_002, "尚未登录系统!");
		} else if (ex instanceof AuthenticationException) {
			rModel.putError(JPConstant.FTL_002, "未知的身份认证异常!");
		}
		return rModel;
	}

	/**
	 * 系统角色权限授权异常
	 * 
	 * @return
	 */
	@ExceptionHandler({ UnauthorizedException.class })
	@ResponseBody
	public ReturnModel authorizationExceptionHandle(Exception ex) {
		// 记录错误日志到控制台,文件,数据库等处理
		logger.error("\n系统角色权限授权异常:" + ex.toString());
		ReturnModel rModel = new ReturnModel();
		if (ex instanceof UnauthorizedException) {
			rModel.putError(JPConstant.FTL_003, "您没有权限访问该资源或者功能,请联系管理员授权后重新登录系统!");
		}
		return rModel;
	}

	/**
	 * 数据操作类异常处理
	 * 此类异常不需要跳转错误页面或者中断业务操作,仅需要向前端返回相关的错误信息<br>
	 * 
	 * @param ex
	 * @return
	 */
	@ExceptionHandler({ DuplicateKeyException.class, ParseException.class, NumberFormatException.class,
			DataIntegrityViolationException.class, NoSuchElementException.class })
	@ResponseBody
	public ReturnModel businessExceptionHandle(Exception ex) {
		logger.error("\n服务端业务异常:" + ex.toString());
		ex.printStackTrace();
		ReturnModel rModel = new ReturnModel();
		if (ex instanceof DuplicateKeyException) {
			// 主键冲突异常,返回错误信息
			rModel.putError(JPConstant.ERR_001, "主键冲突：记录已经存在!");
		} else if (ex instanceof DataIntegrityViolationException) {
			// 外键约束异常,返回错误信息
			rModel.putError(JPConstant.ERR_002, "您要添加的数据已经存在，请修改重复的字段值!");
		} else if (ex instanceof ParseException) {
			// 类型转换异常,返回错误信息
			rModel.putError(JPConstant.ERR_020, "部分字段输入类型不符合要求!");
		} else if (ex instanceof NumberFormatException) {
			// 其它未知业务异常
			rModel.putError(JPConstant.ERR_021, "数字格式错误!");
		} else if (ex instanceof NoSuchElementException) {
			rModel.putError(JPConstant.ERR_010, "操作的数据已经不存在了!");
		}
		return rModel;
	}

	/**
	 * 软件产品授权异常
	 * 
	 * @param ex
	 * @return
	 */
	@ExceptionHandler(LicenseException.class)
	@ResponseBody
	public ReturnModel licenseExceptionHandle(Exception ex) {
		String errorMsg = "\n软件产品授权异常:" + "您使用的软件产品未被正确授权,系统即将退出,请联系软件产品的公司获取正确的授权!";
		logger.error(errorMsg);
		ReturnModel rModel = new ReturnModel();
		rModel.putError(JPConstant.FTL_001, errorMsg);
		return rModel;
	}

	/**
	 * 以上异常以外的其它所有未知异常
	 * 
	 * @param ex
	 */
	@ExceptionHandler
	@ResponseBody
	public ReturnModel unbeknownSystemExceptionHandle(Exception ex) {
		String errorMsg = "\n服务端未知异常！" + ex.getMessage();
		ex.printStackTrace();
		logger.error(errorMsg + ex.toString());
		ReturnModel rModel = new ReturnModel();
		rModel.putError(JPConstant.FTL_999, errorMsg);
		return rModel;
	}

}