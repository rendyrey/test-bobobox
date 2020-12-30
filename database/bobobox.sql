SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hotel
-- ----------------------------
DROP TABLE IF EXISTS `hotel`;
CREATE TABLE `hotel`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hotel
-- ----------------------------
INSERT INTO `hotel` VALUES (1, 'Grand Paradise', 'Lembang');
INSERT INTO `hotel` VALUES (2, 'FaveHotel', 'Paskal');
INSERT INTO `hotel` VALUES (3, 'Grand Aquila', 'Pasteur');
INSERT INTO `hotel` VALUES (4, 'Bobobox', 'Dago');
INSERT INTO `hotel` VALUES (5, 'Trans Luxury Hotel', 'Buah Batu');

-- ----------------------------
-- Table structure for price
-- ----------------------------
DROP TABLE IF EXISTS `price`;
CREATE TABLE `price`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NULL DEFAULT NULL,
  `room_type_id` int(11) NULL DEFAULT NULL,
  `price` decimal(11, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `priceroomtype`(`room_type_id`) USING BTREE,
  CONSTRAINT `priceroomtype` FOREIGN KEY (`room_type_id`) REFERENCES `roomtype` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of price
-- ----------------------------
INSERT INTO `price` VALUES (1, '2020-01-10', 1, 100000.00);
INSERT INTO `price` VALUES (2, '2020-01-10', 2, 200000.00);
INSERT INTO `price` VALUES (3, '2020-01-10', 3, 300000.00);
INSERT INTO `price` VALUES (4, '2020-01-10', 4, 400000.00);
INSERT INTO `price` VALUES (5, '2020-01-10', 5, 500000.00);
INSERT INTO `price` VALUES (6, '2020-01-11', 1, 150000.00);
INSERT INTO `price` VALUES (7, '2020-01-11', 2, 250000.00);
INSERT INTO `price` VALUES (8, '2020-01-11', 3, 350000.00);
INSERT INTO `price` VALUES (9, '2020-01-11', 4, 450000.00);
INSERT INTO `price` VALUES (10, '2020-01-11', 5, 550000.00);
INSERT INTO `price` VALUES (11, '2020-01-12', 1, 125000.00);
INSERT INTO `price` VALUES (12, '2020-01-12', 2, 225000.00);
INSERT INTO `price` VALUES (13, '2020-01-12', 3, 3250000.00);
INSERT INTO `price` VALUES (14, '2020-01-12', 4, 425000.00);
INSERT INTO `price` VALUES (15, '2020-01-12', 5, 525000.00);
INSERT INTO `price` VALUES (16, '2020-01-13', 1, 100000.00);
INSERT INTO `price` VALUES (17, '2020-01-13', 2, 200000.00);
INSERT INTO `price` VALUES (18, '2020-01-13', 3, 300000.00);
INSERT INTO `price` VALUES (19, '2020-01-13', 4, 400000.00);
INSERT INTO `price` VALUES (20, '2020-01-13', 5, 500000.00);
INSERT INTO `price` VALUES (21, '2020-01-14', 1, 100000.00);
INSERT INTO `price` VALUES (22, '2020-01-14', 2, 200000.00);
INSERT INTO `price` VALUES (23, '2020-01-14', 3, 300000.00);
INSERT INTO `price` VALUES (24, '2020-01-14', 4, 400000.00);
INSERT INTO `price` VALUES (25, '2020-01-14', 5, 500000.00);
INSERT INTO `price` VALUES (26, '2020-01-15', 1, 100000.00);
INSERT INTO `price` VALUES (27, '2020-01-15', 2, 200000.00);
INSERT INTO `price` VALUES (28, '2020-01-15', 3, 300000.00);
INSERT INTO `price` VALUES (29, '2020-01-15', 4, 400000.00);
INSERT INTO `price` VALUES (30, '2020-01-15', 5, 500000.00);
INSERT INTO `price` VALUES (31, '2020-01-16', 1, 100000.00);
INSERT INTO `price` VALUES (32, '2020-01-16', 2, 200000.00);
INSERT INTO `price` VALUES (33, '2020-01-16', 3, 300000.00);
INSERT INTO `price` VALUES (34, '2020-01-16', 4, 400000.00);
INSERT INTO `price` VALUES (35, '2020-01-16', 5, 500000.00);
INSERT INTO `price` VALUES (36, '2020-01-17', 1, 100000.00);
INSERT INTO `price` VALUES (37, '2020-01-17', 2, 200000.00);
INSERT INTO `price` VALUES (38, '2020-01-17', 3, 300000.00);
INSERT INTO `price` VALUES (39, '2020-01-17', 4, 400000.00);
INSERT INTO `price` VALUES (40, '2020-01-17', 5, 500000.00);
INSERT INTO `price` VALUES (41, '2020-01-18', 1, 150000.00);
INSERT INTO `price` VALUES (42, '2020-01-18', 2, 250000.00);
INSERT INTO `price` VALUES (43, '2020-01-18', 3, 350000.00);
INSERT INTO `price` VALUES (44, '2020-01-18', 4, 450000.00);
INSERT INTO `price` VALUES (45, '2020-01-18', 5, 550000.00);
INSERT INTO `price` VALUES (46, '2020-01-19', 1, 125000.00);
INSERT INTO `price` VALUES (47, '2020-01-19', 2, 225000.00);
INSERT INTO `price` VALUES (48, '2020-01-19', 3, 325000.00);
INSERT INTO `price` VALUES (49, '2020-01-19', 4, 425000.00);
INSERT INTO `price` VALUES (50, '2020-01-19', 5, 525000.00);
INSERT INTO `price` VALUES (51, '2020-01-20', 1, 100000.00);
INSERT INTO `price` VALUES (52, '2020-01-20', 2, 200000.00);
INSERT INTO `price` VALUES (53, '2020-01-20', 3, 300000.00);
INSERT INTO `price` VALUES (54, '2020-01-20', 4, 400000.00);
INSERT INTO `price` VALUES (55, '2020-01-20', 5, 500000.00);

-- ----------------------------
-- Table structure for promo
-- ----------------------------
DROP TABLE IF EXISTS `promo`;
CREATE TABLE `promo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `promo_amount` double(11, 2) NOT NULL,
  `is_percentage` tinyint(1) NOT NULL,
  `promo_quota` int(11) NOT NULL,
  `start_date` datetime(0) NULL DEFAULT NULL,
  `end_date` datetime(0) NULL DEFAULT NULL,
  `quota_remaining` int(11) NOT NULL,
  `daily_quota` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promo
-- ----------------------------
INSERT INTO `promo` VALUES (1, 30000.00, 0, 50, '2020-12-20 01:30:00', '2021-01-30 23:59:00', 50, 1);
INSERT INTO `promo` VALUES (2, 50000.00, 0, 100, '2020-12-20 00:01:00', '2021-01-30 22:00:00', 100, 2);
INSERT INTO `promo` VALUES (3, 20.00, 1, 150, '2020-12-20 00:01:00', '2021-01-30 22:00:00', 0, 0);

-- ----------------------------
-- Table structure for promo_rules
-- ----------------------------
DROP TABLE IF EXISTS `promo_rules`;
CREATE TABLE `promo_rules`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `promo_id` int(11) NOT NULL,
  `minimum_nights` int(11) NOT NULL,
  `minimum_room` int(11) NOT NULL,
  `checkin_day` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `booking_day` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `booking_hour_start` time(0) NOT NULL,
  `booking_hour_end` time(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `promo_rules_promo`(`promo_id`) USING BTREE,
  CONSTRAINT `promo_rules_promo` FOREIGN KEY (`promo_id`) REFERENCES `promo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promo_rules
-- ----------------------------
INSERT INTO `promo_rules` VALUES (1, 1, 1, 1, 'Wednesday', 'Wednesday', '13:30:00', '23:59:59');
INSERT INTO `promo_rules` VALUES (5, 2, 1, 1, 'Wednesday', 'Wednesday', '00:00:00', '23:59:59');
INSERT INTO `promo_rules` VALUES (6, 3, 1, 1, 'Thursday', 'Thursday', '00:00:00', '23:59:59');

-- ----------------------------
-- Table structure for reservation
-- ----------------------------
DROP TABLE IF EXISTS `reservation`;
CREATE TABLE `reservation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `booked_room_count` int(11) NULL DEFAULT NULL,
  `checkin_date` datetime(0) NULL DEFAULT NULL,
  `checkout_date` datetime(0) NULL DEFAULT NULL,
  `hotel_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reservation
-- ----------------------------
INSERT INTO `reservation` VALUES (1, 'ABC1', 'Rendy 1', 1, '2020-01-10 00:00:00', '2020-01-11 00:00:00', 1);
INSERT INTO `reservation` VALUES (2, 'ABC2', 'Rendy 2', 1, '2020-01-10 00:00:00', '2020-01-12 00:00:00', 2);
INSERT INTO `reservation` VALUES (3, 'ABC3', 'Rendy 3', 1, '2020-01-12 00:00:00', '2020-01-14 00:00:00', 2);

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NULL DEFAULT NULL,
  `room_type_id` int(11) NULL DEFAULT NULL,
  `room_number` int(11) NULL DEFAULT NULL,
  `room_status` enum('available','out of service') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `hotel`(`hotel_id`) USING BTREE,
  INDEX `roomtype`(`room_type_id`) USING BTREE,
  CONSTRAINT `hotel` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `roomtype` FOREIGN KEY (`room_type_id`) REFERENCES `roomtype` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (1, 1, 1, 101, 'available');
INSERT INTO `room` VALUES (2, 1, 1, 102, 'available');
INSERT INTO `room` VALUES (3, 1, 1, 103, 'available');
INSERT INTO `room` VALUES (4, 1, 2, 104, 'available');
INSERT INTO `room` VALUES (5, 1, 2, 105, 'available');
INSERT INTO `room` VALUES (6, 1, 2, 106, 'available');
INSERT INTO `room` VALUES (7, 2, 1, 101, 'available');
INSERT INTO `room` VALUES (8, 2, 1, 102, 'available');
INSERT INTO `room` VALUES (9, 2, 1, 103, 'available');
INSERT INTO `room` VALUES (10, 2, 2, 104, 'available');
INSERT INTO `room` VALUES (11, 2, 2, 105, 'available');
INSERT INTO `room` VALUES (12, 2, 2, 106, 'available');
INSERT INTO `room` VALUES (13, 3, 1, 101, 'available');
INSERT INTO `room` VALUES (14, 3, 1, 102, 'available');
INSERT INTO `room` VALUES (15, 3, 1, 103, 'available');
INSERT INTO `room` VALUES (16, 3, 2, 104, 'available');
INSERT INTO `room` VALUES (17, 3, 2, 105, 'available');
INSERT INTO `room` VALUES (18, 3, 2, 106, 'available');
INSERT INTO `room` VALUES (19, 4, 1, 101, 'available');
INSERT INTO `room` VALUES (20, 4, 1, 102, 'available');
INSERT INTO `room` VALUES (21, 4, 1, 103, 'available');
INSERT INTO `room` VALUES (22, 4, 2, 104, 'available');
INSERT INTO `room` VALUES (23, 4, 2, 105, 'available');
INSERT INTO `room` VALUES (24, 4, 2, 106, 'available');

-- ----------------------------
-- Table structure for roomtype
-- ----------------------------
DROP TABLE IF EXISTS `roomtype`;
CREATE TABLE `roomtype`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomtype
-- ----------------------------
INSERT INTO `roomtype` VALUES (1, 'Regular');
INSERT INTO `roomtype` VALUES (2, 'Premium');
INSERT INTO `roomtype` VALUES (3, 'Business');
INSERT INTO `roomtype` VALUES (4, 'Luxury');
INSERT INTO `roomtype` VALUES (5, 'Super Luxury');

-- ----------------------------
-- Table structure for stay
-- ----------------------------
DROP TABLE IF EXISTS `stay`;
CREATE TABLE `stay`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reservation_id` int(11) NULL DEFAULT NULL,
  `guest_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `room_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `stayreservation`(`reservation_id`) USING BTREE,
  INDEX `stayroom`(`room_id`) USING BTREE,
  CONSTRAINT `stayreservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stayroom` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stay
-- ----------------------------
INSERT INTO `stay` VALUES (1, 1, 'Rendy 1', 1);
INSERT INTO `stay` VALUES (2, 2, 'Rendy 2', 3);

-- ----------------------------
-- Table structure for stayroom
-- ----------------------------
DROP TABLE IF EXISTS `stayroom`;
CREATE TABLE `stayroom`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stay_id` int(11) NULL DEFAULT NULL,
  `room_id` int(11) NULL DEFAULT NULL,
  `date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `stayroomstay`(`stay_id`) USING BTREE,
  INDEX `stayroomroom`(`room_id`) USING BTREE,
  CONSTRAINT `stayroomroom` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stayroomstay` FOREIGN KEY (`stay_id`) REFERENCES `stay` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stayroom
-- ----------------------------
INSERT INTO `stayroom` VALUES (1, 1, 1, '2020-01-10');
INSERT INTO `stayroom` VALUES (2, 2, 2, '2020-01-12');

SET FOREIGN_KEY_CHECKS = 1;
