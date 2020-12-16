/*
 Navicat Premium Data Transfer

 Source Server         : mysql_aly
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3306
 Source Schema         : goodsmovie

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 02/10/2019 03:31:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_super` smallint(6) NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `ix_admin_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'pbkdf2:sha256:50000$0OYo4pGP$d557b06caec711448e9907afc030726294a50363f44044d5cf6c5ef905957808', 0, 1, '2019-02-28 19:24:31');

-- ----------------------------
-- Table structure for adminlog
-- ----------------------------
DROP TABLE IF EXISTS `adminlog`;
CREATE TABLE `adminlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NULL DEFAULT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_id`(`admin_id`) USING BTREE,
  INDEX `ix_adminlog_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `adminlog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of adminlog
-- ----------------------------
INSERT INTO `adminlog` VALUES (1, 1, '123.117.7.162', '2019-03-05 19:29:50');
INSERT INTO `adminlog` VALUES (2, 1, '123.115.1.227', '2019-03-11 15:20:31');
INSERT INTO `adminlog` VALUES (3, 1, '221.217.98.76', '2019-03-19 09:38:58');
INSERT INTO `adminlog` VALUES (4, 1, '221.217.96.221', '2019-03-19 16:34:54');
INSERT INTO `adminlog` VALUES (5, 1, '123.117.4.176', '2019-04-07 17:30:00');
INSERT INTO `adminlog` VALUES (6, 1, '222.128.176.107', '2019-05-19 20:46:20');
INSERT INTO `adminlog` VALUES (7, 1, '222.128.176.107', '2019-05-19 21:34:29');
INSERT INTO `adminlog` VALUES (8, 1, '222.128.178.72', '2019-05-19 21:44:01');
INSERT INTO `adminlog` VALUES (9, 1, '114.249.225.21', '2019-05-20 09:36:59');
INSERT INTO `adminlog` VALUES (10, 1, '221.221.153.55', '2019-05-20 11:05:52');
INSERT INTO `adminlog` VALUES (11, 1, '221.221.153.62', '2019-05-21 08:49:15');
INSERT INTO `adminlog` VALUES (12, 1, '123.127.240.60', '2019-09-05 18:57:10');

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `url`(`url`) USING BTREE,
  INDEX `ix_auth_addtime`(`addtime`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth
-- ----------------------------
INSERT INTO `auth` VALUES (1, '标签添加', '/admin/tag/add/', '2019-03-01 10:37:36');
INSERT INTO `auth` VALUES (2, '标签列表', '/admin/tag/list/<int:page>/', '2019-03-01 10:38:05');
INSERT INTO `auth` VALUES (3, '标签删除', '/admin/tag/del/<int:id>/', '2019-03-01 10:38:23');
INSERT INTO `auth` VALUES (4, '标签修改', '/admin/tag/edit/<int:id>/', '2019-03-01 10:38:40');
INSERT INTO `auth` VALUES (5, '电影添加', '/admin/movie/add/', '2019-03-01 10:40:58');
INSERT INTO `auth` VALUES (6, '电影列表', '/admin/movie/list/<int:page>/', '2019-03-01 10:41:12');
INSERT INTO `auth` VALUES (7, '电影删除', '/admin/movie/del/<int:id>/', '2019-03-01 10:41:25');
INSERT INTO `auth` VALUES (8, '电影修改', '/admin/movie/edit/<int:id>/', '2019-03-01 10:41:38');
INSERT INTO `auth` VALUES (9, '预告添加', '/admin/preview/add/', '2019-03-01 10:41:50');
INSERT INTO `auth` VALUES (10, '预告列表', '/admin/preview/list/<int:page>/', '2019-03-01 10:42:05');
INSERT INTO `auth` VALUES (11, '预告删除', '/admin/preview/del/<int:id>/', '2019-03-01 10:42:25');
INSERT INTO `auth` VALUES (12, '预告修改', '/admin/preview/edit/<int:id>/', '2019-03-01 10:42:39');
INSERT INTO `auth` VALUES (13, '会员列表', '/admin/user/list/<int:page>/', '2019-03-01 10:42:54');
INSERT INTO `auth` VALUES (14, '会员详情', '/admin/user/view/<int:id>/', '2019-03-01 10:43:08');
INSERT INTO `auth` VALUES (15, '会员删除', '/admin/user/del/<int:id>/', '2019-03-01 10:43:21');
INSERT INTO `auth` VALUES (16, '评论列表', '/admin/comment/list/<int:page>/', '2019-03-01 10:43:34');
INSERT INTO `auth` VALUES (17, '评论删除', '/admin/comment/del/<int:id>/', '2019-03-01 10:43:47');
INSERT INTO `auth` VALUES (18, '收藏列表', '/admin/moviecol/list/<int:page>/', '2019-03-01 10:43:59');
INSERT INTO `auth` VALUES (19, '收藏删除', '/admin/moviecol/del/<int:id>/', '2019-03-01 10:44:15');
INSERT INTO `auth` VALUES (20, '管理员操作日志列表', '/admin/oplog/list/<int:page>/', '2019-03-01 10:44:30');
INSERT INTO `auth` VALUES (21, '管理员登录日志列表', '/admin/adminloginlog/list/<int:page>/', '2019-03-01 10:44:54');
INSERT INTO `auth` VALUES (22, '会员登录日志列表', '/admin/userloginlog/list/<int:page>/', '2019-03-01 10:45:06');
INSERT INTO `auth` VALUES (23, '权限添加', '/admin/auth/add/', '2019-03-01 10:45:18');
INSERT INTO `auth` VALUES (24, '权限列表', '/admin/auth/list/<int:page>/', '2019-03-01 10:45:31');
INSERT INTO `auth` VALUES (25, '权限删除', '/admin/auth/del/<int:id>/', '2019-03-01 10:45:50');
INSERT INTO `auth` VALUES (26, '权限修改', '/admin/auth/edit/<int:id>/', '2019-03-01 10:46:02');
INSERT INTO `auth` VALUES (27, '角色添加', '/admin/role/add/', '2019-03-01 10:46:17');
INSERT INTO `auth` VALUES (28, '角色列表', '/admin/role/list/<int:page>/', '2019-03-01 10:46:28');
INSERT INTO `auth` VALUES (29, '角色删除', '/admin/role/del/<int:id>/', '2019-03-01 10:46:44');
INSERT INTO `auth` VALUES (30, '角色修改', '/admin/role/edit/<int:id>/', '2019-03-01 10:46:56');
INSERT INTO `auth` VALUES (31, '管理员添加', '/admin/admin/add/', '2019-03-01 10:47:17');
INSERT INTO `auth` VALUES (32, '管理员列表', '/admin/admin/list/<int:page>/', '2019-03-01 10:47:30');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `movie_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `ix_comment_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, '<p>张孟卓2蛋</p>', 1, 3, '2019-03-04 10:47:00');
INSERT INTO `comment` VALUES (2, '<p>张孟卓2蛋</p>', 1, 3, '2019-03-04 10:47:06');
INSERT INTO `comment` VALUES (3, '<p>张孟卓2蛋</p>', 1, 3, '2019-03-04 10:47:50');
INSERT INTO `comment` VALUES (4, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0015.gif\"/></p>', 1, 1, '2019-03-04 12:27:04');
INSERT INTO `comment` VALUES (5, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0015.gif\"/></p>', 1, 1, '2019-03-04 12:27:09');
INSERT INTO `comment` VALUES (6, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0048.gif\"/></p>', 1, 1, '2019-03-04 12:27:20');
INSERT INTO `comment` VALUES (7, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0011.gif\"/></p>', 1, 1, '2019-03-04 12:27:39');
INSERT INTO `comment` VALUES (8, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0011.gif\"/></p>', 1, 1, '2019-03-04 12:27:47');
INSERT INTO `comment` VALUES (9, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0011.gif\"/></p>', 1, 1, '2019-03-04 12:27:57');
INSERT INTO `comment` VALUES (10, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0003.gif\"/></p>', 1, 1, '2019-03-04 12:48:29');
INSERT INTO `comment` VALUES (11, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0021.gif\"/></p>', 1, 1, '2019-03-04 12:50:18');
INSERT INTO `comment` VALUES (12, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0003.gif\"/></p>', 1, 1, '2019-03-04 12:52:43');
INSERT INTO `comment` VALUES (13, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0003.gif\"/></p>', 1, 1, '2019-03-04 12:52:46');
INSERT INTO `comment` VALUES (14, '<p><img src=\"http://img.baidu.com/hi/babycat/C_0015.gif\"/></p>', 1, 1, '2019-03-04 13:24:19');
INSERT INTO `comment` VALUES (15, '<p><img src=\"http://img.baidu.com/hi/tsj/t_0039.gif\"/></p>', 2, 1, '2019-03-04 13:35:15');
INSERT INTO `comment` VALUES (16, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0006.gif\"/></p>', 3, 1, '2019-03-04 14:44:18');
INSERT INTO `comment` VALUES (17, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0055.gif\"/></p>', 3, 1, '2019-03-04 14:44:21');
INSERT INTO `comment` VALUES (18, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0080.gif\"/></p>', 3, 1, '2019-03-04 14:44:26');
INSERT INTO `comment` VALUES (19, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0080.gif\"/></p>', 1, 1, '2019-03-11 15:19:54');

-- ----------------------------
-- Table structure for movie
-- ----------------------------
DROP TABLE IF EXISTS `movie`;
CREATE TABLE `movie`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `star` smallint(6) NULL DEFAULT NULL,
  `playnum` bigint(20) NULL DEFAULT NULL,
  `commentnum` bigint(20) NULL DEFAULT NULL,
  `tag_id` int(11) NULL DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `length` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `release_time` date NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `title`(`title`) USING BTREE,
  UNIQUE INDEX `url`(`url`) USING BTREE,
  UNIQUE INDEX `logo`(`logo`) USING BTREE,
  INDEX `tag_id`(`tag_id`) USING BTREE,
  INDEX `ix_movie_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie
-- ----------------------------
INSERT INTO `movie` VALUES (1, '小偷家族', '小偷家族.mp4', '做短工的治（中川雅也饰）与妻子信代（安藤樱饰）、“儿子”祥太（城桧吏饰）、信代的“妹妹”亚纪（松冈茉优饰）以及“老母亲”初枝（树木希林饰），依靠初枝的养老保险，在破烂的平房中艰难度日。治与儿子祥太做扒手，亚纪打工补贴家用。某一天，治带回在住宅区被冻僵的少女百合（佐佐木美雪饰），加入了他们原本就贫困潦倒的家庭中。一件事打破了原本的平衡，每个人心中隐藏的秘密和愿望也逐渐明朗。', '小偷家族.jpg', 5, 47, 15, 3, '日本', '120分钟', '2018-06-08', '2019-03-02 08:50:54');
INSERT INTO `movie` VALUES (2, '机器人总动员', '机器人总动员.mp4', '公元2700年，地球早就被人类祸害成了一个巨大的垃圾场，已经到了无法居住的地步，人类只能大举迁移到别的星球，然后委托一家机器人垃圾清理公司善后，直至地球的环境系统重新达到生态平衡。\r\n在人类离开之后，垃圾清理公司将机器人瓦力成批地输送到地球，并给他们安装了惟一的指令——垃圾分装，然而随着时间的推移，机器人一个接一个地坏掉，最后只剩下惟一的一个，继续在这个似乎已经被遗忘了的角落，勤勤恳恳地在垃圾堆中忙碌着，转眼就过去了几百年的时间，寂寞与孤独变成了围绕着他的永恒的主题。\r\n然而，一艘突然而至的宇宙飞船打破了这里的平静，它还带来了专职搜索任务的机器人伊娃，当瓦力经历了几百年的孤独，终于见到了另一个机器人时，他觉得自己好像爱上她了，伊娃在经过了精确的计算之后，数据显示出，看起来漫不经心的瓦力很可能是关乎着地球未来的关键所在，她通过宇宙飞船将自己的发现报告给人类，收到了将瓦力带离地球的指令——人类正想尽办法重回地球，所以他们不会放弃任何可能的机会。于是瓦力追随着伊娃，展开了一次穿越整个银河系、最令人兴奋、也是最具有想象力的奇幻旅程。', '机器人总动员.jpg', 5, 37, 1, 1, '美国', '97分钟', '2008-06-27', '2019-03-02 08:54:24');
INSERT INTO `movie` VALUES (3, '红海行动', '红海行动.mp4', '索马里海域外，中国商船遭遇劫持，部分船员被海盗杀害，其他人沦为俘虏。蛟龙突击队沉着应对，潜入商船进行突袭，成功解救全部人质。狙击手罗星在追击海盗时不幸被击中脊柱神经，欠缺的位置由顾顺替代。\r\n返航途中，非洲北部伊维亚共和国政局动荡，恐怖组织连同叛军攻入首都，当地华侨面临危险。海军战舰接到上级命令改变航向，前往执行撤侨任务。蛟龙突击队八人，整装待发。\r\n时间紧迫，在“撤侨遇袭可反击，相反则必须避免交火，以免引起外交冲突”的大原则下，海军战舰及蛟龙突击队在恶劣的环境下，停靠海港，成功转移等候在码头的中国侨民，并在激烈的遭遇战之后，营救了被恐怖分子追击的中国领事馆人员。\r\n然而事情尚未完结，就在掩护华侨撤离之际，蛟龙突击队收到中国人质被恐怖分子劫持的消息。众人深感责任重大，义无反顾地再度展开营救行动。', '红海行动.jpg', 5, 43, 3, 2, '中国大陆', '138分钟', '2018-02-16', '2019-03-02 09:00:49');
INSERT INTO `movie` VALUES (4, '地狱神探', '地狱神探.mp4', '影片讲述了康斯坦丁从小具有辨认恶魔与天使的能力，这种超能力对他造成无尽的困扰，迫使他选择自杀。但是天堂与地狱都不愿接纳康斯坦丁，对人类、恶魔甚至天使都失去信心的他从此游荡在天堂、地狱和人间。', '地狱神探.jpg', 5, 27, 0, 6, '美国、德国', '121分钟', '2005-02-08', '2019-03-02 09:03:17');
INSERT INTO `movie` VALUES (5, '魔女嘉莉', '魔女嘉莉.mp4', '玛格丽特·怀特（朱丽安·摩尔饰）与女儿嘉莉·怀特（科洛·格蕾斯·莫瑞兹饰）居住在缅因州的宁静郊区，嘉莉是个可爱的女孩，但性格严厉的母亲却禁止她一切社交活动。在学校中，以克莉丝（波茜娅·道布尔戴饰）为首的坏女孩们则常常以欺负嘉莉为乐，体育老师德斯贾丁斯小姐（朱迪·格雷尔饰）对饱受欺辱的嘉莉呵护有加，克莉丝的好友苏（加布瑞拉·王尔德饰）心中愧疚，为了表示歉意，苏让她的男友汤米（安塞尔·埃尔格特饰）带嘉莉参加学校舞会。然而在舞会上，嘉莉再度受到的羞辱令她濒临崩溃，从而释放出可怕的超能力。', '魔女嘉莉.jpg', 4, 33, 0, 5, '美国', '100分钟', '2013-10-18', '2019-03-02 09:05:07');
INSERT INTO `movie` VALUES (6, '无名之辈', '无名之辈.mp4', '在一座山间小城中，一对低配劫匪、一个落魄的泼皮保安、一个身体残疾却性格彪悍的残毒舌女以及一系列生活在社会不同轨迹上的小人物，在一个貌似平常的日子里，因为一把丢失的老枪和一桩当天发生在城中的乌龙劫案，从而被阴差阳错地拧到一起，发生的一幕幕令人啼笑皆非的荒诞喜剧。', '无名之辈.jpg', 5, 22, 0, 7, '中国大陆', '104分钟', '2018-11-16', '2019-03-02 09:06:55');
INSERT INTO `movie` VALUES (7, '星际穿越', '星际穿越.mp4', '在不远的未来，随着地球自然环境的恶化，人类面临着无法生存的威胁。这时科学家们在太阳系中的土星附近发现了一个虫洞，通过它可以打破人类的能力限制，到更遥远外太空寻找延续生命希望的机会。一个探险小组通过这个虫洞穿越到太阳系之外，他们的目标是找到一颗适合人类移民的星球。在这艘名叫做“Endurance”的飞船上，探险队员着面临着前所未有，人类思想前所未及的巨大挑战。\r\n然而，通过虫洞的时候，他们发现飞船上的一个小时相当于地球上的七年时间，即使探险小组的任务能够完成，他们的救赎对于对地球上仍然活着的人来说已经是太晚。飞行员库珀（马修·麦康纳饰演）必须在与自己的儿女重逢以及拯救人类的未来之间做出抉择。', '星际穿越.jpg', 5, 25, 0, 4, '美国，英国', '169分钟', '2014-11-12', '2019-03-02 10:13:30');
INSERT INTO `movie` VALUES (8, '流浪地球', '流浪地球.mp4', '近年来，科学家们发现太阳急速衰老膨胀，短时间内包括地球在内的整个太阳系都将被太阳所吞没。为了自救，人类提出一个名为“流浪地球”的大胆计划，即倾全球之力在地球表面建造上万座发动机和转向发动机，推动地球离开太阳系，用2500年的时间奔往另外一个栖息之地。\r\n中国航天员刘培强（吴京饰）在儿子刘启四岁那年前往国际空间站，和国际同侪肩负起领航者的重任。转眼刘启（屈楚萧饰）长大，他带着妹妹朵朵（赵今麦饰）偷偷跑到地表，偷开外公韩子昂（吴孟达饰）的运输车，结果不仅遭到逮捕，还遭遇了全球发动机停摆的事件。为了修好发动机，阻止地球坠入木星，全球开始展开饱和式营救，连刘启他们的车也被强征加入。在与时间赛跑的过程中，无数的人前仆后继，奋不顾身，只为延续百代子孙生存的希望。', '流浪地球.jpg', 5, 28, 0, 4, '中国', '125分钟', '2019-02-05', '2019-03-04 14:14:10');
INSERT INTO `movie` VALUES (9, '白蛇：缘起', '白蛇：缘起.mp4', '晚唐年间，国师发动民众大量捕蛇。前去刺杀国师的白蛇意外失忆，被捕蛇村少年阿宣救下。为帮助少女找回记忆，两人踏上了一段冒险旅程。过程中两人感情迅速升温，但少女蛇妖的身份也逐渐显露，另一边国师与蛇族之间不可避免的大战也即将打响，两人的爱情面临着巨大的考验。', '白蛇：缘起.jpg', 4, 29, 0, 1, '中国大陆、美国', '95分钟', '2019-01-11', '2019-03-04 14:30:22');
INSERT INTO `movie` VALUES (10, '绿皮书', '绿皮书.mp4', '托尼由于夜总会关门装修，也亟需一份工作。有个朋友建议他去参加一位音乐博士为了寻找司机所举办的面试。当他到达豪华公寓后，发现这位博士是个名叫唐的黑人古典乐钢琴家，钢琴家正需要一个司机，负责在他举办南方巡演时的接送工作。当然，两人心里都十分清楚，在二十世纪六十年代种族隔离严重的南部地区，他们很容易身陷麻烦之中，但托尼需要钱，而唐需要一个能照顾他的专业司机。给托尼付钱的唱片公司给了他一本“绿皮书”指南，上面列着当地黑人可以吃饭睡觉的地方，因为很多旅馆和餐厅都是只限白人。', '绿皮书.jpg', 5, 28, 0, 3, '美国', '130分钟', '2019-03-01', '2019-03-05 09:50:25');

-- ----------------------------
-- Table structure for moviecol
-- ----------------------------
DROP TABLE IF EXISTS `moviecol`;
CREATE TABLE `moviecol`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `ix_moviecol_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `moviecol_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `moviecol_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oplog
-- ----------------------------
DROP TABLE IF EXISTS `oplog`;
CREATE TABLE `oplog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NULL DEFAULT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reason` varchar(600) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_id`(`admin_id`) USING BTREE,
  INDEX `ix_oplog_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oplog
-- ----------------------------
INSERT INTO `oplog` VALUES (1, 1, '127.0.0.1', '添加一个权限：标签添加', '2019-03-01 10:37:36');
INSERT INTO `oplog` VALUES (2, 1, '127.0.0.1', '添加一个权限：标签列表', '2019-03-01 10:38:06');
INSERT INTO `oplog` VALUES (3, 1, '127.0.0.1', '添加一个权限：标签删除', '2019-03-01 10:38:23');
INSERT INTO `oplog` VALUES (4, 1, '127.0.0.1', '添加一个权限：标签修改', '2019-03-01 10:38:40');
INSERT INTO `oplog` VALUES (5, 1, '127.0.0.1', '修改一个权限：标签删除', '2019-03-01 10:38:55');
INSERT INTO `oplog` VALUES (6, 1, '127.0.0.1', '修改一个权限：标签添加', '2019-03-01 10:40:08');
INSERT INTO `oplog` VALUES (7, 1, '127.0.0.1', '修改一个权限：标签修改', '2019-03-01 10:40:15');
INSERT INTO `oplog` VALUES (8, 1, '127.0.0.1', '修改一个权限：标签删除', '2019-03-01 10:40:21');
INSERT INTO `oplog` VALUES (9, 1, '127.0.0.1', '修改一个权限：标签列表', '2019-03-01 10:40:27');
INSERT INTO `oplog` VALUES (10, 1, '127.0.0.1', '添加一个权限：电影添加', '2019-03-01 10:40:58');
INSERT INTO `oplog` VALUES (11, 1, '127.0.0.1', '添加一个权限：电影列表', '2019-03-01 10:41:12');
INSERT INTO `oplog` VALUES (12, 1, '127.0.0.1', '添加一个权限：电影删除', '2019-03-01 10:41:25');
INSERT INTO `oplog` VALUES (13, 1, '127.0.0.1', '添加一个权限：电影修改', '2019-03-01 10:41:38');
INSERT INTO `oplog` VALUES (14, 1, '127.0.0.1', '添加一个权限：预告添加', '2019-03-01 10:41:50');
INSERT INTO `oplog` VALUES (15, 1, '127.0.0.1', '添加一个权限：预告列表', '2019-03-01 10:42:05');
INSERT INTO `oplog` VALUES (16, 1, '127.0.0.1', '添加一个权限：预告删除', '2019-03-01 10:42:25');
INSERT INTO `oplog` VALUES (17, 1, '127.0.0.1', '添加一个权限：预告修改', '2019-03-01 10:42:39');
INSERT INTO `oplog` VALUES (18, 1, '127.0.0.1', '添加一个权限：会员列表', '2019-03-01 10:42:54');
INSERT INTO `oplog` VALUES (19, 1, '127.0.0.1', '添加一个权限：会员详情', '2019-03-01 10:43:08');
INSERT INTO `oplog` VALUES (20, 1, '127.0.0.1', '添加一个权限：会员删除', '2019-03-01 10:43:21');
INSERT INTO `oplog` VALUES (21, 1, '127.0.0.1', '添加一个权限：评论列表', '2019-03-01 10:43:34');
INSERT INTO `oplog` VALUES (22, 1, '127.0.0.1', '添加一个权限：评论删除', '2019-03-01 10:43:47');
INSERT INTO `oplog` VALUES (23, 1, '127.0.0.1', '添加一个权限：收藏列表', '2019-03-01 10:43:59');
INSERT INTO `oplog` VALUES (24, 1, '127.0.0.1', '添加一个权限：收藏删除', '2019-03-01 10:44:15');
INSERT INTO `oplog` VALUES (25, 1, '127.0.0.1', '添加一个权限：操作日志列表', '2019-03-01 10:44:30');
INSERT INTO `oplog` VALUES (26, 1, '127.0.0.1', '添加一个权限：管理员登录日志列表', '2019-03-01 10:44:54');
INSERT INTO `oplog` VALUES (27, 1, '127.0.0.1', '添加一个权限：会员登录日志列表', '2019-03-01 10:45:06');
INSERT INTO `oplog` VALUES (28, 1, '127.0.0.1', '添加一个权限：权限添加', '2019-03-01 10:45:18');
INSERT INTO `oplog` VALUES (29, 1, '127.0.0.1', '添加一个权限：权限列表', '2019-03-01 10:45:31');
INSERT INTO `oplog` VALUES (30, 1, '127.0.0.1', '添加一个权限：权限删除', '2019-03-01 10:45:50');
INSERT INTO `oplog` VALUES (31, 1, '127.0.0.1', '添加一个权限：权限修改', '2019-03-01 10:46:02');
INSERT INTO `oplog` VALUES (32, 1, '127.0.0.1', '添加一个权限：角色添加', '2019-03-01 10:46:17');
INSERT INTO `oplog` VALUES (33, 1, '127.0.0.1', '添加一个权限：角色列表', '2019-03-01 10:46:28');
INSERT INTO `oplog` VALUES (34, 1, '127.0.0.1', '添加一个权限：角色删除', '2019-03-01 10:46:44');
INSERT INTO `oplog` VALUES (35, 1, '127.0.0.1', '添加一个权限：角色修改', '2019-03-01 10:46:56');
INSERT INTO `oplog` VALUES (36, 1, '127.0.0.1', '添加一个权限：管理员添加', '2019-03-01 10:47:17');
INSERT INTO `oplog` VALUES (37, 1, '127.0.0.1', '添加一个权限：管理员列表', '2019-03-01 10:47:30');
INSERT INTO `oplog` VALUES (38, 1, '127.0.0.1', '修改一个权限：管理员操作日志列表', '2019-03-01 10:47:50');
INSERT INTO `oplog` VALUES (39, 1, '127.0.0.1', '添加一个角色：标签管理员', '2019-03-01 10:48:26');
INSERT INTO `oplog` VALUES (40, 1, '127.0.0.1', '添加一个角色：电影管理员', '2019-03-01 10:56:58');
INSERT INTO `oplog` VALUES (41, 1, '127.0.0.1', '添加一个角色：预告管理员', '2019-03-01 10:57:11');
INSERT INTO `oplog` VALUES (42, 1, '127.0.0.1', '添加一个角色：会员管理员', '2019-03-01 10:57:23');
INSERT INTO `oplog` VALUES (43, 1, '127.0.0.1', '添加一个角色：评论管理员', '2019-03-01 10:57:33');
INSERT INTO `oplog` VALUES (44, 1, '127.0.0.1', '添加一个角色：收藏管理员', '2019-03-01 10:58:04');
INSERT INTO `oplog` VALUES (45, 1, '127.0.0.1', '添加一个角色：日志管理员', '2019-03-01 10:59:05');
INSERT INTO `oplog` VALUES (46, 1, '127.0.0.1', '添加一个角色：权限管理员', '2019-03-01 10:59:20');
INSERT INTO `oplog` VALUES (47, 1, '127.0.0.1', '添加一个角色：角色管理员', '2019-03-01 10:59:45');
INSERT INTO `oplog` VALUES (48, 1, '127.0.0.1', '添加一个角色：管理员管理员', '2019-03-01 10:59:59');
INSERT INTO `oplog` VALUES (49, 1, '127.0.0.1', '修改一个角色：超级管理员', '2019-03-01 11:00:29');
INSERT INTO `oplog` VALUES (50, 1, '127.0.0.1', '添加一个标签：动画', '2019-03-01 11:11:00');
INSERT INTO `oplog` VALUES (51, 1, '127.0.0.1', '添加一个标签：动作', '2019-03-01 11:11:07');
INSERT INTO `oplog` VALUES (52, 1, '127.0.0.1', '添加一个标签：剧情', '2019-03-01 11:11:12');
INSERT INTO `oplog` VALUES (53, 1, '127.0.0.1', '添加一个标签：科幻', '2019-03-01 11:11:17');
INSERT INTO `oplog` VALUES (54, 1, '127.0.0.1', '添加一个标签：恐怖', '2019-03-01 11:11:22');
INSERT INTO `oplog` VALUES (55, 1, '127.0.0.1', '添加一个标签：奇幻', '2019-03-01 11:11:28');
INSERT INTO `oplog` VALUES (56, 1, '127.0.0.1', '添加一个标签：喜剧', '2019-03-01 11:11:32');
INSERT INTO `oplog` VALUES (57, 1, '127.0.0.1', '添加一个电影：测试', '2019-03-01 11:12:51');
INSERT INTO `oplog` VALUES (58, 1, '127.0.0.1', '修改一个电影：测试', '2019-03-01 11:21:37');
INSERT INTO `oplog` VALUES (59, 1, '127.0.0.1', '添加一个电影：测试1', '2019-03-01 11:22:37');
INSERT INTO `oplog` VALUES (60, 1, '127.0.0.1', '删除一个电影：测试1', '2019-03-01 20:40:07');
INSERT INTO `oplog` VALUES (61, 1, '127.0.0.1', '删除一个电影：测试', '2019-03-01 20:40:08');
INSERT INTO `oplog` VALUES (62, 1, '127.0.0.1', '添加一个标签：漫威', '2019-03-01 20:48:25');
INSERT INTO `oplog` VALUES (63, 1, '127.0.0.1', '添加一个标签：动画', '2019-03-01 20:59:04');
INSERT INTO `oplog` VALUES (64, 1, '127.0.0.1', '删除一个标签：动画', '2019-03-02 08:35:32');
INSERT INTO `oplog` VALUES (65, 1, '127.0.0.1', '删除一个标签：漫威', '2019-03-02 08:35:33');
INSERT INTO `oplog` VALUES (66, 1, '127.0.0.1', '添加一个标签：动画', '2019-03-02 08:39:09');
INSERT INTO `oplog` VALUES (67, 1, '127.0.0.1', '添加一个标签：动作', '2019-03-02 08:39:57');
INSERT INTO `oplog` VALUES (68, 1, '127.0.0.1', '添加一个标签：剧情', '2019-03-02 08:40:01');
INSERT INTO `oplog` VALUES (69, 1, '127.0.0.1', '添加一个标签：科幻', '2019-03-02 08:40:06');
INSERT INTO `oplog` VALUES (70, 1, '127.0.0.1', '添加一个标签：恐怖', '2019-03-02 08:40:10');
INSERT INTO `oplog` VALUES (71, 1, '127.0.0.1', '添加一个标签：奇幻', '2019-03-02 08:40:15');
INSERT INTO `oplog` VALUES (72, 1, '127.0.0.1', '添加一个标签：喜剧', '2019-03-02 08:40:19');
INSERT INTO `oplog` VALUES (73, 1, '127.0.0.1', '添加一个电影：肤色', '2019-03-02 08:50:54');
INSERT INTO `oplog` VALUES (74, 1, '127.0.0.1', '添加一个预告：惊奇队长 Captain Marvel (2019)', '2019-03-02 09:19:59');
INSERT INTO `oplog` VALUES (75, 1, '127.0.0.1', '修改一个预告：惊奇队长 Captain Marvel (2019)', '2019-03-02 09:23:58');
INSERT INTO `oplog` VALUES (76, 1, '127.0.0.1', '修改一个预告：惊奇队长 Captain Marvel (2019)', '2019-03-02 09:24:27');
INSERT INTO `oplog` VALUES (77, 1, '127.0.0.1', '修改一个预告：复仇者联盟4', '2019-03-02 09:26:45');
INSERT INTO `oplog` VALUES (78, 1, '127.0.0.1', '添加一个预告：惊奇队长 Captain Marvel (2019)', '2019-03-02 09:26:56');
INSERT INTO `oplog` VALUES (79, 1, '127.0.0.1', '修改一个预告：复仇者联盟4（2019年4月26日（美国）2019年5月2日（中国香港））', '2019-03-02 09:27:43');
INSERT INTO `oplog` VALUES (80, 1, '127.0.0.1', '修改一个预告：复仇者联盟4 Avengers Endgame  (2019)', '2019-03-02 09:29:06');
INSERT INTO `oplog` VALUES (81, 1, '127.0.0.1', '添加一个预告：蜘蛛侠：英雄远征 Spider-Man Far From Home (2019)', '2019-03-02 09:36:04');
INSERT INTO `oplog` VALUES (82, 1, '127.0.0.1', '添加一个预告：X战警:黑凤凰', '2019-03-02 09:38:17');
INSERT INTO `oplog` VALUES (83, 1, '127.0.0.1', '添加一个预告：X战警:新变种人', '2019-03-02 09:38:48');
INSERT INTO `oplog` VALUES (84, 1, '127.0.0.1', '修改一个预告：蜘蛛侠：英雄远征 Spider-Man Far From Home (2019)', '2019-03-02 09:47:31');
INSERT INTO `oplog` VALUES (85, 1, '127.0.0.1', '修改一个预告：X战警：黑凤凰 X-Men Dark Phoenix (2019)', '2019-03-02 09:49:40');
INSERT INTO `oplog` VALUES (86, 1, '127.0.0.1', '修改一个预告：星球大战9', '2019-03-02 09:50:50');
INSERT INTO `oplog` VALUES (87, 1, '127.0.0.1', '修改一个预告：星球大战9 Star Wars Episode IX (2019)', '2019-03-02 09:51:48');
INSERT INTO `oplog` VALUES (88, 1, '127.0.0.1', '修改一个预告：疾速备战 (2019)', '2019-03-02 09:55:18');
INSERT INTO `oplog` VALUES (89, 1, '127.0.0.1', '修改一个预告：疾速备战 John Wick 3 (2019)', '2019-03-02 09:56:02');
INSERT INTO `oplog` VALUES (90, 1, '123.117.11.158', '添加一个角色：gxr1', '2019-03-04 11:12:40');

-- ----------------------------
-- Table structure for preview
-- ----------------------------
DROP TABLE IF EXISTS `preview`;
CREATE TABLE `preview`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `title`(`title`) USING BTREE,
  UNIQUE INDEX `logo`(`logo`) USING BTREE,
  INDEX `ix_preview_addtime`(`addtime`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of preview
-- ----------------------------
INSERT INTO `preview` VALUES (1, '复仇者联盟4 Avengers Endgame  (2019)', '复仇者联盟4 Avengers Endgame  (2019).jpg', '2019-03-02 09:19:59');
INSERT INTO `preview` VALUES (2, '惊奇队长 Captain Marvel (2019)', '惊奇队长 Captain Marvel (2019).jpg', '2019-03-02 09:26:56');
INSERT INTO `preview` VALUES (3, '蜘蛛侠：英雄远征 Spider-Man Far From Home (2019)', '蜘蛛侠：英雄远征 Spider-Man Far From Home (2019).jpg', '2019-03-02 09:36:04');
INSERT INTO `preview` VALUES (4, '星球大战9 Star Wars Episode IX (2019)', '星球大战9 Star Wars Episode IX (2019).jpg', '2019-03-02 09:38:17');
INSERT INTO `preview` VALUES (5, '疾速备战 John Wick 3 (2019)', '疾速备战 John Wick 3 (2019).jpg', '2019-03-02 09:38:48');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `auths` varchar(600) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `ix_role_addtime`(`addtime`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '超级管理员', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32', '2019-02-28 19:24:31');
INSERT INTO `role` VALUES (2, '标签管理员', '1,2,3,4', '2019-03-01 10:48:26');
INSERT INTO `role` VALUES (3, '电影管理员', '5,6,7,8', '2019-03-01 10:56:58');
INSERT INTO `role` VALUES (4, '预告管理员', '9,10,11,12', '2019-03-01 10:57:11');
INSERT INTO `role` VALUES (5, '会员管理员', '13,14,15', '2019-03-01 10:57:23');
INSERT INTO `role` VALUES (6, '评论管理员', '16,17', '2019-03-01 10:57:33');
INSERT INTO `role` VALUES (7, '收藏管理员', '18,19', '2019-03-01 10:58:04');
INSERT INTO `role` VALUES (8, '日志管理员', '20,21,22', '2019-03-01 10:59:05');
INSERT INTO `role` VALUES (9, '权限管理员', '23,24,25,26', '2019-03-01 10:59:20');
INSERT INTO `role` VALUES (10, '角色管理员', '27,28,29,30', '2019-03-01 10:59:45');
INSERT INTO `role` VALUES (11, '管理员管理员', '31,32', '2019-03-01 10:59:59');
INSERT INTO `role` VALUES (12, '前台管理员', '1,2,3,4,5,6,7,8,9,10,11,12', '2019-03-02 11:14:50');
INSERT INTO `role` VALUES (13, '后台管理员', '13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32', '2019-03-04 11:12:39');

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `ix_tag_addtime`(`addtime`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (1, '动画', '2019-03-02 08:39:09');
INSERT INTO `tag` VALUES (2, '动作', '2019-03-02 08:39:56');
INSERT INTO `tag` VALUES (3, '剧情', '2019-03-02 08:40:01');
INSERT INTO `tag` VALUES (4, '科幻', '2019-03-02 08:40:06');
INSERT INTO `tag` VALUES (5, '恐怖', '2019-03-02 08:40:10');
INSERT INTO `tag` VALUES (6, '奇幻', '2019-03-02 08:40:15');
INSERT INTO `tag` VALUES (7, '喜剧', '2019-03-02 08:40:19');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `face` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`) USING BTREE,
  UNIQUE INDEX `face`(`face`) USING BTREE,
  UNIQUE INDEX `uuid`(`uuid`) USING BTREE,
  INDEX `ix_user_addtime`(`addtime`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'gxr', 'pbkdf2:sha256:50000$hCoVgSbQ$ef122ed9f172dae8a06b862dd6a509a9b8fcf26eada97a5fb5d35caba6edcf7e', '820685755@qq.com', '13383306337', '本站站长', '头像狗.jpg', '2019-03-01 10:33:29', 'b0df202018404f88a451827b56039d8f');
INSERT INTO `user` VALUES (2, 'gxr1', 'pbkdf2:sha256:50000$hCoVgSbQ$ef122ed9f172dae8a06b862dd6a509a9b8fcf26eada97a5fb5d35caba6edcf7e', '45534391@qq.com', '16619946646', '本站站长', '头像.jpg', '2019-03-04 11:07:26', 'b0df202018404f88a451827b56039d8d');
INSERT INTO `user` VALUES (3, 'python', 'pbkdf2:sha256:50000$EnGvT8bg$78cca0f6fafb8e1f1da907873611e88cb23ebeb0e556460e31fd5320015aa77c', '1111111@qq.com', '13671379825', '我是2蛋', '张孟卓.jpg', '2019-03-04 10:02:48', '1451bf793100460bafc2289a1d96d34c');
INSERT INTO `user` VALUES (4, 'zzd', 'pbkdf2:sha256:50000$FxoFpTe1$22fc4711c34f301369ed38c98744049ebf085dbc35ea364a74886a8a09cc8ec5', '296295159@qq.com', '13453311111', NULL, NULL, '2019-03-11 11:54:08', '2cad186db66343d08b4ca783d3adb141');

-- ----------------------------
-- Table structure for userlog
-- ----------------------------
DROP TABLE IF EXISTS `userlog`;
CREATE TABLE `userlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `ix_userlog_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `userlog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userlog
-- ----------------------------
INSERT INTO `userlog` VALUES (1, 1, '123.117.7.242', '2019-03-05 19:29:20');
INSERT INTO `userlog` VALUES (2, 4, '123.115.1.227', '2019-03-11 11:54:35');
INSERT INTO `userlog` VALUES (3, 1, '123.117.14.170', '2019-03-11 15:19:05');
INSERT INTO `userlog` VALUES (4, 1, '221.218.136.29', '2019-03-19 16:35:38');
INSERT INTO `userlog` VALUES (5, 2, '221.218.136.29', '2019-03-19 16:36:28');
INSERT INTO `userlog` VALUES (6, 1, '123.117.14.20', '2019-04-19 09:37:18');
INSERT INTO `userlog` VALUES (7, 1, '123.117.9.207', '2019-04-19 09:50:55');
INSERT INTO `userlog` VALUES (8, 1, '114.242.249.187', '2019-04-19 11:07:29');
INSERT INTO `userlog` VALUES (9, 1, '114.242.249.187', '2019-04-19 19:15:15');
INSERT INTO `userlog` VALUES (10, 1, '114.242.248.234', '2019-04-21 20:11:29');
INSERT INTO `userlog` VALUES (11, 1, '114.242.248.234', '2019-04-21 20:43:01');
INSERT INTO `userlog` VALUES (12, 1, '124.64.17.71', '2019-04-22 15:10:17');
INSERT INTO `userlog` VALUES (13, 1, '124.64.17.71', '2019-04-22 19:27:58');

SET FOREIGN_KEY_CHECKS = 1;
