package com.jhz.jPaas.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jhz.jPaas.common.base.BaseService;
import com.jhz.jPaas.entity.AccountEntity;
import com.jhz.jPaas.repository.AccountRepository;

/**
 * 账户管理service
 * 
 * @author jihuaizhi
 * @since 2018-09-16
 */
@Service
@Transactional
public class AccountService extends BaseService {

	/**
	 * 注入Repository
	 */
	@Autowired
	private AccountRepository repository;

	/**
	 * 查询帐号列表
	 * 
	 * @return
	 */
	public List<AccountEntity> getAccountList() throws Exception {
		List<AccountEntity> entityList = repository.findAll();
		return entityList;

	}

	/**
	 * 新增/更新账号
	 * 
	 * @param accountEntity
	 */
	public void save(AccountEntity entity) throws Exception {
		repository.save(entity);
	}

	/**
	 * 删除帐号 TODO 帐号需要逻辑删除
	 * 
	 * @param uuid
	 */
	public void delete(String uuid) {
		repository.deleteById(uuid);
	}

	/**
	 * 查询帐号信息
	 * 
	 * @param uuid
	 */
	public AccountEntity getById(String uuid) throws Exception {
		Optional<AccountEntity> entity = repository.findById(uuid);
		return entity.get();
	}

	/**
	 * 重置密码
	 * 
	 * @param uuid,password
	 */
	public void resetPwd(String uuid, String password) throws Exception {
		repository.resetPwd(uuid, password);

	}

}
