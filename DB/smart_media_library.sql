# Host: 127.0.0.1  (Version 5.7.18-log)
# Date: 2018-01-23 17:35:43
# Generator: MySQL-Front 6.0  (Build 2.20)


#
# Structure for table "audio_artists"
#

DROP TABLE IF EXISTS `audio_artists`;
CREATE TABLE `audio_artists` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "audio_artists"
#

INSERT INTO `audio_artists` VALUES (2,'Disturbed');

#
# Structure for table "audio_albums"
#

DROP TABLE IF EXISTS `audio_albums`;
CREATE TABLE `audio_albums` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `artist_id` int(11) DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `audio_albums_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `audio_artists` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Data for table "audio_albums"
#

INSERT INTO `audio_albums` VALUES (3,'Believe',2),(4,'Indestructible',2),(5,'The Sickness',2);

#
# Structure for table "audio_tracks"
#

DROP TABLE IF EXISTS `audio_tracks`;
CREATE TABLE `audio_tracks` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

#
# Data for table "audio_tracks"
#

INSERT INTO `audio_tracks` VALUES (25,'Prayer'),(26,'Liberate'),(27,'Awaken'),(28,'Believe'),(29,'Remember'),(30,'Intoxication'),(31,'Rise'),(32,'Mistress'),(33,'Breathe'),(34,'Bound'),(35,'Devour'),(36,'Darkness'),(37,'mad-max.nnm.ru_Indestructible'),(38,'Inside The Fire'),(39,'Deceiver'),(40,'The Night'),(41,'Perfect Insanity'),(42,'Haunted'),(43,'Enough'),(44,'The Curse'),(45,'Torn'),(46,'Criminal'),(47,'Divide'),(48,'Facade'),(49,'Voices'),(50,'The Game'),(51,'Stupify'),(52,'Down with the Sickness'),(53,'Violence Fetish'),(54,'Fear'),(55,'Numb'),(56,'Want'),(57,'Conflict'),(58,'Shout 2000'),(59,'Droppin\' Plates'),(60,'Meaning of Life');

#
# Structure for table "audio_track2album"
#

DROP TABLE IF EXISTS `audio_track2album`;
CREATE TABLE `audio_track2album` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `album_id` int(11) DEFAULT NULL,
  `track_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `album_id` (`album_id`),
  KEY `track_id` (`track_id`),
  CONSTRAINT `audio_track2album_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `audio_albums` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `audio_track2album_ibfk_2` FOREIGN KEY (`track_id`) REFERENCES `audio_tracks` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

#
# Data for table "audio_track2album"
#

INSERT INTO `audio_track2album` VALUES (25,3,25),(26,3,26),(27,3,27),(28,3,28),(29,3,29),(30,3,30),(31,3,31),(32,3,32),(33,3,33),(34,3,34),(35,3,35),(36,3,36),(37,4,37),(38,4,38),(39,4,39),(40,4,40),(41,4,41),(42,4,42),(43,4,43),(44,4,44),(45,4,45),(46,4,46),(47,4,47),(48,4,48),(49,5,49),(50,5,50),(51,5,51),(52,5,52),(53,5,53),(54,5,54),(55,5,55),(56,5,56),(57,5,57),(58,5,58),(59,5,59),(60,5,60);
