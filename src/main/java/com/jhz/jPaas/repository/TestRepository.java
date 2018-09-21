package com.jhz.jPaas.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jhz.jPaas.entity.TestEntity;

/**
 * 测试用数据库操作类
 * 
 * @author jihuaizhi
 * @since 2018-09-12
 */
@Repository
public interface TestRepository extends JpaRepository<TestEntity, String> {

	TestEntity findByUserName(String userName) throws Exception;

	TestEntity findByUserNameOrUuid(String username, String uuid) throws Exception;

	TestEntity findByUserNameOrUuidLike(String username, String uuid) throws Exception;

	@Query(value = "select account_name from t_user u where u.user_name like '%小明的姓名1%'", nativeQuery = true)
	List<Map<String, Object>> findByUserNameLike(String userName) throws Exception;

	@Query(value = "select user_name,account_name,email from t_user where account_name like %?1%", nativeQuery = true)
	List<Map<String, Object>> getUserEmailByAccount(String userName) throws Exception;

}