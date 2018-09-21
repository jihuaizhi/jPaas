/*
Navicat MySQL Data Transfer

Source Server         : 本机3308 mysql5.7
Source Server Version : 50716
Source Host           : localhost:3308
Source Database       : radf

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2017-08-16 17:36:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for act_evt_log
-- ----------------------------
DROP TABLE IF EXISTS `act_evt_log`;
CREATE TABLE `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_evt_log
-- ----------------------------

-- ----------------------------
-- Table structure for act_ge_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_bytearray
-- ----------------------------

-- ----------------------------
-- Table structure for act_ge_property
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_property
-- ----------------------------
INSERT INTO `act_ge_property` VALUES ('next.dbid', '1', '1');
INSERT INTO `act_ge_property` VALUES ('schema.history', 'create(5.22.0.0)', '1');
INSERT INTO `act_ge_property` VALUES ('schema.version', '5.22.0.0', '1');

-- ----------------------------
-- Table structure for act_hi_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_actinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_attachment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_comment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_comment
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_detail
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_detail
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_identitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_procinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_procinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_taskinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_taskinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_varinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_varinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_group
-- ----------------------------
DROP TABLE IF EXISTS `act_id_group`;
CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_group
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_info
-- ----------------------------
DROP TABLE IF EXISTS `act_id_info`;
CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_info
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_membership
-- ----------------------------
DROP TABLE IF EXISTS `act_id_membership`;
CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_membership
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_user
-- ----------------------------
DROP TABLE IF EXISTS `act_id_user`;
CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_user
-- ----------------------------

-- ----------------------------
-- Table structure for act_procdef_info
-- ----------------------------
DROP TABLE IF EXISTS `act_procdef_info`;
CREATE TABLE `act_procdef_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_procdef_info
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_deployment
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_model
-- ----------------------------
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_model
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_procdef
-- ----------------------------
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_procdef
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_event_subscr
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_event_subscr
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_execution
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_identitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_job
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_task
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_task
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_variable
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_variable
-- ----------------------------

-- ----------------------------
-- Table structure for f00_menu
-- ----------------------------
DROP TABLE IF EXISTS `f00_menu`;
CREATE TABLE `f00_menu` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) NOT NULL,
  `parent_id` varchar(36) NOT NULL,
  `sort_num` int(11) NOT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `menu_link` varchar(255) NOT NULL,
  `menu_name` varchar(255) NOT NULL,
  `menu_icon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f00_menu
-- ----------------------------
INSERT INTO `f00_menu` VALUES ('00510173-4991-4310-9232-046b46fc2dbe', '2017-06-21 22:41:12', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '95abdb4f-82bc-4e27-ae94-e7ae012ae70d', '8', '2017-08-14 16:58:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_platform/security/org.jsp', '组织机构管理', 'fa fa-copyright');
INSERT INTO `f00_menu` VALUES ('01ade955-c8bb-48f7-b676-445a3334cc65', '2017-06-26 01:17:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '6ab6147c-d561-438f-a45d-93dd96183189', '25', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_error/defaultException.jsp', '系统默认错误页', '');
INSERT INTO `f00_menu` VALUES ('07273796-2d15-45be-8832-30675b484b56', '2017-06-26 01:11:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', 'e8be667b-1059-4f00-9af4-463f6fb73c38', '31', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_demo/template_form.jsp', '表单样例模板', '');
INSERT INTO `f00_menu` VALUES ('0754782e-0093-48fe-a416-36aba3b6ec57', '2017-06-26 01:16:01', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', 'e8be667b-1059-4f00-9af4-463f6fb73c38', '30', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_demo/template_list.jsp', '列表模版页', '');
INSERT INTO `f00_menu` VALUES ('13826d3b-f330-4797-a303-71451db79018', '2017-07-17 09:47:31', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '1', '2017-08-14 16:58:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_prod/defect/defect_list.jsp', 'BUG列表', '');
INSERT INTO `f00_menu` VALUES ('17c33fb6-6890-4614-8018-dfc264c16510', '2017-06-21 22:41:36', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '6ab6147c-d561-438f-a45d-93dd96183189', '22', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_platform/security/user_info.jsp', '用户扩展信息管理', '');
INSERT INTO `f00_menu` VALUES ('2e7a3188-768e-4da2-a050-2142d73824c3', '2017-06-26 01:20:58', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '385c97c1-533f-41d7-94fc-f1020a3869db', '12', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '测试页1', '');
INSERT INTO `f00_menu` VALUES ('385c97c1-533f-41d7-94fc-f1020a3869db', '2017-06-26 01:21:05', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '8c2671d3-56bb-406f-a910-eedf54de7916', '11', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '测试页2', '');
INSERT INTO `f00_menu` VALUES ('3a91d9f2-84cf-4a8d-8cab-8168e718c753', '2017-06-26 01:20:45', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '8c2671d3-56bb-406f-a910-eedf54de7916', '15', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '测试页5', '');
INSERT INTO `f00_menu` VALUES ('40110153-a1fd-4733-8931-7632f28dbb02', '2017-07-04 09:46:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '95abdb4f-82bc-4e27-ae94-e7ae012ae70d', '7', '2017-08-14 16:58:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_platform/security/permission.jsp', '权限管理', 'fa fa-outdent');
INSERT INTO `f00_menu` VALUES ('40f49a0d-7189-406a-82ef-17c11e07fb68', '2017-06-27 00:15:40', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '8c2671d3-56bb-406f-a910-eedf54de7916', '20', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '调试页9', '');
INSERT INTO `f00_menu` VALUES ('41a155ab-47d5-437f-8486-507dfc174b7f', '2017-06-21 21:58:32', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '4f1ef028-87ca-40ae-9c51-b204df3fea88', '3', '2017-08-14 16:58:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_platform/security/menu.jsp', '菜单管理', 'fa fa-bars');
INSERT INTO `f00_menu` VALUES ('4e406f8c-d4ce-4175-af82-612b315f00aa', '2017-06-21 22:40:40', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '95abdb4f-82bc-4e27-ae94-e7ae012ae70d', '5', '2017-08-14 16:58:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_platform/security/user.jsp', '用户管理', 'fa fa-user');
INSERT INTO `f00_menu` VALUES ('4f1ef028-87ca-40ae-9c51-b204df3fea88', '2017-06-26 00:49:04', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '2', '2017-08-14 16:58:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '系统管理', 'fa fa-cog');
INSERT INTO `f00_menu` VALUES ('50e9224f-a6f5-49fb-9875-f84d13c61200', '2017-06-27 00:10:05', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '8c2671d3-56bb-406f-a910-eedf54de7916', '18', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '调试页8', '');
INSERT INTO `f00_menu` VALUES ('58599365-4db3-44f4-8b58-61988ba955da', '2017-06-21 20:48:04', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '95abdb4f-82bc-4e27-ae94-e7ae012ae70d', '9', '2017-08-14 16:58:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_platform/common/dict.jsp', '字典维护', 'fa fa-book');
INSERT INTO `f00_menu` VALUES ('62059763-4a69-4ab4-bbbc-056a18872aee', '2017-06-26 01:20:29', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '8c2671d3-56bb-406f-a910-eedf54de7916', '14', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '测试页4', '');
INSERT INTO `f00_menu` VALUES ('663cfbc7-ba26-4966-b91a-6efe172f0420', '2017-06-22 01:07:11', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '95abdb4f-82bc-4e27-ae94-e7ae012ae70d', '6', '2017-08-14 16:58:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_platform/security/role_manage_list.jsp', '角色管理', 'fa fa-user-o');
INSERT INTO `f00_menu` VALUES ('6ab6147c-d561-438f-a45d-93dd96183189', '2017-06-26 01:16:34', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '21', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '其它', 'ion-help-buoy');
INSERT INTO `f00_menu` VALUES ('755b0c69-a799-4578-a0ed-0da684c4a684', '2017-06-26 10:02:45', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '8c2671d3-56bb-406f-a910-eedf54de7916', '13', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '测试页3', '');
INSERT INTO `f00_menu` VALUES ('7725bd1a-64c2-4ad0-b539-e8a89bd2b295', '2017-06-26 01:19:34', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '27', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', 'BUG管理系统', 'fa fa-header');
INSERT INTO `f00_menu` VALUES ('799d62dd-2241-46ae-b498-e73db674f96c', '2017-06-26 01:17:03', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '6ab6147c-d561-438f-a45d-93dd96183189', '23', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_error/404.html', '404错误页', '');
INSERT INTO `f00_menu` VALUES ('8c2671d3-56bb-406f-a910-eedf54de7916', '2017-06-26 01:20:11', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '10', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '菜单折叠调试', 'fa fa-chain-broken');
INSERT INTO `f00_menu` VALUES ('8d119ac6-fdc4-497d-a600-f8db3b46722d', '2017-06-26 01:20:36', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '8c2671d3-56bb-406f-a910-eedf54de7916', '16', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '测试页6', '');
INSERT INTO `f00_menu` VALUES ('95abdb4f-82bc-4e27-ae94-e7ae012ae70d', '2017-06-21 20:47:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '4', '2017-08-14 16:58:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '认证与授权', 'fa fa-id-card');
INSERT INTO `f00_menu` VALUES ('95fe2ee2-7f72-4d4b-85f6-5e6b9524e62c', '2017-06-26 01:17:21', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '6ab6147c-d561-438f-a45d-93dd96183189', '24', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_error/500.html', '500错误页', '');
INSERT INTO `f00_menu` VALUES ('d5f6f0f4-d502-4889-97e9-d5b174e2a778', '2017-06-27 00:14:46', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '8c2671d3-56bb-406f-a910-eedf54de7916', '19', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '调试页10', '');
INSERT INTO `f00_menu` VALUES ('d73a6229-dc14-478b-b599-5651429728a3', '2017-06-26 01:18:52', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '6ab6147c-d561-438f-a45d-93dd96183189', '26', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_error/AuthorizationException.jsp', '认证失败错误页', '');
INSERT INTO `f00_menu` VALUES ('e794c138-e21a-4883-bd9b-d584529c8f42', '2017-06-26 01:16:22', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', 'e8be667b-1059-4f00-9af4-463f6fb73c38', '29', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'views_demo/template_html.html', 'html模版页', '');
INSERT INTO `f00_menu` VALUES ('e8be667b-1059-4f00-9af4-463f6fb73c38', '2017-06-21 21:33:48', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '28', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '样例Demo', 'fa fa-delicious');
INSERT INTO `f00_menu` VALUES ('edb60f89-7bd9-4b6f-b3b7-6572e5139790', '2017-06-26 01:20:52', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '8c2671d3-56bb-406f-a910-eedf54de7916', '17', '2017-08-14 16:58:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '#', '测试页7', '');

-- ----------------------------
-- Table structure for f00_org
-- ----------------------------
DROP TABLE IF EXISTS `f00_org`;
CREATE TABLE `f00_org` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) NOT NULL,
  `parent_id` varchar(36) NOT NULL,
  `sort_num` int(11) NOT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `org_code` varchar(255) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `UK_20noxkkh3cvwpjwp9wcrtknpt` (`org_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f00_org
-- ----------------------------
INSERT INTO `f00_org` VALUES ('33ed5f5e-6c00-4028-83b2-c417f5676e81', '2017-06-26 01:23:35', 'jihuaizhi', '1', '39eb4393-2845-4016-b6cb-e5f2d459cc78', '0', '2017-06-26 01:23:35', 'jihuaizhi', 'H01', '人力资源部');
INSERT INTO `f00_org` VALUES ('39eb4393-2845-4016-b6cb-e5f2d459cc78', '2017-06-26 01:22:07', 'jihuaizhi', '1', '', '0', '2017-07-07 10:02:08', 'a25b3652-77be-4bfe-8f87-de22253312e5', '000', '北京华夏易联科技开发有限公司');
INSERT INTO `f00_org` VALUES ('3a526c75-83d0-4642-959c-2a0c1d47fb68', '2017-07-07 09:42:23', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '1', '2017-07-31 08:55:32', 'a25b3652-77be-4bfe-8f87-de22253312e5', '吃饭餐费电饭锅电饭锅大概发给发给发给大概', 'ddd');
INSERT INTO `f00_org` VALUES ('848d14e5-f7ec-4f34-ba72-61be6270cd1c', '2017-06-26 01:22:38', 'jihuaizhi', '1', '39eb4393-2845-4016-b6cb-e5f2d459cc78', '0', '2017-06-26 01:22:38', 'jihuaizhi', 'D02', '第二开发部');
INSERT INTO `f00_org` VALUES ('946dad48-c81e-4cf1-9f55-f92531412ed3', '2017-06-26 01:24:31', 'jihuaizhi', '1', '', '0', '2017-06-26 01:24:31', 'jihuaizhi', '002', '武汉分公司');
INSERT INTO `f00_org` VALUES ('bf3aa19e-2b9e-4b40-9ea5-c44efe972e31', '2017-07-07 09:42:32', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '946dad48-c81e-4cf1-9f55-f92531412ed3', '2', '2017-07-31 08:55:19', 'a25b3652-77be-4bfe-8f87-de22253312e5', '111', 'sss');
INSERT INTO `f00_org` VALUES ('f08726f8-3778-445d-b467-f39de33d642d', '2017-06-26 01:22:51', 'jihuaizhi', '1', '39eb4393-2845-4016-b6cb-e5f2d459cc78', '0', '2017-07-06 14:23:53', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'C03', '财务部');
INSERT INTO `f00_org` VALUES ('f8ad746b-14c8-4728-aafc-ede827dd22ae', '2017-06-26 01:22:25', 'jihuaizhi', '1', '39eb4393-2845-4016-b6cb-e5f2d459cc78', '0', '2017-06-26 01:22:25', 'jihuaizhi', 'D01', '第一开发部');

-- ----------------------------
-- Table structure for f00_permission
-- ----------------------------
DROP TABLE IF EXISTS `f00_permission`;
CREATE TABLE `f00_permission` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) NOT NULL,
  `parent_id` varchar(36) NOT NULL,
  `sort_num` int(11) NOT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `permission_name` varchar(255) DEFAULT NULL,
  `permission_type` varchar(255) DEFAULT NULL,
  `permission_code` varchar(255) DEFAULT NULL,
  `permission_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f00_permission
-- ----------------------------
INSERT INTO `f00_permission` VALUES ('044f3259-9761-4fcd-93f3-bb0ce7a4eda6', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID删除用户数据', '1', '/user/delete', null);
INSERT INTO `f00_permission` VALUES ('0789a589-e478-4504-af30-4590949c2acb', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID删除一个角色,级联删除相关授权数据', '1', '/role/delete', null);
INSERT INTO `f00_permission` VALUES ('1692148c-0a20-4129-8166-ba4a6c4e7917', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '新增或修改用户数据', '1', '/user/save', null);
INSERT INTO `f00_permission` VALUES ('19c2caad-42db-4a9b-8a2d-4de4c5ecf452', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID查询一条用户数据', '1', '/user/querybyid', null);
INSERT INTO `f00_permission` VALUES ('2cefa7ad-2092-42ef-8741-fd094b4950dd', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '测试用', '1', '/test/jump', null);
INSERT INTO `f00_permission` VALUES ('2d6581d0-afb2-446e-9062-5902584cd615', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID查询一条用户扩展数据', '1', '/userInfo/querybyid', null);
INSERT INTO `f00_permission` VALUES ('32283c02-d228-42fa-801a-73d92032d222', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '更新菜单所属上级以及菜单位置和顺序', '1', '/menu/savesort', null);
INSERT INTO `f00_permission` VALUES ('3dcd902a-512b-4c12-867c-70018e22c88a', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '测试用', '1', '/test/uploadfile', null);
INSERT INTO `f00_permission` VALUES ('3f8bee4f-8480-4aaa-ab02-8a250ed424c3', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID删除用户扩展数据', '1', '/userInfo/delete', null);
INSERT INTO `f00_permission` VALUES ('3fe0f0cd-e5d8-4eb8-a70d-d32a3d2dd914', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '刷新URL权限列表', '1', '/permission/scanallurl', null);
INSERT INTO `f00_permission` VALUES ('40d27837-9d01-4a46-9f39-3bd03235988b', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '查询所有组织机构数据', '1', '/org/getlist', null);
INSERT INTO `f00_permission` VALUES ('417fae1b-ddf8-4f59-98da-6152ae97d456', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID查询一条权限数据', '1', '/permission/querybyid', null);
INSERT INTO `f00_permission` VALUES ('59de382a-dbdf-4cf7-9f47-268939e7dbb9', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '查询所有用户扩展数据', '1', '/userInfo/querylist', null);
INSERT INTO `f00_permission` VALUES ('672bb210-3def-4f16-a869-df196f01b11a', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '修改组织机构数据', '1', '/org/update', null);
INSERT INTO `f00_permission` VALUES ('6831197d-3df3-4c46-abfd-cd778ff5f251', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID查询一条角色数据及先关授权数据', '1', '/role/querybyid', null);
INSERT INTO `f00_permission` VALUES ('6d94c6c1-27b8-4c01-b149-b7e4b93058f7', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '测试用', '1', '/test/getList', null);
INSERT INTO `f00_permission` VALUES ('7300155e-bdf1-4893-aefa-4a4f41b8c82c', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '登录认证', '1', '/authentication/login', null);
INSERT INTO `f00_permission` VALUES ('74d67d40-63c4-4d3f-a981-7a9a818bc9a8', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '修改权限数据', '1', '/permission/update', null);
INSERT INTO `f00_permission` VALUES ('77d3f067-3476-4ff1-82af-c7b2b14b511f', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:38', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据字典代码查询所属字典数据项的数据', '1', '/dict/getdictdatalist', null);
INSERT INTO `f00_permission` VALUES ('77f530b9-f421-44c9-8e7c-c30e65539baa', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '查询所有菜单数据', '1', '/menu/querylist', null);
INSERT INTO `f00_permission` VALUES ('7f45e455-549e-47c1-b72d-caf875461f03', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID删除一条权限数据', '1', '/permission/delete', null);
INSERT INTO `f00_permission` VALUES ('808ff094-f95b-4c02-9d41-d979e583b289', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '查询所有状态为[显示]的菜单数据', '1', '/menu/querylistvisible', null);
INSERT INTO `f00_permission` VALUES ('8368d7b0-1c5f-4e32-a3ea-a1d1b1812891', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '新增组织机构', '1', '/org/save', null);
INSERT INTO `f00_permission` VALUES ('865532f5-79f4-469c-bf94-3bd8fa5a884c', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '查询所有用户数据', '1', '/user/querylist', null);
INSERT INTO `f00_permission` VALUES ('869e50bd-b8ac-47dd-9dd2-a4edeac61a5c', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID查询下一级组织机构数据', '1', '/org/getNextById', null);
INSERT INTO `f00_permission` VALUES ('a90e2b39-20eb-4156-ac51-fc5bc2ab0c8b', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '修改密码', '1', '/user/savePwd', null);
INSERT INTO `f00_permission` VALUES ('ad793c87-5cae-4c94-9734-98e101085502', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '测试用', '1', '/test/getModel', null);
INSERT INTO `f00_permission` VALUES ('b1bfc016-f848-4a85-bc30-a0d6c36c85b3', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '查询所有数据字典数据', '1', '/dict/getlist', null);
INSERT INTO `f00_permission` VALUES ('b3a68106-7d99-4a90-843c-5cb85bcae7ab', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '新增字典数据', '1', '/dict/data/new', null);
INSERT INTO `f00_permission` VALUES ('b7aa678d-e092-4aa9-9436-b234eadf3dd9', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '查询当前登录者信息及相关公共信息', '1', '/authentication/getloginuser', null);
INSERT INTO `f00_permission` VALUES ('bfc96c13-22ed-40cc-9966-ac1355fd8df6', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据角色ID查询该角色下所有用户数据', '1', '/role/getuser', null);
INSERT INTO `f00_permission` VALUES ('c1db3a77-416f-4e76-904d-4b6c5c6eb909', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID查询一条组织机构数据', '1', '/org/getOrgById', null);
INSERT INTO `f00_permission` VALUES ('c3f158f7-a2b7-4e73-ade0-dc6c0090c1f1', '2017-07-31 13:36:12', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-08-14 17:24:38', 'a25b3652-77be-4bfe-8f87-de22253312e5', '新增或修改缺陷信息', '1', '/defect/save', null);
INSERT INTO `f00_permission` VALUES ('c472fd19-9b94-4705-a882-e2e2fd8a4799', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID查询一条菜单数据', '1', '/menu/querybyid', null);
INSERT INTO `f00_permission` VALUES ('c86ca4df-c536-4a7d-a7c9-9617ff6ca26e', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '测试用', '1', '/test/getEntity', null);
INSERT INTO `f00_permission` VALUES ('cb1ae0bd-e05a-4241-a941-2b34605e1a50', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '新增或修改角色数据以及相关授权数据', '1', '/role/save', null);
INSERT INTO `f00_permission` VALUES ('d14601fd-b3ff-4c9f-bb61-ec53771e77a1', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID查询一条字典数据', '1', '/dict/getdictbyid', null);
INSERT INTO `f00_permission` VALUES ('d523f666-bb33-47ed-aa9d-63eb20d9ea42', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '查询系统所有有效的URL数据', '1', '/role/getPermissionListVisible', null);
INSERT INTO `f00_permission` VALUES ('d5562c1d-8068-4b14-b44e-23e80374cbea', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID删除一条字典数据项的数据', '1', '/dict/deletedictdatabyid', null);
INSERT INTO `f00_permission` VALUES ('dbb8407a-e910-474d-a9e5-2f634ec922c5', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '注销系统', '1', '/authentication/logout', null);
INSERT INTO `f00_permission` VALUES ('dcf20443-3d5b-484c-83ab-f70942a87c26', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '新增或修改菜单信息', '1', '/menu/save', null);
INSERT INTO `f00_permission` VALUES ('e194f341-5b5f-434a-8cee-21709ec60cee', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '删除一个菜单及下级子菜单', '1', '/menu/delete', null);
INSERT INTO `f00_permission` VALUES ('e1c2998e-a92f-4d05-8769-d6d1b374c32d', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '查询全部权限列表', '1', '/permission/querylist', null);
INSERT INTO `f00_permission` VALUES ('e1d1bb26-96ec-46c4-934f-7b0d3f5f6dee', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '查询所有角色数据', '1', '/role/querylist', null);
INSERT INTO `f00_permission` VALUES ('e7bb6271-336e-4ce9-99c2-791b30860691', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID删除组织机构数据', '1', '/org/delete', null);
INSERT INTO `f00_permission` VALUES ('eb097dd0-a697-4d02-b8ca-c374dda5de8b', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '新增或修改数据字典', '1', '/dict/save', null);
INSERT INTO `f00_permission` VALUES ('eb80b016-03a6-4425-b02f-f26c0a16c8f3', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID删除一条数据字典及其所属数据项的数据', '1', '/dict/deletebyid', null);
INSERT INTO `f00_permission` VALUES ('eef99e8b-903b-4a5b-b5b5-88da9f5b375d', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据ID查询一条字典数据项的数据', '1', '/dict/getdictdatabyid', null);
INSERT INTO `f00_permission` VALUES ('fa6f44a7-cc5a-40cb-a0b2-1938b9d6d211', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '测试用', '1', '/test/throwsError', null);
INSERT INTO `f00_permission` VALUES ('fb0a1261-6642-417f-b9cf-9e60de74f994', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据菜单ID查询所有下一级菜单', '1', '/menu/querylistbyid', null);
INSERT INTO `f00_permission` VALUES ('fe8bc6f7-f26a-4799-a8d1-c45392909db5', '2017-07-14 10:52:09', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '根据当前登录用户ID查询所有状态为[显示]的菜单数据', '1', '/menu/queryListByUser', null);
INSERT INTO `f00_permission` VALUES ('ff9db529-877d-425d-b42b-8b446621bbf5', '2017-07-14 10:52:10', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-08-14 17:24:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '新增或修改用户扩展数据', '1', '/userInfo/save', null);

-- ----------------------------
-- Table structure for f00_role
-- ----------------------------
DROP TABLE IF EXISTS `f00_role`;
CREATE TABLE `f00_role` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) NOT NULL,
  `parent_id` varchar(36) NOT NULL,
  `sort_num` int(11) NOT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `role_code` varchar(255) DEFAULT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `role_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `UK_qoo4ovrffhmun84vn5d4yoqdb` (`role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f00_role
-- ----------------------------
INSERT INTO `f00_role` VALUES ('07557f06-0bf5-4b31-876a-b72242c7fea2', '2017-07-05 09:25:39', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '2', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'system', '系统管理员', '仅拥有系统管理的功能权限,没有业务操作权限');
INSERT INTO `f00_role` VALUES ('168ea4a8-0ef2-482d-aea2-24986aab76bc', '2017-06-26 23:15:17', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'user', '普通用户', '拥有一般业务操作权限');
INSERT INTO `f00_role` VALUES ('e9d7b063-f83f-465c-b4b3-23badc882d6c', '2017-06-22 21:33:45', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '1', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'admin', '超级管理员', '超级管理权限,拥有系统所有权限');
INSERT INTO `f00_role` VALUES ('f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca', '2017-06-22 21:33:56', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '4', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'guest', '来宾角色', '来访帐号,只能只读访问部分业务数据');

-- ----------------------------
-- Table structure for f00_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `f00_role_menu`;
CREATE TABLE `f00_role_menu` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) NOT NULL,
  `parent_id` varchar(36) NOT NULL,
  `sort_num` int(11) NOT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `menu_record_id` varchar(255) DEFAULT NULL,
  `role_record_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f00_role_menu
-- ----------------------------
INSERT INTO `f00_role_menu` VALUES ('01db20dc-b153-42ff-9215-d951e5153840', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '00510173-4991-4310-9232-046b46fc2dbe', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('02146780-8503-4514-a514-5b76d3e9995b', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'd73a6229-dc14-478b-b599-5651429728a3', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('08327a72-397c-4479-9a42-4da21522ca96', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '0754782e-0093-48fe-a416-36aba3b6ec57', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('0c22875d-512b-4da9-9fa7-99044d7af994', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '7725bd1a-64c2-4ad0-b539-e8a89bd2b295', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('0d587754-1b1e-4328-8f5a-274bf53631a5', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '40110153-a1fd-4733-8931-7632f28dbb02', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('0edf4477-c4b9-4d78-93e2-81ea66851ec8', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '01ade955-c8bb-48f7-b676-445a3334cc65', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('15a3e4cb-bec8-4cbb-bcd4-2a36a0f3f41d', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '4f1ef028-87ca-40ae-9c51-b204df3fea88', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('16cd7c35-6c5e-4b09-b7d9-d11c7bc4e708', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '62059763-4a69-4ab4-bbbc-056a18872aee', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('1c2c8775-d59b-4bc9-86aa-7eac1e11babe', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'e794c138-e21a-4883-bd9b-d584529c8f42', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('1d48c022-2898-48b6-a158-d90b36d570b9', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '13826d3b-f330-4797-a303-71451db79018', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('20c6ae13-3703-4eef-b1a8-28ca31779091', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '755b0c69-a799-4578-a0ed-0da684c4a684', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('220e0d71-2c89-427a-a81e-e8b273a06fe7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'e8be667b-1059-4f00-9af4-463f6fb73c38', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('229bcc03-b889-466e-9b85-60f897a86545', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'edb60f89-7bd9-4b6f-b3b7-6572e5139790', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('23ae24db-7ff3-4122-bffc-ff9415f8c215', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '755b0c69-a799-4578-a0ed-0da684c4a684', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('246202ba-29cf-4a72-8982-2053d5558a85', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '17c33fb6-6890-4614-8018-dfc264c16510', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('2c857ace-1a29-475d-8d7b-9eac21239317', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '4e406f8c-d4ce-4175-af82-612b315f00aa', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('30f71410-4c2d-4758-940d-c327f48adbf0', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '2e7a3188-768e-4da2-a050-2142d73824c3', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('311876c3-3efb-4d40-8c38-f74505653c99', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '2e7a3188-768e-4da2-a050-2142d73824c3', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('3274269f-b047-449c-a7c7-f56b32c4f618', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '01ade955-c8bb-48f7-b676-445a3334cc65', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('3599c881-0995-4b05-8df0-63ef4e85e5fb', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '40f49a0d-7189-406a-82ef-17c11e07fb68', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('378db0f7-fa66-434d-a21a-db88d9395c45', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '4f1ef028-87ca-40ae-9c51-b204df3fea88', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('3d79fb30-9867-4cb9-964d-68af36e42887', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '8d119ac6-fdc4-497d-a600-f8db3b46722d', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('43c9a78a-8f88-4708-b550-85526f03c751', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '50e9224f-a6f5-49fb-9875-f84d13c61200', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('443cb0ec-f4df-4ea9-9db5-722e3ceb850b', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '3a91d9f2-84cf-4a8d-8cab-8168e718c753', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('4595a1a3-b777-4448-a75b-324448e706ee', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '385c97c1-533f-41d7-94fc-f1020a3869db', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('468336c2-a460-4705-988f-b8a2701d3d6a', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '50e9224f-a6f5-49fb-9875-f84d13c61200', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('47dc9432-d2eb-45f3-aad6-f16952f00ddf', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '3a91d9f2-84cf-4a8d-8cab-8168e718c753', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('493f3773-fc02-43ab-93b7-761ed1c3ed95', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '663cfbc7-ba26-4966-b91a-6efe172f0420', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('49cf312d-23b5-4d3e-a586-1eed3deda2c8', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '3a91d9f2-84cf-4a8d-8cab-8168e718c753', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('4e01946f-2263-47a4-958e-5d57c89ab9fd', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '6ab6147c-d561-438f-a45d-93dd96183189', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('50d45d78-1398-43d1-bcdb-0624bceda817', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'edb60f89-7bd9-4b6f-b3b7-6572e5139790', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('52f4f001-7053-4a80-a554-339ddf52db4c', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '8c2671d3-56bb-406f-a910-eedf54de7916', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('5541f591-cbe9-4af7-82ee-dba7e2def82b', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '00510173-4991-4310-9232-046b46fc2dbe', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('570526f2-1a11-41d1-aa50-37408cf12f81', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '7725bd1a-64c2-4ad0-b539-e8a89bd2b295', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('5cd22b56-88c3-4c24-9f03-aed4225d064e', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '41a155ab-47d5-437f-8486-507dfc174b7f', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('68d1785a-4414-44dd-bd9c-bd7a6056dc95', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '6ab6147c-d561-438f-a45d-93dd96183189', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('696e5325-a1d2-4388-8bcb-6ae7e3b85ddc', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'e8be667b-1059-4f00-9af4-463f6fb73c38', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('6c6de1b6-c155-424b-be26-e01801a336be', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '8c2671d3-56bb-406f-a910-eedf54de7916', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('6eb9368b-15f2-4071-8eeb-0697be775406', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '8d119ac6-fdc4-497d-a600-f8db3b46722d', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('719e34de-929a-4ebe-b6e1-cf7e67d87b1b', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '385c97c1-533f-41d7-94fc-f1020a3869db', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('72b089a9-70fd-465a-8eeb-57b39c45b0f2', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '799d62dd-2241-46ae-b498-e73db674f96c', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('72d4a3a6-ab1a-49e4-9c54-956e6c421f3a', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '07273796-2d15-45be-8832-30675b484b56', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('72e09d35-b3a8-4c1e-9719-de6808365bff', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'd5f6f0f4-d502-4889-97e9-d5b174e2a778', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('7850e7c8-1934-4cd0-a2d4-544872773b50', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '95abdb4f-82bc-4e27-ae94-e7ae012ae70d', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('7ca8bcd8-0d17-42e6-8cc0-0853a43023f0', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '0754782e-0093-48fe-a416-36aba3b6ec57', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('81141d46-1d51-47ee-890b-feb41906308e', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'd5f6f0f4-d502-4889-97e9-d5b174e2a778', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('83271ae5-d38f-44b1-b164-8fecbbc83e1e', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '4e406f8c-d4ce-4175-af82-612b315f00aa', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('85485fed-334a-4718-8709-a727afbd3fe7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'edb60f89-7bd9-4b6f-b3b7-6572e5139790', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('864bf9dd-c6ae-4d23-9675-01665c957aff', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '95fe2ee2-7f72-4d4b-85f6-5e6b9524e62c', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('87e640df-58ad-4816-9feb-256883faeb24', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '07273796-2d15-45be-8832-30675b484b56', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('88e7c4f9-e01f-4c91-95c3-28de059787a8', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '8c2671d3-56bb-406f-a910-eedf54de7916', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('8d30e1cd-f9e0-40f8-9c71-1c805183ff87', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '50e9224f-a6f5-49fb-9875-f84d13c61200', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('8dbd3f60-8f2b-41eb-8cbe-aa920c5686d6', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '62059763-4a69-4ab4-bbbc-056a18872aee', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('9520a5d4-26e4-44c9-b13d-4d204ade770b', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '40f49a0d-7189-406a-82ef-17c11e07fb68', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('a63dc1b8-7d55-4fc4-94c4-6f61a639a241', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '07273796-2d15-45be-8832-30675b484b56', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('aaf5bb50-8081-41e1-96d9-6b3a34e3aec9', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'e794c138-e21a-4883-bd9b-d584529c8f42', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('b41b612d-d9ad-4023-96d8-942df76b7c47', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'e8be667b-1059-4f00-9af4-463f6fb73c38', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('b4a38c91-6fcf-4245-9e2e-c9a844847b92', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '385c97c1-533f-41d7-94fc-f1020a3869db', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('b8e7c810-b043-4142-85be-563c6aa02163', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'd5f6f0f4-d502-4889-97e9-d5b174e2a778', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('b97d46e7-05c5-407a-8538-8be3af9b9b02', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '799d62dd-2241-46ae-b498-e73db674f96c', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('bb260be7-8241-44cc-9148-14f55d9dd4cb', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '41a155ab-47d5-437f-8486-507dfc174b7f', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('c329e7cf-e91f-4184-aa23-8848e8061a22', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '58599365-4db3-44f4-8b58-61988ba955da', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('c51321e9-23e1-4932-a39c-f26ef291f7d8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'e794c138-e21a-4883-bd9b-d584529c8f42', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('cbb54aef-a366-4347-a484-1fc27be40711', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '755b0c69-a799-4578-a0ed-0da684c4a684', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('ccc9e160-1b52-42b6-86fd-359f59c7f3dc', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '8d119ac6-fdc4-497d-a600-f8db3b46722d', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('ce54f17f-2127-4a9a-a487-929ec5bcadad', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '40110153-a1fd-4733-8931-7632f28dbb02', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('cf874c6d-4c22-48dc-a602-27bf87807307', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '2e7a3188-768e-4da2-a050-2142d73824c3', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('d1a31a43-310a-4494-8ca4-f3692ba3f231', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '95abdb4f-82bc-4e27-ae94-e7ae012ae70d', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('d1dcbe72-db4d-4c22-9047-c0bd56515187', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-06 10:45:43', 'a25b3652-77be-4bfe-8f87-de22253312e5', '58599365-4db3-44f4-8b58-61988ba955da', '07557f06-0bf5-4b31-876a-b72242c7fea2');
INSERT INTO `f00_role_menu` VALUES ('d4c37e0f-9f2b-4e37-8634-bc26cd8e0884', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '663cfbc7-ba26-4966-b91a-6efe172f0420', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('d77fa1e9-bed8-4aad-a3b2-e255e3439054', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-06 10:45:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '7725bd1a-64c2-4ad0-b539-e8a89bd2b295', '168ea4a8-0ef2-482d-aea2-24986aab76bc');
INSERT INTO `f00_role_menu` VALUES ('d8b4e1f7-9462-48fd-9346-578104ffdcdd', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '95fe2ee2-7f72-4d4b-85f6-5e6b9524e62c', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('dc690d94-607c-4e17-882e-dbf4b6b7904a', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'd73a6229-dc14-478b-b599-5651429728a3', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('e0dbfaa2-94d5-484e-8956-1f580c3d0b71', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '0754782e-0093-48fe-a416-36aba3b6ec57', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('e4b1af57-23ab-46dc-ba95-fb422e1c3572', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '17c33fb6-6890-4614-8018-dfc264c16510', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_menu` VALUES ('f370cd64-c15f-40cb-9930-8ba92b4ed1c5', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-06 10:45:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '62059763-4a69-4ab4-bbbc-056a18872aee', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca');
INSERT INTO `f00_role_menu` VALUES ('f8a6ea59-0421-449b-947a-256e84caee14', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '40f49a0d-7189-406a-82ef-17c11e07fb68', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');

-- ----------------------------
-- Table structure for f00_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `f00_role_permission`;
CREATE TABLE `f00_role_permission` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `sort_num` int(11) DEFAULT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `permission_record_id` varchar(255) DEFAULT NULL,
  `role_record_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f00_role_permission
-- ----------------------------
INSERT INTO `f00_role_permission` VALUES ('03ade1e6-2145-4da3-9f79-b22f5c4ab823', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '2cefa7ad-2092-42ef-8741-fd094b4950dd', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('06a58154-8f36-47f6-b65d-1808c5981d91', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'c472fd19-9b94-4705-a882-e2e2fd8a4799', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('0ecf97dc-0032-40b2-a5fd-3de42232fbdf', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '0789a589-e478-4504-af30-4590949c2acb', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('13adefbe-5ab9-481e-ad89-ec0c079e8fb7', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '32283c02-d228-42fa-801a-73d92032d222', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('1463abfb-db30-4ced-b880-710ed210803a', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'b1bfc016-f848-4a85-bc30-a0d6c36c85b3', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('1a1e1e2a-8493-4098-849f-8734d2d3ce49', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '59de382a-dbdf-4cf7-9f47-268939e7dbb9', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('1ba8ca0f-0155-47b5-88e5-3b9ea4e54d4c', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '6d94c6c1-27b8-4c01-b149-b7e4b93058f7', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('1cecc0ef-d66f-43d7-86d3-4abb7fad6bf1', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '7f45e455-549e-47c1-b72d-caf875461f03', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('1d552595-bb40-4b8e-a80b-a41e13421c24', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '3f8bee4f-8480-4aaa-ab02-8a250ed424c3', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('1f5cc60f-abea-4a80-a290-54553b53b6b3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'fb0a1261-6642-417f-b9cf-9e60de74f994', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('20c1021b-bcbb-457e-a637-d06b1a4ce321', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'a90e2b39-20eb-4156-ac51-fc5bc2ab0c8b', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('259ca2cc-9879-42f8-b0f1-ddabeb66daf3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'dcf20443-3d5b-484c-83ab-f70942a87c26', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('2ee777f2-e563-4e57-af6c-bdf1d136e483', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '044f3259-9761-4fcd-93f3-bb0ce7a4eda6', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('33fcd74a-631b-45e2-9647-3df8fe5f56d3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'dbb8407a-e910-474d-a9e5-2f634ec922c5', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('360b6ac8-0ae2-4094-a51d-66894691b34e', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'cb1ae0bd-e05a-4241-a941-2b34605e1a50', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('3c42631b-6c64-46f8-ba92-458de33866b4', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'e7bb6271-336e-4ce9-99c2-791b30860691', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('4545f8f1-c564-405f-999d-9f317ab711b0', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '8368d7b0-1c5f-4e32-a3ea-a1d1b1812891', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('461b4226-caee-4d3c-88ed-8fa3d9a6f0e2', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '6831197d-3df3-4c46-abfd-cd778ff5f251', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('475bf4f5-35fc-4110-95bb-ae89721005b7', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '672bb210-3def-4f16-a869-df196f01b11a', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('4dac8a0a-6c61-439f-9d8a-e67242b64f1d', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'd523f666-bb33-47ed-aa9d-63eb20d9ea42', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('4f656f59-a71c-40dd-8fa8-17b98a47b54f', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'ad793c87-5cae-4c94-9734-98e101085502', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('4f965171-90ec-4344-9cb4-76f1f14154c8', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'bfc96c13-22ed-40cc-9966-ac1355fd8df6', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('69b9b6ec-269c-4883-a1c9-a4419c803af1', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'e194f341-5b5f-434a-8cee-21709ec60cee', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('6bbd125a-db42-4126-86ae-aadbb0cdfd54', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'ff9db529-877d-425d-b42b-8b446621bbf5', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('6d97e154-2602-4e21-85b2-84636fe7937c', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '865532f5-79f4-469c-bf94-3bd8fa5a884c', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('6f801eb0-85e2-43c3-8a6f-0dcdbeede011', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '74d67d40-63c4-4d3f-a981-7a9a818bc9a8', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('72bfb8f2-0c95-4d25-b0b5-8be8a73bb9d2', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'c86ca4df-c536-4a7d-a7c9-9617ff6ca26e', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('76755c25-3f90-449c-aec5-5bb63ff1a36e', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'fe8bc6f7-f26a-4799-a8d1-c45392909db5', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('7afc4c09-847d-4e34-9892-bf23002b33ae', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'eef99e8b-903b-4a5b-b5b5-88da9f5b375d', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('7f492308-0e4e-46ac-9567-1e1040836c4f', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'c1db3a77-416f-4e76-904d-4b6c5c6eb909', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('80303bce-2e82-4e2e-8c72-a9e4fd9df23e', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '808ff094-f95b-4c02-9d41-d979e583b289', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('869e4187-febe-4171-bf49-b916eed5920b', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'd5562c1d-8068-4b14-b44e-23e80374cbea', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('87917a4f-18d6-4bb6-954d-e49b9343bb62', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '3fe0f0cd-e5d8-4eb8-a70d-d32a3d2dd914', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('890db1c3-7164-4dea-9310-3f6438b8d3b0', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'e1c2998e-a92f-4d05-8769-d6d1b374c32d', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('9b375ef4-4038-429b-9739-4565ff05739c', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'eb80b016-03a6-4425-b02f-f26c0a16c8f3', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('9c29a6db-6603-4e52-a604-bdca28e0cc6a', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'b7aa678d-e092-4aa9-9436-b234eadf3dd9', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('9d0e8f6d-b814-40a8-b976-afb3a95ac38a', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '869e50bd-b8ac-47dd-9dd2-a4edeac61a5c', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('a6384138-444c-4c2b-9c8b-227e4e2f48c3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'e1d1bb26-96ec-46c4-934f-7b0d3f5f6dee', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('af5ad2cb-8480-4eee-8799-b36670ccf794', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '19c2caad-42db-4a9b-8a2d-4de4c5ecf452', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('b840e715-4fe4-4047-87d9-0b9ce38720fb', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'eb097dd0-a697-4d02-b8ca-c374dda5de8b', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('b86dac6d-1618-4011-b8f3-4888645b5cde', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '417fae1b-ddf8-4f59-98da-6152ae97d456', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('c48b197b-6466-43eb-a2f8-53d6aae05f9b', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '3dcd902a-512b-4c12-867c-70018e22c88a', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('c7a3f370-94de-4443-92d4-fbad358ce3c2', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '7300155e-bdf1-4893-aefa-4a4f41b8c82c', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('cffbc2fc-144f-44b3-94d2-9ec4b38530b3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'fa6f44a7-cc5a-40cb-a0b2-1938b9d6d211', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('d1935582-2ebe-4a03-87f5-8ea4ed8f62ca', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1692148c-0a20-4129-8166-ba4a6c4e7917', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('f29845c6-3650-4d8f-ae50-88762e66de7c', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'd14601fd-b3ff-4c9f-bb61-ec53771e77a1', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('fb64b984-179a-49c2-b0a6-00310f8af8ac', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '2d6581d0-afb2-446e-9062-5902584cd615', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('fb848724-8041-4636-b724-fc2ceef30472', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '40d27837-9d01-4a46-9f39-3bd03235988b', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('fdc3f01c-6d26-4847-bf1b-89b746370524', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '77d3f067-3476-4ff1-82af-c7b2b14b511f', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');
INSERT INTO `f00_role_permission` VALUES ('febb1474-9c67-45a6-9038-85023b7d2808', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-17 09:50:50', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'b3a68106-7d99-4a90-843c-5cb85bcae7ab', 'e9d7b063-f83f-465c-b4b3-23badc882d6c');

-- ----------------------------
-- Table structure for f00_user
-- ----------------------------
DROP TABLE IF EXISTS `f00_user`;
CREATE TABLE `f00_user` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) NOT NULL,
  `parent_id` varchar(36) NOT NULL,
  `sort_num` int(11) NOT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `UK_s02gloumdqul5j2nnrpvmdd29` (`account_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f00_user
-- ----------------------------
INSERT INTO `f00_user` VALUES ('21037852-873e-4940-a4ac-623a23a809b9', '2017-07-05 09:27:49', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '1', '2017-07-05 09:27:49', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'zhougen', '周根', '96e79218965eb72c92a549dd5a330112');
INSERT INTO `f00_user` VALUES ('41abebfe-85ba-4efc-b839-bc6098014f20', '2017-07-05 09:29:20', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '4', '2017-07-05 09:29:20', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'linghaitian', '凌海天', '96e79218965eb72c92a549dd5a330112');
INSERT INTO `f00_user` VALUES ('a25b3652-77be-4bfe-8f87-de22253312e5', '2017-06-22 20:54:44', 'jihuaizhi', '1', '', '0', '2017-07-05 09:23:30', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'admin', '超级管理员', '96e79218965eb72c92a549dd5a330112');
INSERT INTO `f00_user` VALUES ('b65f2c5a-e4a8-451c-abac-64dac6bb767f', '2017-07-05 09:28:17', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '2', '2017-07-05 09:28:17', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'haiyang', '海洋', '96e79218965eb72c92a549dd5a330112');
INSERT INTO `f00_user` VALUES ('c0479a93-3e23-428b-8556-ec5bc8ecf638', '2017-06-29 00:39:13', 'jihuaizhi', '1', '', '0', '2017-07-06 11:38:23', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'guest', '来宾帐号', '96e79218965eb72c92a549dd5a330112');
INSERT INTO `f00_user` VALUES ('ca7519f4-8710-4cc8-a5ec-4a29c572e03b', '2017-07-05 09:31:24', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-05 09:31:24', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'liubo', '刘博', '96e79218965eb72c92a549dd5a330112');
INSERT INTO `f00_user` VALUES ('dcd8e5d9-f533-4b82-974d-43d0477f61d0', '2017-06-22 20:54:52', 'jihuaizhi', '1', '', '0', '2017-07-05 09:24:08', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'jihuaizhi', '基怀志', '96e79218965eb72c92a549dd5a330112');
INSERT INTO `f00_user` VALUES ('e334b51c-09aa-44b2-b1c2-0fbe1f0c1a19', '2017-07-05 09:31:05', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-05 09:31:05', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'sundaoming', '孙道铭', '96e79218965eb72c92a549dd5a330112');
INSERT INTO `f00_user` VALUES ('ee919387-806e-40b4-b2a3-e4b4d4995240', '2017-07-05 09:28:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-05 09:28:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'danghaifeng', '党海峰', '96e79218965eb72c92a549dd5a330112');
INSERT INTO `f00_user` VALUES ('ff2f5e46-b5ba-4f5b-81ea-b79ce8da87eb', '2017-07-05 09:30:44', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-07-05 09:30:44', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'liumingxin', '刘明鑫', '96e79218965eb72c92a549dd5a330112');

-- ----------------------------
-- Table structure for f00_user_info
-- ----------------------------
DROP TABLE IF EXISTS `f00_user_info`;
CREATE TABLE `f00_user_info` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) NOT NULL,
  `parent_id` varchar(36) NOT NULL,
  `sort_num` int(11) NOT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `birthday` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f00_user_info
-- ----------------------------
INSERT INTO `f00_user_info` VALUES ('95943fdd-7dd3-4da5-a169-551ac73b738c', '2017-07-01 14:21:16', 'dcd8e5d9-f533-4b82-974d-43d0477f61d0', '1', '', '1', '2017-07-01 14:21:55', 'dcd8e5d9-f533-4b82-974d-43d0477f61d0', '2018-09-09', '电动', '', '电动');
INSERT INTO `f00_user_info` VALUES ('9ae5603a-bbaa-4225-8909-8d97fcf10fd9', '2017-07-01 14:22:19', 'dcd8e5d9-f533-4b82-974d-43d0477f61d0', '1', '', '2', '2017-07-01 14:22:29', 'dcd8e5d9-f533-4b82-974d-43d0477f61d0', '2019-08-07', '斯蒂芬111', '2', '多少岁111');

-- ----------------------------
-- Table structure for f00_user_org
-- ----------------------------
DROP TABLE IF EXISTS `f00_user_org`;
CREATE TABLE `f00_user_org` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) NOT NULL,
  `parent_id` varchar(36) NOT NULL,
  `sort_num` int(11) NOT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `org_record_id` varchar(255) DEFAULT NULL,
  `org_type` varchar(255) DEFAULT NULL,
  `user_record_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f00_user_org
-- ----------------------------
INSERT INTO `f00_user_org` VALUES ('072092db-4d85-48b7-94e5-fc7e76df7769', '2017-07-05 09:31:05', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '9', '2017-07-05 09:31:05', 'a25b3652-77be-4bfe-8f87-de22253312e5', '848d14e5-f7ec-4f34-ba72-61be6270cd1c', '1', 'e334b51c-09aa-44b2-b1c2-0fbe1f0c1a19');
INSERT INTO `f00_user_org` VALUES ('2bef968b-422e-4bf2-a3c6-f68125f7979b', '2017-07-05 09:28:17', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-07-05 09:28:17', 'a25b3652-77be-4bfe-8f87-de22253312e5', '848d14e5-f7ec-4f34-ba72-61be6270cd1c', '1', 'b65f2c5a-e4a8-451c-abac-64dac6bb767f');
INSERT INTO `f00_user_org` VALUES ('4d666eca-8d78-47b1-9717-0ec86057a0f2', '2017-07-05 09:27:49', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '4', '2017-07-05 09:27:49', 'a25b3652-77be-4bfe-8f87-de22253312e5', '39eb4393-2845-4016-b6cb-e5f2d459cc78', '1', '21037852-873e-4940-a4ac-623a23a809b9');
INSERT INTO `f00_user_org` VALUES ('59beb8c9-d3b1-429a-9fb1-446802c91645', '2017-07-05 09:24:08', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '3', '2017-07-05 09:24:08', 'a25b3652-77be-4bfe-8f87-de22253312e5', '848d14e5-f7ec-4f34-ba72-61be6270cd1c', '1', 'dcd8e5d9-f533-4b82-974d-43d0477f61d0');
INSERT INTO `f00_user_org` VALUES ('69928ef9-6767-427a-9306-543afd864b13', '2017-07-06 11:38:23', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '11', '2017-07-06 11:38:23', 'a25b3652-77be-4bfe-8f87-de22253312e5', '', '1', 'c0479a93-3e23-428b-8556-ec5bc8ecf638');
INSERT INTO `f00_user_org` VALUES ('6b2afd33-46de-40af-9fb9-af1a3f0f1893', '2017-07-05 09:31:24', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '10', '2017-07-05 09:31:24', 'a25b3652-77be-4bfe-8f87-de22253312e5', '848d14e5-f7ec-4f34-ba72-61be6270cd1c', '1', 'ca7519f4-8710-4cc8-a5ec-4a29c572e03b');
INSERT INTO `f00_user_org` VALUES ('9566d392-aa52-42f9-8f6a-ecbcf23db2c4', '2017-07-05 09:30:44', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-05 09:30:44', 'a25b3652-77be-4bfe-8f87-de22253312e5', '848d14e5-f7ec-4f34-ba72-61be6270cd1c', '1', 'ff2f5e46-b5ba-4f5b-81ea-b79ce8da87eb');
INSERT INTO `f00_user_org` VALUES ('98d7d0bb-34fb-4ba9-a4fe-2e55c81dd1d5', '2017-07-05 09:29:20', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-05 09:29:20', 'a25b3652-77be-4bfe-8f87-de22253312e5', '848d14e5-f7ec-4f34-ba72-61be6270cd1c', '1', '41abebfe-85ba-4efc-b839-bc6098014f20');
INSERT INTO `f00_user_org` VALUES ('9c68d549-982a-4057-a4e3-d21cdd334d65', '2017-07-05 09:28:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-05 09:28:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '848d14e5-f7ec-4f34-ba72-61be6270cd1c', '1', 'ee919387-806e-40b4-b2a3-e4b4d4995240');
INSERT INTO `f00_user_org` VALUES ('e4b8e09b-42bf-4015-9bcb-be2cc0fa6754', '2017-07-05 09:23:30', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '1', '2017-07-05 09:23:30', 'a25b3652-77be-4bfe-8f87-de22253312e5', '39eb4393-2845-4016-b6cb-e5f2d459cc78', '1', 'a25b3652-77be-4bfe-8f87-de22253312e5');

-- ----------------------------
-- Table structure for f00_user_role
-- ----------------------------
DROP TABLE IF EXISTS `f00_user_role`;
CREATE TABLE `f00_user_role` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) NOT NULL,
  `parent_id` varchar(36) NOT NULL,
  `sort_num` int(11) NOT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `role_record_id` varchar(255) DEFAULT NULL,
  `user_record_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f00_user_role
-- ----------------------------
INSERT INTO `f00_user_role` VALUES ('16372f39-102b-4c57-ab59-102b00dfb814', '2017-07-05 09:28:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-05 09:28:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '07557f06-0bf5-4b31-876a-b72242c7fea2', 'ee919387-806e-40b4-b2a3-e4b4d4995240');
INSERT INTO `f00_user_role` VALUES ('1e08a2a6-15d1-4337-9f82-929808e7d542', '2017-07-05 09:31:24', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '11', '2017-07-05 09:31:24', 'a25b3652-77be-4bfe-8f87-de22253312e5', '168ea4a8-0ef2-482d-aea2-24986aab76bc', 'ca7519f4-8710-4cc8-a5ec-4a29c572e03b');
INSERT INTO `f00_user_role` VALUES ('207fed9d-6c65-42bd-b88c-947a442dd1a8', '2017-07-05 09:28:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-05 09:28:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'e9d7b063-f83f-465c-b4b3-23badc882d6c', 'ee919387-806e-40b4-b2a3-e4b4d4995240');
INSERT INTO `f00_user_role` VALUES ('2ae73620-04a7-48e9-992c-1136e59bd9bd', '2017-07-05 09:28:17', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-05 09:28:17', 'a25b3652-77be-4bfe-8f87-de22253312e5', '07557f06-0bf5-4b31-876a-b72242c7fea2', 'b65f2c5a-e4a8-451c-abac-64dac6bb767f');
INSERT INTO `f00_user_role` VALUES ('3a1fc8d0-d9bd-4ca5-99e2-8dbc5cb5996d', '2017-07-05 09:24:08', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '4', '2017-07-05 09:24:08', 'a25b3652-77be-4bfe-8f87-de22253312e5', '168ea4a8-0ef2-482d-aea2-24986aab76bc', 'dcd8e5d9-f533-4b82-974d-43d0477f61d0');
INSERT INTO `f00_user_role` VALUES ('4d04f824-4a1a-43da-bc20-0d516e804ef4', '2017-07-05 09:27:49', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-07-05 09:27:49', 'a25b3652-77be-4bfe-8f87-de22253312e5', '168ea4a8-0ef2-482d-aea2-24986aab76bc', '21037852-873e-4940-a4ac-623a23a809b9');
INSERT INTO `f00_user_role` VALUES ('61b902de-aecc-442a-837c-8345c918c3d4', '2017-07-05 09:28:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '7', '2017-07-05 09:28:51', 'a25b3652-77be-4bfe-8f87-de22253312e5', '168ea4a8-0ef2-482d-aea2-24986aab76bc', 'ee919387-806e-40b4-b2a3-e4b4d4995240');
INSERT INTO `f00_user_role` VALUES ('6700670f-4e85-42ae-beea-84a200ae5da3', '2017-07-06 11:38:23', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '12', '2017-07-06 11:38:23', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'f1d1e1e5-d55c-42bf-afe2-01cd8700c2ca', 'c0479a93-3e23-428b-8556-ec5bc8ecf638');
INSERT INTO `f00_user_role` VALUES ('6a4c4d98-6d8a-4372-9c7f-abca487d4078', '2017-07-05 09:30:44', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '9', '2017-07-05 09:30:44', 'a25b3652-77be-4bfe-8f87-de22253312e5', '168ea4a8-0ef2-482d-aea2-24986aab76bc', 'ff2f5e46-b5ba-4f5b-81ea-b79ce8da87eb');
INSERT INTO `f00_user_role` VALUES ('6c5d89ad-227c-4dc4-bd57-6f65d260b6b1', '2017-07-05 09:31:05', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '10', '2017-07-05 09:31:05', 'a25b3652-77be-4bfe-8f87-de22253312e5', '168ea4a8-0ef2-482d-aea2-24986aab76bc', 'e334b51c-09aa-44b2-b1c2-0fbe1f0c1a19');
INSERT INTO `f00_user_role` VALUES ('c2ac7209-8343-4f04-a4d2-facf0ca172d6', '2017-07-05 09:28:17', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '6', '2017-07-05 09:28:17', 'a25b3652-77be-4bfe-8f87-de22253312e5', '168ea4a8-0ef2-482d-aea2-24986aab76bc', 'b65f2c5a-e4a8-451c-abac-64dac6bb767f');
INSERT INTO `f00_user_role` VALUES ('d252a4ce-f85a-4caa-b5c6-117777d9b217', '2017-07-05 09:27:49', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '5', '2017-07-05 09:27:49', 'a25b3652-77be-4bfe-8f87-de22253312e5', '07557f06-0bf5-4b31-876a-b72242c7fea2', '21037852-873e-4940-a4ac-623a23a809b9');
INSERT INTO `f00_user_role` VALUES ('d3186c82-09b3-418c-a48b-44286ebcc364', '2017-07-05 09:23:30', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '2', '2017-07-05 09:23:30', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'e9d7b063-f83f-465c-b4b3-23badc882d6c', 'a25b3652-77be-4bfe-8f87-de22253312e5');
INSERT INTO `f00_user_role` VALUES ('d8168877-85a0-4b06-8bbf-a064ab87e1c1', '2017-07-05 09:29:20', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '8', '2017-07-05 09:29:20', 'a25b3652-77be-4bfe-8f87-de22253312e5', '168ea4a8-0ef2-482d-aea2-24986aab76bc', '41abebfe-85ba-4efc-b839-bc6098014f20');
INSERT INTO `f00_user_role` VALUES ('df21a046-341c-42e8-9a78-3b57615e379a', '2017-07-05 09:24:08', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '', '4', '2017-07-05 09:24:08', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'e9d7b063-f83f-465c-b4b3-23badc882d6c', 'dcd8e5d9-f533-4b82-974d-43d0477f61d0');

-- ----------------------------
-- Table structure for f01_dict
-- ----------------------------
DROP TABLE IF EXISTS `f01_dict`;
CREATE TABLE `f01_dict` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) NOT NULL,
  `parent_id` varchar(36) NOT NULL,
  `sort_num` int(11) NOT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `dict_code` varchar(255) NOT NULL,
  `dict_name` varchar(255) NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `UK_gdb7tcdgqrt6b4p5v0bmkiuyd` (`dict_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f01_dict
-- ----------------------------
INSERT INTO `f01_dict` VALUES ('157a93bb-ef72-41a9-a498-2c3ca690a50c', '2017-06-25 23:37:40', 'jihuaizhi', '1', '', '0', '2017-07-18 14:42:47', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'CD_001', '行政区划');
INSERT INTO `f01_dict` VALUES ('1cfb70f3-9a2c-4acc-88b2-e52c15c605cb', '2017-06-25 23:37:52', 'jihuaizhi', '1', '', '0', '2017-07-18 14:44:58', 'a25b3652-77be-4bfe-8f87-de22253312e5', 'CD_002', '系统模块');

-- ----------------------------
-- Table structure for f01_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `f01_dict_data`;
CREATE TABLE `f01_dict_data` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) NOT NULL,
  `parent_id` varchar(36) NOT NULL,
  `sort_num` int(11) NOT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `dict_data_code` varchar(255) DEFAULT NULL,
  `dict_data_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `UK_c6ao1a8o67a3hvn4pibrqmq6m` (`dict_data_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f01_dict_data
-- ----------------------------
INSERT INTO `f01_dict_data` VALUES ('005379d5-30fe-495b-b3a3-27b1dd669f03', '2017-07-18 14:45:27', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '157a93bb-ef72-41a9-a498-2c3ca690a50c', '2', '2017-07-18 14:45:27', 'a25b3652-77be-4bfe-8f87-de22253312e5', '002', '河南省');
INSERT INTO `f01_dict_data` VALUES ('45d5e68f-9d9e-4b83-97f0-356d25a723e5', '2017-07-18 14:45:38', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '157a93bb-ef72-41a9-a498-2c3ca690a50c', '3', '2017-07-18 14:45:38', 'a25b3652-77be-4bfe-8f87-de22253312e5', '003', '陕西省');
INSERT INTO `f01_dict_data` VALUES ('8d16f296-b17c-40a4-97d8-d4c0cb31360a', '2017-07-18 14:45:17', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '157a93bb-ef72-41a9-a498-2c3ca690a50c', '1', '2017-07-18 14:45:17', 'a25b3652-77be-4bfe-8f87-de22253312e5', '001', '山东省');
INSERT INTO `f01_dict_data` VALUES ('b4b01bb0-07c9-4c59-b0e9-b3f3a7e427e7', '2017-07-18 14:46:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '1', '1cfb70f3-9a2c-4acc-88b2-e52c15c605cb', '1', '2017-07-18 14:46:57', 'a25b3652-77be-4bfe-8f87-de22253312e5', '005', '系统管理');

-- ----------------------------
-- Table structure for f02_rule
-- ----------------------------
DROP TABLE IF EXISTS `f02_rule`;
CREATE TABLE `f02_rule` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `sort_num` int(11) DEFAULT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `dsId` varchar(255) DEFAULT NULL,
  `ruleDescription` varchar(255) DEFAULT NULL,
  `ruleName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f02_rule
-- ----------------------------

-- ----------------------------
-- Table structure for f02_rule_check_record
-- ----------------------------
DROP TABLE IF EXISTS `f02_rule_check_record`;
CREATE TABLE `f02_rule_check_record` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `sort_num` int(11) DEFAULT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `decideResult` varchar(255) DEFAULT NULL,
  `prefixResult` varchar(255) DEFAULT NULL,
  `ruleRecordId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f02_rule_check_record
-- ----------------------------

-- ----------------------------
-- Table structure for f02_rule_condition
-- ----------------------------
DROP TABLE IF EXISTS `f02_rule_condition`;
CREATE TABLE `f02_rule_condition` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `sort_num` int(11) DEFAULT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `conditionType` varchar(255) DEFAULT NULL,
  `fieldName` varchar(255) DEFAULT NULL,
  `fieldValue` varchar(255) DEFAULT NULL,
  `logicalOperator` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f02_rule_condition
-- ----------------------------

-- ----------------------------
-- Table structure for f02_rule_ds
-- ----------------------------
DROP TABLE IF EXISTS `f02_rule_ds`;
CREATE TABLE `f02_rule_ds` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `sort_num` int(11) DEFAULT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `dsDescription` varchar(255) DEFAULT NULL,
  `dsName` varchar(255) DEFAULT NULL,
  `dsObjectName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f02_rule_ds
-- ----------------------------

-- ----------------------------
-- Table structure for f02_rule_ds_field
-- ----------------------------
DROP TABLE IF EXISTS `f02_rule_ds_field`;
CREATE TABLE `f02_rule_ds_field` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `sort_num` int(11) DEFAULT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `dsId` varchar(255) DEFAULT NULL,
  `fieldCode` varchar(255) DEFAULT NULL,
  `fieldName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of f02_rule_ds_field
-- ----------------------------

-- ----------------------------
-- Table structure for p01_defect
-- ----------------------------
DROP TABLE IF EXISTS `p01_defect`;
CREATE TABLE `p01_defect` (
  `record_id` varchar(36) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` varchar(36) NOT NULL,
  `data_flag` varchar(1) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `sort_num` int(11) DEFAULT NULL,
  `update_at` datetime NOT NULL,
  `update_by` varchar(36) NOT NULL,
  `defect_code` varchar(255) DEFAULT NULL,
  `analyse_at` datetime DEFAULT NULL,
  `analyse_by` varchar(255) DEFAULT NULL,
  `analyse_content` varchar(255) DEFAULT NULL,
  `close_type` varchar(255) DEFAULT NULL,
  `defect_attachment` varchar(255) DEFAULT NULL,
  `defect_content` varchar(255) DEFAULT NULL,
  `defect_level` varchar(255) DEFAULT NULL,
  `defect_module` varchar(255) DEFAULT NULL,
  `defect_title` varchar(255) DEFAULT NULL,
  `modify_at` datetime DEFAULT NULL,
  `modify_by` varchar(255) DEFAULT NULL,
  `modify_content` varchar(255) DEFAULT NULL,
  `validate_at` datetime DEFAULT NULL,
  `validate_by` varchar(255) DEFAULT NULL,
  `validate_content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `UK_oj01e3c1wkttc9ynwm5dcar2h` (`defect_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of p01_defect
-- ----------------------------
