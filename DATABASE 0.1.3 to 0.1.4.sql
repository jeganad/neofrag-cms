INSERT INTO `nf_settings_addons` VALUES('addons', 'module', '1');
INSERT INTO `nf_settings_addons` VALUES('error', 'widget', '1');
ALTER TABLE `nf_settings_addons` CHANGE `enable` `is_enabled` ENUM('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0';
ALTER TABLE `nf_users` DROP `theme`;
ALTER TABLE `nf_settings_languages` DROP COLUMN `language_id`, DROP COLUMN `domain_extension`, DROP INDEX `code`, DROP PRIMARY KEY, ADD PRIMARY KEY (`code`);
INSERT INTO `nf_settings_addons` VALUES('search', 'widget', '1');
ALTER TABLE `nf_users_messages` DROP FOREIGN KEY `nf_users_messages_ibfk_1`;
ALTER TABLE `nf_users_messages` CHANGE `user_id` `reply_id` INT(11) UNSIGNED NOT NULL;
ALTER TABLE `nf_users_messages` ADD `last_reply_id` INT UNSIGNED DEFAULT NULL AFTER `title`, ADD INDEX (`last_reply_id`);
ALTER TABLE `nf_users_messages` ADD FOREIGN KEY (`reply_id`) REFERENCES `nf_users_messages_replies`(`reply_id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `nf_users_messages` ADD FOREIGN KEY (`last_reply_id`) REFERENCES `nf_users_messages_replies`(`reply_id`) ON DELETE SET NULL ON UPDATE SET NULL;
ALTER TABLE `nf_users_messages` DROP `content`, DROP `date`;
ALTER TABLE `nf_users_messages_recipients` DROP `read`;
ALTER TABLE `nf_users_messages_recipients` ADD `date` TIMESTAMP NULL DEFAULT NULL AFTER `message_id`;
ALTER TABLE `nf_users_messages_recipients` ADD `deleted` ENUM('0','1') NOT NULL DEFAULT '0' AFTER `date`;
ALTER TABLE `nf_users_messages_replies` CHANGE `content` `message` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `nf_users_messages_replies` DROP `read`;
DROP TABLE IF EXISTS `nf_awards`;
CREATE TABLE IF NOT EXISTS `nf_awards` (
  `award_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `team_id` int(11) UNSIGNED DEFAULT NULL,
  `game_id` int(11) UNSIGNED NOT NULL,
  `image_id` int(11) UNSIGNED DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `description` text NOT NULL,
  `platform` varchar(100) NOT NULL,
  `ranking` int(11) UNSIGNED NOT NULL,
  `participants` int(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`award_id`),
  KEY `image_id` (`image_id`),
  KEY `game_id` (`game_id`),
  KEY `team_id` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `nf_settings_addons` VALUES('awards', 'module', '1');
INSERT INTO `nf_settings_addons` VALUES('awards', 'widget', '1');
ALTER TABLE `nf_awards`
  ADD CONSTRAINT `nf_awards_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `nf_teams` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nf_awards_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `nf_games` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nf_awards_ibfk_3` FOREIGN KEY (`image_id`) REFERENCES `nf_files` (`file_id`) ON DELETE CASCADE ON UPDATE CASCADE;
