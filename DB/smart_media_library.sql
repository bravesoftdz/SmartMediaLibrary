# Host: 127.0.0.1  (Version 5.7.18-log)
# Date: 2018-01-25 18:01:37
# Generator: MySQL-Front 6.0  (Build 2.20)


#
# Structure for table "audio_album_types"
#

DROP TABLE IF EXISTS `audio_album_types`;
CREATE TABLE `audio_album_types` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Data for table "audio_artists"
#

INSERT INTO `audio_artists` VALUES (2,'Disturbed'),(3,'Enter Shikari'),(4,'Evanescence');

#
# Structure for table "audio_albums"
#

DROP TABLE IF EXISTS `audio_albums`;
CREATE TABLE `audio_albums` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `artist_id` int(11) DEFAULT '0',
  `album_type_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `artist_id` (`artist_id`),
  KEY `album_type` (`album_type_id`),
  CONSTRAINT `audio_albums_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `audio_artists` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `audio_albums_ibfk_2` FOREIGN KEY (`album_type_id`) REFERENCES `audio_album_types` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

#
# Data for table "audio_albums"
#

INSERT INTO `audio_albums` VALUES (3,'Believe',2,1),(4,'Indestructible',2,1),(5,'The Sickness',2,1),(6,'Tribalism',3,1),(7,'Fallen',4,1);

#
# Structure for table "audio_tracks"
#

DROP TABLE IF EXISTS `audio_tracks`;
CREATE TABLE `audio_tracks` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

#
# Data for table "audio_tracks"
#

INSERT INTO `audio_tracks` VALUES (25,'Prayer'),(26,'Liberate'),(27,'Awaken'),(28,'Believe'),(29,'Remember'),(30,'Intoxication'),(31,'Rise'),(32,'Mistress'),(33,'Breathe'),(34,'Bound'),(35,'Devour'),(36,'Darkness'),(37,'mad-max.nnm.ru_Indestructible'),(38,'Inside The Fire'),(39,'Deceiver'),(40,'The Night'),(41,'Perfect Insanity'),(42,'Haunted'),(43,'Enough'),(44,'The Curse'),(45,'Torn'),(46,'Criminal'),(47,'Divide'),(48,'Facade'),(49,'Voices'),(50,'The Game'),(51,'Stupify'),(52,'Down with the Sickness'),(53,'Violence Fetish'),(54,'Fear'),(55,'Numb'),(56,'Want'),(57,'Conflict'),(58,'Shout 2000'),(59,'Droppin\' Plates'),(60,'Meaning of Life'),(61,'Tribalism'),(62,'Thumper'),(63,'All Eyes On The Saint'),(64,'We Can Breathe In Space'),(65,'Insomnia (Live @ Brixton \'07)'),(66,'Juggernauts (Nero Remix)'),(67,'No Sleep Tonight (The Qemists Remix)'),(68,'Wall (High Contrast Remix)'),(69,'No Sleep Tonight (Mistabishi Remix)'),(70,'Juggernauts (Blue Bear\'s True Tiger Remix)'),(71,'No Sleep Tonight (Rout Remix)'),(72,'No Sleep Tonight (LightsGoBlue Remix)'),(73,'Havoc A (Live \'09)'),(74,'Labyrinth (Live \'09)'),(75,'Hectic (Live \'09)'),(76,'Going Under'),(77,'Bring Me To Life'),(78,'Everybody\'s Fool'),(79,'My Immortal'),(80,'Haunted'),(81,'Tourniquet'),(82,'Imaginary'),(83,'Taking Over Me'),(84,'Hello'),(85,'My Last Breath'),(86,'Whisper');

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

INSERT INTO `audio_track2album` VALUES (25,3,25,NULL),(26,3,26,NULL),(27,3,27,NULL),(28,3,28,NULL),(29,3,29,NULL),(30,3,30,NULL),(31,3,31,NULL),(32,3,32,NULL),(33,3,33,NULL),(34,3,34,NULL),(35,3,35,NULL),(36,3,36,NULL),(37,4,37,NULL),(38,4,38,NULL),(39,4,39,NULL),(40,4,40,NULL),(41,4,41,NULL),(42,4,42,NULL),(43,4,43,NULL),(44,4,44,NULL),(45,4,45,NULL),(46,4,46,NULL),(47,4,47,NULL),(48,4,48,NULL),(49,5,49,NULL),(50,5,50,NULL),(51,5,51,NULL),(52,5,52,NULL),(53,5,53,NULL),(54,5,54,NULL),(55,5,55,NULL),(56,5,56,NULL),(57,5,57,NULL),(58,5,58,NULL),(59,5,59,NULL),(60,5,60,NULL),(61,6,61,NULL),(62,6,62,NULL),(63,6,63,NULL),(64,6,64,NULL),(65,6,65,NULL),(66,6,66,NULL),(67,6,67,NULL),(68,6,68,NULL),(69,6,69,NULL),(70,6,70,NULL),(71,6,71,NULL),(72,6,72,NULL),(73,6,73,NULL),(74,6,74,NULL),(75,6,75,NULL),(76,7,76,NULL),(77,7,77,NULL),(78,7,78,NULL),(79,7,79,NULL),(80,7,80,NULL),(81,7,81,NULL),(82,7,82,NULL),(83,7,83,NULL),(84,7,84,NULL),(85,7,85,NULL),(86,7,86,NULL);
