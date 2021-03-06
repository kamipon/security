-- 表名应全部大写，只包含26个大写字母和“_”。
--
-- 数据表的命名格式为：
--
-- bth：代表批量数据类（Batch）
-- mng：表示管理类表（Management）
-- hty：代表历史数据类（History）
-- rpt：表示报表类（Report）
-- sys：代表系统信息类（System）
-- temp：表示临时表（Temp）

DROP DATABASE IF EXISTS `vplusdb`;
CREATE DATABASE IF NOT EXISTS `vplusdb` DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

CREATE USER 'vplus'@'localhost' IDENTIFIED BY '1qaz@WSX';
GRANT ALL PRIVILEGES ON vplusdb.* TO 'vplus'@'localhost';

USE `vplusdb`;
# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.24)
# Database: vplusdb
# Generation Time: 2019-01-28 03:51:11 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table mng_admin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mng_admin`;

CREATE TABLE `mng_admin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(60) NOT NULL COMMENT '密码，加密存储',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `channel` tinyint(4) DEFAULT '0' COMMENT '标识渠道，不同的渠道就是不同的资源分组: 0:内管',
  PRIMARY KEY (`id`),
  KEY `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

LOCK TABLES `mng_admin` WRITE;
/*!40000 ALTER TABLE `mng_admin` DISABLE KEYS */;

INSERT INTO `mng_admin` (`id`, `create_time`, `username`, `password`, `phone`, `email`, `channel`)
VALUES
	(1,'2018-11-10 23:12:02','admin','$2a$10$XQi3SDI8aU8VL8PQkkyddOYk62OmDBtLwD9f9EEKf0AZBI0Y7pwPq','15399999999','15399999999@163.com',0),
	(1070971226366672898,'2018-12-07 17:20:13','test','$2a$10$5BFfI0/kHW86vyqOPobbQuhKVISsjyz5QdvmEgO.hAnuWFfvcUZLe','177777777778','177777777777@qq.com',0),
	(1089449434464444417,'2019-01-27 17:06:01','xiaoma','$2a$10$zfp55JN8/lWwL7.BrRljieuhnmszvQhIurOF4pWqpothFDDEP5fde','18888888888','',0);

/*!40000 ALTER TABLE `mng_admin` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mng_interface
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mng_interface`;

CREATE TABLE `mng_interface` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `url` varchar(255) NOT NULL COMMENT '接口地址',
  `name` varchar(255) DEFAULT NULL COMMENT '接口名称',
  `method` varchar(6) DEFAULT 'GET' COMMENT '接口类型，如GET标识添加',
  `description` varchar(55) DEFAULT NULL COMMENT '接口描述',
  `status` tinyint(4) DEFAULT '1' COMMENT '接口状态:  1:启用   0:不启用',
  `channel` tinyint(4) DEFAULT '0' COMMENT '标识渠道，不同的渠道就是不同的资源分组: 0:内管',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统接口表';

LOCK TABLES `mng_interface` WRITE;
/*!40000 ALTER TABLE `mng_interface` DISABLE KEYS */;

INSERT INTO `mng_interface` (`id`, `url`, `name`, `method`, `description`, `status`, `channel`)
VALUES
	(1071771910230102017,'interface/*/*/*','接口记录分页查询','GET','接口记录分页查询，获取内管系统的接口记录数据',1,0),
	(1071944020369932289,'interface/search/*/*/*','接口记录分页检索','GET',NULL,1,0),
	(1071946342613450753,'interface/*','通过id查询接口记录','GET',NULL,1,0),
	(1071946627691905025,'interface','新增接口记录','POST',NULL,1,0),
	(1071946834118770689,'interface','更新接口记录','PUT',NULL,1,0),
	(1071947074632744962,'interface/dels/*','批量删除接口记录','DELETE','删除路径接口ids集合对应的记录和关联记录',1,0),
	(1072330654840004609,'interface/list/*','接口记录列表查询','GET','查询对应渠道完整的接口列表',1,0),
	(1072331299127042049,'admin/*/*/*','用户记录分页查询','GET','对应渠道用户记录分页查询接口',1,0),
	(1072331976972705793,'admin/search/dto/*/*/*','用户【AdminDto】记录分页检索','POST','检索对应渠道用户【AdminDto】记录，检索条件【用户名、手机、邮箱】',1,0),
	(1072332949208178689,'admin/search/*/*/*','用户记录分页检索','POST','检索渠道用户记录，检索条件【用户名、手机号、邮箱】',1,0),
	(1072333184286334977,'admin/me','登录用户自身记录查询','GET','查询登录用户自身的用户详细信息',1,0),
	(1072333426549334018,'admin/*','用户记录查询','GET','根据路径参数id查询用户详细信息',1,0),
	(1072333891391463426,'admin','新增用户','POST','新增用户,关联的角色记录，必须传递到{@link AdminDto#roleIds}字段中',1,0),
	(1072334093670162433,'admin','更新用户信息','PUT','关联的角色记录，必须传递到{@link AdminDto#roleIds}字段中',1,0),
	(1072334573427236865,'admin/pwd','更新用户密码','PUT','只能在用户拥有系统管理员角色权限的状态下使用该接口',1,0),
	(1072335074319409153,'admin/dels/*','批量删除用户记录','DELETE','根据路径参数解析待删除的用户记录id集合，登录用户自身不能删除自己的记录',1,0),
	(1072335340619964418,'admin/*','删除用户记录','DELETE','根据路径参数用户记录id删除对应用户，登录用户自身不能删除自己的记录',1,0),
	(1072401780471554049,'role/list/*','角色记录列表查询','GET','查询对应渠道所有角色记录',1,0),
	(1072402009283420161,'role/*/*/*','角色记录分页查询','GET','分页查询对应渠道角色记录',1,0),
	(1072402252855042050,'role/search/*/*/*','角色记录分页检索','GET','分页检索对应渠道角色记录',1,0),
	(1072402870944456705,'role/eleui/*/*/*','角色记录（适配eleui）分页查询','GET','分页查询对应渠道角色记录，适配前端element-ui数据格式要求，提供展开功能所属数据而定义',1,0),
	(1072403116403515393,'role/search/eleui/*/*/*','角色记录（适配eleui）分页检索','GET','分页检索对应渠道角色记录，适配前端element-ui数据格式要求，提供展开功能所属数据而定义',1,0),
	(1072403498286505986,'role/*','角色记录查询','GET','根据路径参数角色id查询其详细数据',1,0),
	(1072404526595629057,'role','新增角色','POST','添加角色和其管理的资源记录',1,0),
	(1072404754258255874,'role','更新角色信息','PUT','更新角色信息和其管理的资源记录',1,0),
	(1072405066704543745,'role','批量删除角色','DELETE','批量删除角色角色和其管理的资源记录',1,0),
	(1072405676518596609,'resource/search/*/*','检索获取资源树','GET','获取对应渠道，对应状态的树形资源列表',1,0),
	(1072406098922758145,'resource/*','查询资源树','GET','查询对应渠道的树形资源列表',1,0),
	(1072406654538014721,'resource/*/*','查询对应节点下的资源树','GET','查询对应节点下（根据路径参数资源id）的资源树',1,0),
	(1072407028741234689,'resource/qry/*','查询资源和其关联接口记录','GET','查询资源（根据路径参数资源id）和其关联接口记录',1,0),
	(1072408073223593986,'resource','新增资源','POST','新增资源和关联的接口记录',1,0),
	(1072408392401739778,'resource','更新资源信息','PUT','更新资源和关联的接口记录',1,0),
	(1072408761852813314,'resource','删除资源记录','DELETE','自有对应记录是叶子节点才允许删除',1,0);

/*!40000 ALTER TABLE `mng_interface` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mng_resource
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mng_resource`;

CREATE TABLE `mng_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `pid` bigint(20) DEFAULT '0' COMMENT '资源父id: 0标识(默认)为根节点',
  `pids` varchar(255) DEFAULT '0' COMMENT '当前资源的所有父节点id集合: 0(默认)',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '资源名称',
  `icon` varchar(55) DEFAULT NULL COMMENT '菜单图标',
  `num` int(65) DEFAULT NULL COMMENT '菜单排序号',
  `levels` int(65) DEFAULT '1' COMMENT '菜单层级',
  `type` tinyint(4) DEFAULT '1' COMMENT '类型: 1:菜单(默认) 0:按钮',
  `status` tinyint(4) DEFAULT '1' COMMENT '菜单状态:  1:启用   0:不启用',
  `channel` tinyint(4) DEFAULT '0' COMMENT '标识渠道，不同的渠道就是不同的资源分组: 0:内管',
  `path` varchar(255) DEFAULT NULL COMMENT '页面地址',
  `alias` varchar(255) DEFAULT NULL COMMENT '资源别名，用于唯一标识当前资源，方便前端进行权限控制',
  PRIMARY KEY (`id`),
  KEY `idx_pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限资源表';

LOCK TABLES `mng_resource` WRITE;
/*!40000 ALTER TABLE `mng_resource` DISABLE KEYS */;

INSERT INTO `mng_resource` (`id`, `pid`, `pids`, `name`, `icon`, `num`, `levels`, `type`, `status`, `channel`, `path`, `alias`)
VALUES
	(1061818316563202049,0,'0','权限管理','cog',2,1,1,1,0,'/mngauth',NULL),
	(1061818318412890114,1061818316563202049,'0,1061818316563202049','用户管理','users',1,2,1,1,0,'/mngauth/admin','MNG_USERMNG'),
	(1061818318463221761,1061818316563202049,'0,1061818316563202049','角色管理','id-badge',2,2,1,1,0,'/mngauth/role','MNG_ROLEMNG'),
	(1061818318517747714,1061818316563202049,'0,1061818316563202049','资源管理','tree',3,2,1,1,0,'/mngauth/resource',NULL),
	(1061993676089069570,1061818318517747714,'0,1061818316563202049,1061818318517747714','新增资源',NULL,2,3,0,1,0,NULL,NULL),
	(1062518178556526593,0,'0','首页','home',1,1,1,1,0,'/index',NULL),
	(1062546326157291522,1061818318517747714,'0,1061818316563202049,1061818318517747714','修改资源',NULL,3,3,0,1,0,NULL,NULL),
	(1065904215529881601,1061818318517747714,'0,1061818316563202049,1061818318517747714','删除资源','',1,3,0,1,0,'',NULL),
	(1071741995531116546,1061818316563202049,'0,1061818316563202049','接口管理','cubes',4,2,1,1,0,'/mngauth/interface',NULL),
	(1072409793538351105,1061818318412890114,'0,1061818316563202049,1061818318412890114','添加用户','',1,3,0,1,0,'',NULL),
	(1072411775988719617,1061818318412890114,'0,1061818316563202049,1061818318412890114','修改用户信息','',2,3,0,1,0,'','MNG_ADMIN_UPDATE'),
	(1072423117311217666,1061818318412890114,'0,1061818316563202049,1061818318412890114','删除用户记录','',3,3,0,1,0,'',NULL),
	(1072423654035329025,1061818318412890114,'0,1061818316563202049,1061818318412890114','修改用户密码','',4,3,0,1,0,'',NULL),
	(1072479148267610113,1061818318412890114,'0,1061818316563202049,1061818318412890114','检索用户','',5,3,0,1,0,'',NULL),
	(1072479531987705857,1061818318463221761,'0,1061818316563202049,1061818318463221761','新增角色','',1,3,0,1,0,'',NULL),
	(1072479891854794754,1061818318463221761,'0,1061818316563202049,1061818318463221761','修改角色','',2,3,0,1,0,'','MNG_ROLE_UPDATE'),
	(1072480179055566850,1061818318463221761,'0,1061818316563202049,1061818318463221761','删除角色记录','',3,3,0,1,0,'',NULL),
	(1072480383884402689,1061818318463221761,'0,1061818316563202049,1061818318463221761','检索角色','',4,3,0,1,0,'',NULL),
	(1072481532435832833,1061818318517747714,'0,1061818316563202049,1061818318517747714','检索资源','',4,3,0,1,0,'',NULL),
	(1072481907305947137,1071741995531116546,'0,1061818316563202049,1071741995531116546','新增接口','',1,3,0,1,0,'',NULL),
	(1072482204396888065,1071741995531116546,'0,1061818316563202049,1071741995531116546','更新接口','',2,3,0,1,0,'','MNG_INTERFACE_UPDATE'),
	(1072482418163785730,1071741995531116546,'0,1061818316563202049,1071741995531116546','删除接口记录','',3,3,0,1,0,'',NULL),
	(1072485142741721090,1071741995531116546,'0,1061818316563202049,1071741995531116546','检索接口','',4,3,0,1,0,'',NULL),
	(1075958459221995521,1061818318517747714,'0,1061818316563202049,1061818318517747714','查看关联接口记录','',5,3,0,1,0,'',''),
	(1089714060351557634,0,'0','开发运维','american-sign-language-interpreting',3,1,1,1,0,'/develop','DEVELOP'),
	(1089714800168062977,1089714060351557634,'0,1089714060351557634','接口文档','code',1,2,1,1,0,'/develop/swagger-ui','SWAGGER_API');

/*!40000 ALTER TABLE `mng_resource` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mng_resource_interface
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mng_resource_interface`;

CREATE TABLE `mng_resource_interface` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `resource_id` bigint(20) NOT NULL COMMENT '资源主键',
  `interface_id` bigint(20) NOT NULL COMMENT '接口主键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源接口关联表';

LOCK TABLES `mng_resource_interface` WRITE;
/*!40000 ALTER TABLE `mng_resource_interface` DISABLE KEYS */;

INSERT INTO `mng_resource_interface` (`id`, `resource_id`, `interface_id`)
VALUES
	(12,1072050773602344962,1071771910230102017),
	(19,1072423117311217666,1072335074319409153),
	(20,1072423654035329025,1072334573427236865),
	(23,1072479148267610113,1072332949208178689),
	(24,1072479531987705857,1072404526595629057),
	(28,1072480179055566850,1072405066704543745),
	(29,1072480383884402689,1072403116403515393),
	(30,1061818318517747714,1072406098922758145),
	(31,1065904215529881601,1072408761852813314),
	(32,1061993676089069570,1072408073223593986),
	(33,1062546326157291522,1072408392401739778),
	(34,1072481532435832833,1072405676518596609),
	(35,1071741995531116546,1071771910230102017),
	(36,1072481907305947137,1071946627691905025),
	(39,1072482418163785730,1071947074632744962),
	(40,1072485142741721090,1071944020369932289),
	(50,1072409793538351105,1072333891391463426),
	(53,1072411775988719617,1072333426549334018),
	(54,1072411775988719617,1072334093670162433),
	(55,1061818318463221761,1072402870944456705),
	(56,1061818318463221761,1072406098922758145),
	(57,1072479891854794754,1072404754258255874),
	(58,1072479891854794754,1072406098922758145),
	(61,1072482204396888065,1071946834118770689),
	(62,1072482204396888065,1071946342613450753),
	(63,1061818318412890114,1072401780471554049),
	(64,1061818318412890114,1072333426549334018),
	(65,1061818318412890114,1072331299127042049),
	(66,1075958459221995521,1072407028741234689),
	(67,1076849836457750529,1071771910230102017);

/*!40000 ALTER TABLE `mng_resource_interface` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mng_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mng_role`;

CREATE TABLE `mng_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) NOT NULL COMMENT '角色名称',
  `authority_name` varchar(10) NOT NULL COMMENT '角色标识',
  `channel` tinyint(4) NOT NULL DEFAULT '0' COMMENT '标识渠道，不同的渠道就是不同的资源分组: 0:内管',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

LOCK TABLES `mng_role` WRITE;
/*!40000 ALTER TABLE `mng_role` DISABLE KEYS */;

INSERT INTO `mng_role` (`id`, `name`, `authority_name`, `channel`)
VALUES
	(1061277220292595713,'系统管理员','ADMIN',0),
	(1061277221798350849,'数据库管理员','DB',0),
	(1061277221831905282,'部门操作员','OPERATOR',0),
	(1089510917961474050,'test','test',0),
	(1089511853551312898,'test1','test1',0),
	(1089512138789150721,'add','addddw',0);

/*!40000 ALTER TABLE `mng_role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mng_role_admin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mng_role_admin`;

CREATE TABLE `mng_role_admin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` bigint(20) NOT NULL COMMENT '角色主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户主键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色用户关联表';

LOCK TABLES `mng_role_admin` WRITE;
/*!40000 ALTER TABLE `mng_role_admin` DISABLE KEYS */;

INSERT INTO `mng_role_admin` (`id`, `role_id`, `user_id`)
VALUES
	(1,1061277220292595713,1),
	(38,1061277221831905282,1070971226366672898),
	(39,1061277220292595713,1070971226366672898),
	(41,1061277220292595713,1089449434464444417);

/*!40000 ALTER TABLE `mng_role_admin` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mng_role_resource
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mng_role_resource`;

CREATE TABLE `mng_role_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` bigint(20) NOT NULL COMMENT '角色主键',
  `resource_id` bigint(20) NOT NULL COMMENT '资源主键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色资源关联表';

LOCK TABLES `mng_role_resource` WRITE;
/*!40000 ALTER TABLE `mng_role_resource` DISABLE KEYS */;

INSERT INTO `mng_role_resource` (`id`, `role_id`, `resource_id`)
VALUES
	(159,1061277220292595713,1062518178556526593),
	(160,1061277220292595713,1066671419766624257),
	(161,1061277220292595713,1061818316563202049),
	(162,1061277220292595713,1061818318412890114),
	(163,1061277220292595713,1061818318463221761),
	(164,1061277220292595713,1061818318517747714),
	(165,1061277220292595713,1065904215529881601),
	(166,1061277220292595713,1061993676089069570),
	(167,1061277220292595713,1062546326157291522),
	(212,1061277220292595713,1071741995531116546),
	(213,1061277220292595713,1072409793538351105),
	(214,1061277220292595713,1072411775988719617),
	(215,1061277220292595713,1072423117311217666),
	(216,1061277220292595713,1072423654035329025),
	(217,1061277220292595713,1072479148267610113),
	(218,1061277220292595713,1072479531987705857),
	(219,1061277220292595713,1072479891854794754),
	(220,1061277220292595713,1072480179055566850),
	(221,1061277220292595713,1072480383884402689),
	(222,1061277220292595713,1072481532435832833),
	(223,1061277220292595713,1072481907305947137),
	(224,1061277220292595713,1072482204396888065),
	(225,1061277220292595713,1072482418163785730),
	(226,1061277220292595713,1072485142741721090),
	(684,1061277221798350849,1062518178556526593),
	(685,1061277221798350849,1061818316563202049),
	(792,1061277220292595713,1075958459221995521),
	(891,1061277221831905282,1061818318412890114),
	(892,1061277221831905282,1072411775988719617),
	(893,1061277221831905282,1062518178556526593),
	(894,1061277221831905282,1061818316563202049),
	(895,1089512138789150721,1062518178556526593),
	(896,1061277220292595713,1089714060351557634),
	(897,1061277220292595713,1089714800168062977);

/*!40000 ALTER TABLE `mng_role_resource` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table persistent_logins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `persistent_logins`;

CREATE TABLE `persistent_logins` (
  `username` varchar(64) NOT NULL,
  `series` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `last_used` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`series`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table springsocial_UserConnection
# ------------------------------------------------------------

DROP TABLE IF EXISTS `springsocial_UserConnection`;

CREATE TABLE `springsocial_UserConnection` (
  `userId` varchar(255) NOT NULL,
  `providerId` varchar(255) NOT NULL,
  `providerUserId` varchar(255) NOT NULL,
  `rank` int(11) NOT NULL,
  `displayName` varchar(255) DEFAULT NULL,
  `profileUrl` varchar(512) DEFAULT NULL,
  `imageUrl` varchar(512) DEFAULT NULL,
  `accessToken` varchar(512) NOT NULL,
  `secret` varchar(512) DEFAULT NULL,
  `refreshToken` varchar(512) DEFAULT NULL,
  `expireTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`userId`,`providerId`,`providerUserId`),
  UNIQUE KEY `UserConnectionRank` (`userId`,`providerId`,`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
