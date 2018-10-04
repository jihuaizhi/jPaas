package com.jhz.jPaas.common.filter;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Set;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.filter.authz.PermissionsAuthorizationFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jhz.jPaas.common.JPConstant;
import com.jhz.jPaas.common.ReturnModel;
import com.jhz.jPaas.common.WebDevUtils;
import com.jhz.jPaas.entity.AccountEntity;
import com.jhz.jPaas.entity.RoleEntity;
import com.jhz.jPaas.repository.RoleRepository;

import net.sf.json.JSONObject;

/**
 * @Desc 用于自定义过滤器，过滤用户请求是否被授权
 * @author jihuaizhi
 * @date 2018-10-01
 * @version
 */
public class ShiroPermsFilter extends PermissionsAuthorizationFilter {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private RoleRepository roleRepository;

	/*
	 * 拦截请求,判断是否具备访问权限
	 */
	@Override
	public boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue)
			throws IOException {
		// 获取当前登录账号
		AccountEntity entity = (AccountEntity) SecurityUtils.getSubject().getPrincipal();
		HttpServletRequest httpReq = (HttpServletRequest) request;
		if (null != entity) {
			// 获取当前用户的角色列表
			Set<String> roleSet = roleRepository.findRoleCodeByAccoountCode(entity.getAccountCode());
			// 检查角色列表是否包含超级管理员角色
			if (roleSet.contains(RoleEntity.SUPER_ADMINISTRATOR)) {
				// 超级管理员角色的用户跳过所有权限检查
				logger.info("权限验证过滤器---URL:" + httpReq.getServletPath() + " 超级管理员:跳过检查");
				return true;
			}
		}
		boolean isAccess = super.isAccessAllowed(request, response, mappedValue);
		logger.info("权限验证过滤器---URL:" + httpReq.getServletPath() + " 验证结果:" + isAccess);
		return super.isAccessAllowed(request, response, mappedValue);
	}

	/**
	 * 会话超时或权限校验未通过的，返回错误信息
	 */
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws IOException {
		if (WebDevUtils.isAjax(request)) {
			// ajax请求的场合,返回json
			ReturnModel returnModel = new ReturnModel();
			returnModel.putError(JPConstant.FTL_003, "权限检查失败，请联系管理员授权!");
			response.setCharacterEncoding("UTF-8");// 设置编码
			response.setContentType("application/json");// 设置返回类型
			PrintWriter out = response.getWriter();
			out.println(JSONObject.fromObject(returnModel).toString());
			out.flush();
			out.close();
			return false;
		} else {
			// http请求的场合,跳转至登录页面
			return super.onAccessDenied(request, response);

		}
	}

}