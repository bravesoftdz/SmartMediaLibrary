# Host: 127.0.0.1  (Version 5.7.18-log)
# Date: 2018-01-31 18:01:57
# Generator: MySQL-Front 6.0  (Build 2.20)


#
# Structure for table "audio_album_types"
#

DROP TABLE IF EXISTS `audio_album_types`;
CREATE TABLE `audio_album_types` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "audio_album_types"
#

INSERT INTO `audio_album_types` VALUES (1,'studio album');

#
# Structure for table "audio_artists"
#

DROP TABLE IF EXISTS `audio_artists`;
CREATE TABLE `audio_artists` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Data for table "audio_artists"
#


#
# Structure for table "audio_albums"
#

DROP TABLE IF EXISTS `audio_albums`;
CREATE TABLE `audio_albums` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `artist_id` int(11) DEFAULT '0',
  `album_type_id` int(11) NOT NULL DEFAULT '0',
  `year` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `artist_id` (`artist_id`),
  KEY `album_type` (`album_type_id`),
  CONSTRAINT `audio_albums_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `audio_artists` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `audio_albums_ibfk_2` FOREIGN KEY (`album_type_id`) REFERENCES `audio_album_types` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

#
# Data for table "audio_albums"
#


#
# Structure for table "audio_tracks"
#

DROP TABLE IF EXISTS `audio_tracks`;
CREATE TABLE `audio_tracks` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

#
# Data for table "audio_tracks"
#


#
# Structure for table "audio_track2album"
#

DROP TABLE IF EXISTS `audio_track2album`;
CREATE TABLE `audio_track2album` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `album_id` int(11) DEFAULT NULL,
  `track_id` int(11) NOT NULL DEFAULT '0',
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `album_id` (`album_id`),
  KEY `track_id` (`track_id`),
  CONSTRAINT `audio_track2album_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `audio_albums` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `audio_track2album_ibfk_2` FOREIGN KEY (`track_id`) REFERENCES `audio_tracks` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

#
# Data for table "audio_track2album"
#

