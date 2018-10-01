package com.jhz.jPaas.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jhz.jPaas.common.base.BaseService;
import com.jhz.jPaas.entity.AccountEntity;
import com.jhz.jPaas.entity.RoleAccountEntity;
import com.jhz.jPaas.repository.AccountRepository;
import com.jhz.jPaas.repository.RoleAccountRepository;

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

	@Autowired
	private RoleAccountRepository roleAccountRepository;

	/**
	 * 查询帐号列表
	 * 
	 * @return
	 */
	public List<AccountEntity> getAccountList() throws Exception {
		Sort sort = new Sort(Sort.Direction.ASC, "createdAt");
		List<AccountEntity> entityList = repository.findAll(sort);
		return entityList;

	}

	/**
	 * 新增/更新账号
	 * 
	 * @param roleUuid
	 * 
	 * @param accountEntity
	 */
	public void save(AccountEntity entity, String[] roleUuid) throws Exception {
		repository.save(entity);
		roleAccountRepository.deleteByRoleUuid(entity.getUuid());
		for (int i = 0; i < roleUuid.length; i++) {
			RoleAccountEntity rAccountEntity = new RoleAccountEntity();
			rAccountEntity.setUuid(UUID.randomUUID().toString());
			rAccountEntity.setRoleUuid(roleUuid[i]);
			rAccountEntity.setAccountUuid(entity.getUuid());
			rAccountEntity.setCreatedBy("1234567890");
			rAccountEntity.setCreatedAt(new Date());
			roleAccountRepository.save(rAccountEntity);
		}
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
	 * 根据UUID查询帐号信息
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

	/**
	 * 根据账号Code查询账号entity
	 * 
	 * @param accountCode
	 * @return
	 * @throws Exception
	 */
	public AccountEntity getAccountByCode(String accountCode) throws Exception {
		AccountEntity entity = repository.findByAccountCode(accountCode);
		return entity;
	}

}
