package com.jhz.jPaas.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jhz.jPaas.entity.AccountEntity;

/**
 * 数据库操作类
 * 
 * @author jihuaizhi
 * @since 2018-09-16
 */
@Repository
public interface AccountRepository extends JpaRepository<AccountEntity, String> {

	// TODO 建议使用HQL写法编写SQL
	@Modifying
	@Query(value = "update auth_account set password = ?2 where uuid=?1", nativeQuery = true)
	void resetPwd(String uuid, String password);

	AccountEntity findByAccountCode(String accountCode);

}