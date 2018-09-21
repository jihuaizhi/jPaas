package com.jhz.jPaas.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

/**
 * Controller返回值封装
 * 作用:
 * 封装操作成功标记
 * 封装错误信息列表
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Component
public class ReturnModel extends HashMap<String, Object> {

	private static final long serialVersionUID = 1L;
	private static final String ERROR_LIST_KEY = "errList";
	private static final String SUCCESS_KEY = "success";
	private static final String ERROR_CODE_KEY = "errCode";
	private static final String ERROR_MESSAGE_KEY = "errMessage";

	/**
	 * 用于封装后端向前端传递的异常信息，前端捕获后根据业务进行处理
	 */
	private List<Map<String, String>> errList;

	/**
	 * 默认构造方法,初始化success=true
	 * 
	 * @author jihuaizhi
	 */
	public ReturnModel() {
		this.errList = new ArrayList<>();
		this.put(ERROR_LIST_KEY, this.errList);
		this.put(SUCCESS_KEY, true);
	}

	/**
	 * 向对象的错误信息列表追加错误信息内容
	 * 
	 * @author jihuaizhi
	 * @param errCode
	 * @param errMessage
	 */
	public void putError(String errCode, String errMessage) {
		HashMap<String, String> map = new HashMap<>();
		map.put(ERROR_CODE_KEY, errCode);
		map.put(ERROR_MESSAGE_KEY, errMessage);
		this.errList.add(map);
		this.put(ERROR_LIST_KEY, this.errList);
		this.put(SUCCESS_KEY, false);
	}

}
