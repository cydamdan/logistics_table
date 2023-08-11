/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80034 (8.0.34)
 Source Host           : localhost:3306
 Source Schema         : dining_hall

 Target Server Type    : MySQL
 Target Server Version : 80034 (8.0.34)
 File Encoding         : 65001

 Date: 22/07/2023 11:36:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for business_total
-- ----------------------------
DROP TABLE IF EXISTS `business_total`;
CREATE TABLE `business_total`  (
  `number` int NULL DEFAULT NULL COMMENT '次数',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_zh_0900_as_cs NOT NULL COMMENT '档口名',
  `totalMoney` bigint NULL DEFAULT NULL COMMENT '总额',
  `used_device` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_zh_0900_as_cs NULL DEFAULT NULL COMMENT '设备编号',
  `time` date NULL DEFAULT NULL COMMENT '日期\r\n'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_zh_0900_as_cs ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of business_total
-- ----------------------------
INSERT INTO `business_total` VALUES (150, '无穷面馆', 1501, 'test-123123', '2023-06-30');
INSERT INTO `business_total` VALUES (223, '潮客', 2200, 'test-13123', '2023-06-12');
INSERT INTO `business_total` VALUES (345, '西关云吞', 3201, 'test-12123', '2023-05-30');
INSERT INTO `business_total` VALUES (90, '云浮肠粉', 900, 'test-11123', '2023-05-20');
INSERT INTO `business_total` VALUES (400, '秦筷', 4000, 'test-1222123', '2023-06-03');

-- ----------------------------
-- Table structure for details
-- ----------------------------
DROP TABLE IF EXISTS `details`;
CREATE TABLE `details`  (
  `card_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_zh_0900_as_cs NOT NULL,
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_zh_0900_as_cs NULL DEFAULT NULL,
  `consumption_account` bigint NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  `used_device` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_zh_0900_as_cs NULL DEFAULT NULL,
  PRIMARY KEY (`card_number`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_zh_0900_as_cs ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of details
-- ----------------------------
INSERT INTO `details` VALUES ('1234-5678-9101', '王五', 100, '2023-07-21 15:30:45', 'iPad Pro');
INSERT INTO `details` VALUES ('2345-6781-2345', '李四', 250, '2023-07-21 15:01:10', 'Samsung Galaxy S21');
INSERT INTO `details` VALUES ('4521-5632-7854', '张三', 150, '2023-07-21 14:20:05', 'iPhone 12');
INSERT INTO `details` VALUES ('6789-0123-4567', '赵六', 320, '2023-07-21 16:02:50', 'MacBook Pro');
INSERT INTO `details` VALUES ('8910-2345-6789', '陈七', 500, '2023-07-21 16:45:30', 'Huawei Mate 40');

-- ----------------------------
-- Table structure for division
-- ----------------------------
DROP TABLE IF EXISTS `division`;
CREATE TABLE `division`  (
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_zh_0900_as_cs NOT NULL,
  `time` date NULL DEFAULT NULL,
  `breakfast` int NULL DEFAULT NULL,
  `lunch` int NULL DEFAULT NULL,
  `dinner` int NULL DEFAULT NULL,
  `used_device` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_zh_0900_as_cs NOT NULL,
  `sum_money` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`used_device`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_zh_0900_as_cs ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of division
-- ----------------------------
INSERT INTO `division` VALUES ('西关云吞', '2023-07-01', 100, 230, 300, 'test-111333', 630);
INSERT INTO `division` VALUES ('大众食堂', '2023-05-23', 100, 230, 300, 'test-12133', 630);
INSERT INTO `division` VALUES ('麻辣烫', '2023-06-23', 100, 230, 300, 'test-12323', 630);
INSERT INTO `division` VALUES ('潮客', '2023-07-02', 100, 230, 300, 'test-12333', 630);
INSERT INTO `division` VALUES ('无穷面馆', '2023-07-22', 100, 230, 300, 'test-14433', 630);

-- ----------------------------
-- Table structure for recharge
-- ----------------------------
DROP TABLE IF EXISTS `recharge`;
CREATE TABLE `recharge`  (
  `card_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_zh_0900_as_cs NOT NULL,
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_zh_0900_as_cs NULL DEFAULT NULL,
  `recharge_account` int NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`card_number`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_zh_0900_as_cs ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recharge
-- ----------------------------
INSERT INTO `recharge` VALUES ('1209-3456-7890', '王星', 101, '2023-07-11 12:20:30');
INSERT INTO `recharge` VALUES ('2310-5678-9012', '李月', 300, '2023-07-21 11:10:25');
INSERT INTO `recharge` VALUES ('4520-1234-5678', '张天', 200, '2023-07-01 10:15:20');
INSERT INTO `recharge` VALUES ('6781-0123-4567', '赵海', 450, '2023-07-08 01:22:35');
INSERT INTO `recharge` VALUES ('8923-2345-6789', '陈山', 220, '2023-07-30 02:25:40');

-- ----------------------------
-- Table structure for total
-- ----------------------------
DROP TABLE IF EXISTS `total`;
CREATE TABLE `total`  (
  `object` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_zh_0900_as_cs NOT NULL,
  `time` date NULL DEFAULT NULL,
  `number` int NULL DEFAULT NULL,
  `sum` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`object`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_zh_0900_as_cs ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of total
-- ----------------------------
INSERT INTO `total` VALUES ('补卡', '2023-07-13', 20, 20);
INSERT INTO `total` VALUES ('充值', '2023-07-18', 90, 9000);
INSERT INTO `total` VALUES ('发卡', '2023-07-01', 100, 200);
INSERT INTO `total` VALUES ('退卡', '2023-07-23', 600, 1200);
INSERT INTO `total` VALUES ('消费', '2023-07-18', 204, 2052);
INSERT INTO `total` VALUES ('余额', '2023-07-18', 10, 100);

SET FOREIGN_KEY_CHECKS = 1;
