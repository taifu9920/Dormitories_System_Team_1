CREATE DATABASE  IF NOT EXISTS `dormitories_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dormitories_system`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dormitories_system
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `C_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `S_ID` varchar(10) NOT NULL,
  `Content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `When` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`C_ID`),
  UNIQUE KEY `C_ID_UNIQUE` (`C_ID`),
  KEY `S_ID_idx` (`S_ID`),
  CONSTRAINT `S_ID` FOREIGN KEY (`S_ID`) REFERENCES `students` (`S_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (4,'A1095512','宿舍好棒','2022-12-27 20:56:53'),(6,'A1095512','宿舍好讚','2022-12-27 21:32:45'),(7,'A1095512','宿舍呱呱叫','2022-12-27 21:32:50'),(10,'A1095512','UwU','2022-12-28 11:41:35'),(11,'A1095512','宿舍宿舍','2022-12-28 11:45:11'),(12,'A1095512','留言板','2022-12-28 11:45:15'),(13,'A1095512','到','2022-12-28 11:45:22'),(14,'A1095512','此','2022-12-28 14:28:56'),(15,'A1095512','一','2022-12-28 14:33:29'),(16,'A1095512','遊','2022-12-28 14:33:52'),(17,'A1095512','~','2022-12-28 14:33:56'),(18,'A1095512','~','2022-12-28 14:34:00'),(19,'A1095512','~','2022-12-28 14:34:02'),(20,'A1095512','宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒','2022-12-28 14:34:05'),(21,'A1095512','宿舍好讚宿舍好讚宿舍好讚宿舍好讚宿舍好讚宿舍好讚宿舍好讚宿舍好讚宿舍好讚宿舍好讚宿舍好讚宿舍好讚','2022-12-28 14:57:40'),(22,'A1095512','宿舍好讚宿舍好讚宿舍好讚宿舍好讚宿舍好讚宿舍好讚','2022-12-28 14:57:40'),(23,'A1095512','宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍好棒宿舍宿舍好讚宿舍好讚宿舍好讚宿舍好讚宿舍好讚宿舍好讚好棒','2022-12-28 14:57:40'),(24,'A1095512','讚','2022-12-28 14:57:40'),(25,'A1095512','棒棒','2022-12-28 14:57:40'),(26,'A1095512','棉花糖','2022-12-28 14:57:40'),(27,'A1095512','吳綺講過一段耐人尋思的話，木葉蕭蕭秋氣新，江聲直下更無塵。平生來往誰能識，只有金焦是故人。這句話反映了問題的急切性。宿舍絕對是史無前例的。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。宿舍的出現，重寫了人生的意義。宿舍，發生了會如何，不發生又會如何。李區特曾講過，一個人在描述他人的個性時，其自身的個性即暴露無遺。希望大家能發現話中之話。','2022-12-28 14:57:40'),(28,'A1095512','若能夠洞悉宿舍各種層面的含義，勢必能讓思維再提高一個層級。向警予曾經提過，人生價值的大小是以人們對社會貢獻的大小而製定。帶著這句話，我們還要更加慎重的審視這個問題。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。話雖如此，我們卻也不能夠這麼篤定。就我個人來說，宿舍對我的意義，不能不說非常重大。我們普遍認為，若能理解透徹核心原理，對其就有了一定的了解程度。','2022-12-28 14:57:40'),(29,'A1095512','當前最急迫的事，想必就是釐清疑惑了。王力說過一句經典的名言，今日桑榆晚景好，共祈百歲老鴛鴦。這段話對世界的改變有著深遠的影響。屈原說過一句發人省思的話，路漫漫其修遠兮，吾將上下而求索。這似乎解答了我的疑惑。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。','2022-12-28 14:57:40'),(30,'A1095512','吳綺講過一段耐人尋思的話，木葉蕭蕭秋氣新，江聲直下更無塵。平生來往誰能識，只有金焦是故人。這句話反映了問題的急切性。宿舍絕對是史無前例的。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。宿舍的出現，重寫了人生的意義。宿舍，發生了會如何，不發生又會如何。李區特曾講過，一個人在描述他人的個性時，其自身的個性即暴露無遺。希望大家能發現話中之話。','2022-12-28 14:57:40'),(31,'A1095512','吳綺講過一段耐人尋思的話，木葉蕭蕭秋氣新，江聲直下更無塵。平生來往誰能識，只有金焦是故人。這句話反映了問題的急切性。宿舍絕對是史無前例的。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。宿舍的出現，重寫了人生的意義。宿舍，發生了會如何，不發生又會如何。李區特曾講過，一個人在描述他人的個性時，其自身的個性即暴露無遺。希望大家能發現話中之話。','2022-12-28 14:57:40'),(32,'A1095512','若能夠洞悉宿舍各種層面的含義，勢必能讓思維再提高一個層級。向警予曾經提過，人生價值的大小是以人們對社會貢獻的大小而製定。帶著這句話，我們還要更加慎重的審視這個問題。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。話雖如此，我們卻也不能夠這麼篤定。就我個人來說，宿舍對我的意義，不能不說非常重大。我們普遍認為，若能理解透徹核心原理，對其就有了一定的了解程度。','2022-12-28 14:57:40'),(33,'A1095512','當前最急迫的事，想必就是釐清疑惑了。王力說過一句經典的名言，今日桑榆晚景好，共祈百歲老鴛鴦。這段話對世界的改變有著深遠的影響。屈原說過一句發人省思的話，路漫漫其修遠兮，吾將上下而求索。這似乎解答了我的疑惑。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。','2022-12-28 14:57:40'),(34,'A1095512','需要考慮周詳宿舍的影響及因應對策。一般來講，我們都必須務必慎重的考慮考慮。俗話說的好，掌握思考過程，也就掌握了宿舍。舒爾茨告訴我們，理想如晨星——我們永不能觸到，但我們可以像航海者一樣，借星光的位置而航行。這句話語雖然很短，但令我浮想聯翩。','2022-12-28 14:57:40'),(35,'A1095512','需要考慮周詳宿舍的影響及因應對策。一般來講，我們都必須務必慎重的考慮考慮。俗話說的好，掌握思考過程，也就掌握了宿舍。舒爾茨告訴我們，理想如晨星——我們永不能觸到，但我們可以像航海者一樣，借星光的位置而航行。這句話語雖然很短，但令我浮想聯翩。','2022-12-28 14:57:40'),(36,'A1095512','需要考慮周詳宿舍的影響及因應對策。一般來講，我們都必須務必慎重的考慮考慮。俗話說的好，掌握思考過程，也就掌握了宿舍。舒爾茨告訴我們，理想如晨星——我們永不能觸到，但我們可以像航海者一樣，借星光的位置而航行。這句話語雖然很短，但令我浮想聯翩。','2022-12-28 14:57:40'),(37,'A1095512','若能夠洞悉宿舍各種層面的含義，勢必能讓思維再提高一個層級。我以為我了解宿舍，但我真的了解宿舍嗎？仔細想想，我對宿舍的理解只是皮毛而已。若沒有宿舍的存在，那麼後果可想而知。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。我們不妨可以這樣來想: 宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。','2022-12-28 14:57:40'),(38,'A1095512','若能夠洞悉宿舍各種層面的含義，勢必能讓思維再提高一個層級。我以為我了解宿舍，但我真的了解宿舍嗎？仔細想想，我對宿舍的理解只是皮毛而已。若沒有宿舍的存在，那麼後果可想而知。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。我們不妨可以這樣來想: 宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。','2022-12-28 14:57:40'),(39,'A1095512','若能夠洞悉宿舍各種層面的含義，勢必能讓思維再提高一個層級。我以為我了解宿舍，但我真的了解宿舍嗎？仔細想想，我對宿舍的理解只是皮毛而已。若沒有宿舍的存在，那麼後果可想而知。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。我們不妨可以這樣來想: 宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。','2022-12-28 14:57:40'),(40,'A1095512','若能夠洞悉宿舍各種層面的含義，勢必能讓思維再提高一個層級。我以為我了解宿舍，但我真的了解宿舍嗎？仔細想想，我對宿舍的理解只是皮毛而已。若沒有宿舍的存在，那麼後果可想而知。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。我們不妨可以這樣來想: 宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。','2022-12-28 14:57:40'),(41,'A1095512','不要先入為主覺得宿舍很複雜，實際上，宿舍可能比你想的還要更複雜。宿舍絕對是史無前例的。','2022-12-28 14:57:40'),(42,'A1095512','一般來講，我們都必須務必慎重的考慮考慮。在這種困難的抉擇下，本人思來想去，寢食難安。既然如此，宿舍的出現，重寫了人生的意義。我們都知道，只要有意義，那麼就必須慎重考慮。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。可是，即使是這樣，宿舍的出現仍然代表了一定的意義。我們可以很篤定的說，這需要花很多時間來嚴謹地論證。宿舍對我來說，已經成為了我生活的一部分。','2022-12-28 14:57:40'),(43,'A1095512','一般來講，我們都必須務必慎重的考慮考慮。在這種困難的抉擇下，本人思來想去，寢食難安。既然如此，宿舍的出現，重寫了人生的意義。我們都知道，只要有意義，那麼就必須慎重考慮。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。可是，即使是這樣，宿舍的出現仍然代表了一定的意義。我們可以很篤定的說，這需要花很多時間來嚴謹地論證。宿舍對我來說，已經成為了我生活的一部分。a','2022-12-28 14:57:40'),(44,'A1095512','把宿舍輕鬆帶過，顯然並不適合。如果別人做得到，那我也可以做到。宿舍的存在，令我無法停止對他的思考。世界上若沒有宿舍，對於人類的改變可想而知。司湯達說過一句發人省思的話，做一個傑出的人，光有一個合乎邏輯的頭腦是不夠的，人還要有一種強烈的氣質。他會這麼說是有理由的。若沒有宿舍的存在，那麼後果可想而知。宿舍勢必能夠左右未來。培根講過，子女中那種得不到遺產繼承權的幼子，常常會通過自身奮鬥獲得好的發展。而坐享其成者，卻很少能成大業。強烈建議大家把這段話牢牢記住。','2022-12-28 14:57:40'),(45,'A1095512','海伍德說過一句經典的名言，驕傲的人將有失敗之日。但願諸位理解後能從中有所成長。蔡鍔講過，沒有膽量就談不上傑出的統帥。這似乎解答了我的疑惑。謹慎地來說，我們必須考慮到所有可能。本人也是經過了深思熟慮，在每個日日夜夜思考這個問題。蘇軾說過一句富有哲理的話，崇德而定勢，行又而忘利，修修而忘名。這句話反映了問題的急切性。葛勞德說過一句很有意思的話，生活最大的危險就是一個空虛的心靈。這段話雖短，卻足以改變人類的歷史。可是，即使是這樣，宿舍的出現仍然代表了一定的意義。當前最急迫的事，想必就是釐清疑惑了。宿舍勢必能夠左右未來。','2022-12-28 14:57:40'),(46,'A1095512','經過上述討論，我認為，富蘭克林曾提出，缺少謙虛就是缺少見識。希望各位能用心體會這段話。把宿舍輕鬆帶過，顯然並不適合。所謂宿舍，關鍵是宿舍需要如何解讀。朱熹講過一句值得人反覆尋思的話，讀書之法，在循序而漸進，熟讀而精思。他會這麼說是有理由的。奧斯在不經意間這樣說過，不能光是揭露人家過去的錯誤，而不尊重人家目前的為人。這把視野帶到了全新的高度。','2022-12-28 14:57:40'),(47,'A1095512','經過上述討論，我認為，富蘭克林曾提出，缺少謙虛就是缺少見識。希望各位能用心體會這段話。把宿舍輕鬆帶過，顯然並不適合。所謂宿舍，關鍵是宿舍需要如何解讀。朱熹講過一句值得人反覆尋思的話，讀書之法，在循序而漸進，熟讀而精思。他會這麼說是有理由的。奧斯在不經意間這樣說過，不能光是揭露人家過去的錯誤，而不尊重人家目前的為人。這把視野帶到了全新的高度。','2022-12-28 14:57:40'),(48,'A1095512','我認為，帶著這些問題，我們一起來審視宿舍。我們需要淘汰舊有的觀念，寒內加說過一句經典的名言，自己奴役自己是最沉重的奴役。這段話雖短，卻足以改變人類的歷史。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。既然如此，宿舍改變了我的命運。若發現問題比我們想像的還要深奧，那肯定不簡單。對於一般人來說，宿舍究竟象徵著什麼呢？做好宿舍這件事，可以說已經成為了全民運動。','2022-12-28 14:57:40'),(49,'A1095512','如果別人做得到，那我也可以做到。可是，即使是這樣，宿舍的出現仍然代表了一定的意義。宿舍必定會成為未來世界的新標準。總而言之，對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。儘管如此，別人往往卻不這麼想。愛獻生告訴我們，鞋匠做出好鞋子，是因為他別無所。請諸位將這段話在心中默念三遍。宿舍的出現，必將帶領人類走向更高的巔峰。而這些並不是完全重要，更加重要的問題是，儘管如此，我們仍然需要對宿舍保持懷疑的態度。巴爾扎克講過，真正的科學家應當是個幻想家，誰不是幻想家，誰就只能把自己稱為實踐家。這句話看似簡單，但其中的陰鬱不禁讓人深思。卡爾講過一句值得人反覆尋思的話，榮耀地位會改','2022-12-28 14:57:40'),(50,'A1095512','逆向歸納，得以用最佳的策略去分析宿舍。華羅庚講過一段耐人尋思的話，科學是老老實實的學問，搞科學研究工作就要採取老老實實、實事求是的態度，不能有半點虛假浮誇。不知就不知，不懂就不懂，不懂的不要裝懂，而且還要追下去，不懂，不懂在什麼地方; 懂，懂在什麼地方。老老實實的態度，首先就是要紮紮實實地打好基礎。科學是踏實的學問，連貫性和系統性都很強，前面的東西沒有學好，後面的東西就上不去; 基礎沒有打好。搞尖端就比較困難。我們在工作中經常遇到一些問題解決不了，其中不少是由於基礎未打好所致。一個人在科學研究和其他工作上進步的快慢，往往和他的基礎有關。但願諸位理解後能從中有所成長。','2022-12-28 14:57:40'),(51,'A1095512','需要如何實現，不宿舍的發生，又會如何產生。宿舍，發生了會如何，不發生又會如何。宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。每個人都不得不面對這些問題。在面對這種問題時，務必詳細考慮宿舍的各種可能。透過逆向歸納，得以用最佳的策略去分析宿舍。華羅庚講過一段耐人尋思的話，科學是老老實實的學問，搞科學研究工作就要採取老老實實、實事求是的態度，不能有半點虛假浮誇。不知就不知，不懂就不懂，不懂的不要裝懂，而且還要追下去，不懂，不懂在什麼地方; 懂，懂在什麼地方。老老實實的態度，首先就是要紮紮實實地打好基礎。科學是踏實的學問，連貫性和系統性都很強，前面','2022-12-28 14:57:40'),(52,'A1095512','如果此時我們選擇忽略宿舍，那後果可想而知。老舊的想法已經過時了。回過神才發現，思考宿舍的存在意義，已讓我廢寢忘食。我們需要淘汰舊有的觀念，這樣看來，宿舍的發生，到底需要如何實現，不宿舍的發生，又會如何產生。宿舍，發生了會如何，不發生又會如何。宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。每個人都不得不面對這些問題。在面對這種問題時，務必詳細考慮宿舍的各種可能。透過逆向歸納，得以用最佳的策略去分析宿舍。華羅庚講過一段耐人尋思的話，科學是老老實實的學問，搞科學研究工作就要採取老老實實、實事求是的態度，不能有半點虛假浮誇。不知就不知，不懂就不懂，不懂的不要裝','2022-12-28 14:57:40'),(53,'A1095512','實實地打好基礎。科學是踏實的學問，連貫性和系統性都很強，前面的東西沒有學好，後面的東西就上不去; 基礎沒有打好。搞尖端就比較困難。我們在工作中經常遇到一些問題解決不了，其中不少是由於基礎未打好所致。一個人在科學研究和其他工作上進步的快慢，往往和他的','2022-12-28 14:57:40'),(54,'A1095512','去分析宿舍。華羅庚講過一段耐人尋思的話，科學是老老實實的學問，搞科學研究工作就要採取老老實實、實事求是的態度，不能有半點虛假浮誇。不知就不知，不懂就不懂，不懂的不要裝懂，而且還要追下去，不懂，不懂在什麼地方; 懂，懂在什麼地方。老老實實的態度，首先就是要','2022-12-28 14:57:40'),(55,'A1095512','如何產生。宿舍，發生了會如何，不發生又會如何。宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。每個人都不得不面對這些問題。在面對這種問','2022-12-28 14:57:40'),(122,'A1095512','吳綺講過一段耐人尋思的話，木葉蕭蕭秋氣新，江聲直下更無塵。平生來往誰能識，只有金焦是故人。這句話反映了問題的急切性。宿舍絕對是史無前例的。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。宿舍的出現，重寫了人生的意義。宿舍，發生了會如何，不發生又會如何。李區特曾講過，一個人在描述他人的個性時，其自身的個性即暴露無遺。希望大家能發現話中之話。','2022-12-28 14:57:40'),(123,'A1095512','若能夠洞悉宿舍各種層面的含義，勢必能讓思維再提高一個層級。向警予曾經提過，人生價值的大小是以人們對社會貢獻的大小而製定。帶著這句話，我們還要更加慎重的審視這個問題。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。話雖如此，我們卻也不能夠這麼篤定。就我個人來說，宿舍對我的意義，不能不說非常重大。我們普遍認為，若能理解透徹核心原理，對其就有了一定的了解程度。','2022-12-28 14:57:40'),(124,'A1095512','當前最急迫的事，想必就是釐清疑惑了。王力說過一句經典的名言，今日桑榆晚景好，共祈百歲老鴛鴦。這段話對世界的改變有著深遠的影響。屈原說過一句發人省思的話，路漫漫其修遠兮，吾將上下而求索。這似乎解答了我的疑惑。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。','2022-12-28 14:57:40'),(125,'A1095512','吳綺講過一段耐人尋思的話，木葉蕭蕭秋氣新，江聲直下更無塵。平生來往誰能識，只有金焦是故人。這句話反映了問題的急切性。宿舍絕對是史無前例的。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。宿舍的出現，重寫了人生的意義。宿舍，發生了會如何，不發生又會如何。李區特曾講過，一個人在描述他人的個性時，其自身的個性即暴露無遺。希望大家能發現話中之話。','2022-12-28 14:57:40'),(126,'A1095512','吳綺講過一段耐人尋思的話，木葉蕭蕭秋氣新，江聲直下更無塵。平生來往誰能識，只有金焦是故人。這句話反映了問題的急切性。宿舍絕對是史無前例的。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。宿舍的出現，重寫了人生的意義。宿舍，發生了會如何，不發生又會如何。李區特曾講過，一個人在描述他人的個性時，其自身的個性即暴露無遺。希望大家能發現話中之話。','2022-12-28 14:57:40'),(127,'A1095512','若能夠洞悉宿舍各種層面的含義，勢必能讓思維再提高一個層級。向警予曾經提過，人生價值的大小是以人們對社會貢獻的大小而製定。帶著這句話，我們還要更加慎重的審視這個問題。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。話雖如此，我們卻也不能夠這麼篤定。就我個人來說，宿舍對我的意義，不能不說非常重大。我們普遍認為，若能理解透徹核心原理，對其就有了一定的了解程度。','2022-12-28 14:57:40'),(128,'A1095512','當前最急迫的事，想必就是釐清疑惑了。王力說過一句經典的名言，今日桑榆晚景好，共祈百歲老鴛鴦。這段話對世界的改變有著深遠的影響。屈原說過一句發人省思的話，路漫漫其修遠兮，吾將上下而求索。這似乎解答了我的疑惑。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。','2022-12-28 14:57:40'),(129,'A1095512','需要考慮周詳宿舍的影響及因應對策。一般來講，我們都必須務必慎重的考慮考慮。俗話說的好，掌握思考過程，也就掌握了宿舍。舒爾茨告訴我們，理想如晨星——我們永不能觸到，但我們可以像航海者一樣，借星光的位置而航行。這句話語雖然很短，但令我浮想聯翩。','2022-12-28 14:57:40'),(130,'A1095512','需要考慮周詳宿舍的影響及因應對策。一般來講，我們都必須務必慎重的考慮考慮。俗話說的好，掌握思考過程，也就掌握了宿舍。舒爾茨告訴我們，理想如晨星——我們永不能觸到，但我們可以像航海者一樣，借星光的位置而航行。這句話語雖然很短，但令我浮想聯翩。','2022-12-28 14:57:40'),(131,'A1095512','需要考慮周詳宿舍的影響及因應對策。一般來講，我們都必須務必慎重的考慮考慮。俗話說的好，掌握思考過程，也就掌握了宿舍。舒爾茨告訴我們，理想如晨星——我們永不能觸到，但我們可以像航海者一樣，借星光的位置而航行。這句話語雖然很短，但令我浮想聯翩。','2022-12-28 14:57:40'),(132,'A1095512','若能夠洞悉宿舍各種層面的含義，勢必能讓思維再提高一個層級。我以為我了解宿舍，但我真的了解宿舍嗎？仔細想想，我對宿舍的理解只是皮毛而已。若沒有宿舍的存在，那麼後果可想而知。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。我們不妨可以這樣來想: 宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。','2022-12-28 14:57:40'),(133,'A1095512','若能夠洞悉宿舍各種層面的含義，勢必能讓思維再提高一個層級。我以為我了解宿舍，但我真的了解宿舍嗎？仔細想想，我對宿舍的理解只是皮毛而已。若沒有宿舍的存在，那麼後果可想而知。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。我們不妨可以這樣來想: 宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。','2022-12-28 14:57:40'),(134,'A1095512','若能夠洞悉宿舍各種層面的含義，勢必能讓思維再提高一個層級。我以為我了解宿舍，但我真的了解宿舍嗎？仔細想想，我對宿舍的理解只是皮毛而已。若沒有宿舍的存在，那麼後果可想而知。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。我們不妨可以這樣來想: 宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。','2022-12-28 14:57:40'),(135,'A1095512','若能夠洞悉宿舍各種層面的含義，勢必能讓思維再提高一個層級。我以為我了解宿舍，但我真的了解宿舍嗎？仔細想想，我對宿舍的理解只是皮毛而已。若沒有宿舍的存在，那麼後果可想而知。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。我們不妨可以這樣來想: 宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。','2022-12-28 14:57:40'),(136,'A1095512','不要先入為主覺得宿舍很複雜，實際上，宿舍可能比你想的還要更複雜。宿舍絕對是史無前例的。','2022-12-28 14:57:40'),(137,'A1095512','一般來講，我們都必須務必慎重的考慮考慮。在這種困難的抉擇下，本人思來想去，寢食難安。既然如此，宿舍的出現，重寫了人生的意義。我們都知道，只要有意義，那麼就必須慎重考慮。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。可是，即使是這樣，宿舍的出現仍然代表了一定的意義。我們可以很篤定的說，這需要花很多時間來嚴謹地論證。宿舍對我來說，已經成為了我生活的一部分。','2022-12-28 14:57:40'),(138,'A1095512','一般來講，我們都必須務必慎重的考慮考慮。在這種困難的抉擇下，本人思來想去，寢食難安。既然如此，宿舍的出現，重寫了人生的意義。我們都知道，只要有意義，那麼就必須慎重考慮。對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。可是，即使是這樣，宿舍的出現仍然代表了一定的意義。我們可以很篤定的說，這需要花很多時間來嚴謹地論證。宿舍對我來說，已經成為了我生活的一部分。a','2022-12-28 14:57:40'),(139,'A1095512','把宿舍輕鬆帶過，顯然並不適合。如果別人做得到，那我也可以做到。宿舍的存在，令我無法停止對他的思考。世界上若沒有宿舍，對於人類的改變可想而知。司湯達說過一句發人省思的話，做一個傑出的人，光有一個合乎邏輯的頭腦是不夠的，人還要有一種強烈的氣質。他會這麼說是有理由的。若沒有宿舍的存在，那麼後果可想而知。宿舍勢必能夠左右未來。培根講過，子女中那種得不到遺產繼承權的幼子，常常會通過自身奮鬥獲得好的發展。而坐享其成者，卻很少能成大業。強烈建議大家把這段話牢牢記住。','2022-12-28 14:57:40'),(140,'A1095512','海伍德說過一句經典的名言，驕傲的人將有失敗之日。但願諸位理解後能從中有所成長。蔡鍔講過，沒有膽量就談不上傑出的統帥。這似乎解答了我的疑惑。謹慎地來說，我們必須考慮到所有可能。本人也是經過了深思熟慮，在每個日日夜夜思考這個問題。蘇軾說過一句富有哲理的話，崇德而定勢，行又而忘利，修修而忘名。這句話反映了問題的急切性。葛勞德說過一句很有意思的話，生活最大的危險就是一個空虛的心靈。這段話雖短，卻足以改變人類的歷史。可是，即使是這樣，宿舍的出現仍然代表了一定的意義。當前最急迫的事，想必就是釐清疑惑了。宿舍勢必能夠左右未來。','2022-12-28 14:57:40'),(141,'A1095512','經過上述討論，我認為，富蘭克林曾提出，缺少謙虛就是缺少見識。希望各位能用心體會這段話。把宿舍輕鬆帶過，顯然並不適合。所謂宿舍，關鍵是宿舍需要如何解讀。朱熹講過一句值得人反覆尋思的話，讀書之法，在循序而漸進，熟讀而精思。他會這麼說是有理由的。奧斯在不經意間這樣說過，不能光是揭露人家過去的錯誤，而不尊重人家目前的為人。這把視野帶到了全新的高度。','2022-12-28 14:57:40'),(142,'A1095512','經過上述討論，我認為，富蘭克林曾提出，缺少謙虛就是缺少見識。希望各位能用心體會這段話。把宿舍輕鬆帶過，顯然並不適合。所謂宿舍，關鍵是宿舍需要如何解讀。朱熹講過一句值得人反覆尋思的話，讀書之法，在循序而漸進，熟讀而精思。他會這麼說是有理由的。奧斯在不經意間這樣說過，不能光是揭露人家過去的錯誤，而不尊重人家目前的為人。這把視野帶到了全新的高度。','2022-12-28 14:57:40'),(143,'A1095512','我認為，帶著這些問題，我們一起來審視宿舍。我們需要淘汰舊有的觀念，寒內加說過一句經典的名言，自己奴役自己是最沉重的奴役。這段話雖短，卻足以改變人類的歷史。問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。既然如此，宿舍改變了我的命運。若發現問題比我們想像的還要深奧，那肯定不簡單。對於一般人來說，宿舍究竟象徵著什麼呢？做好宿舍這件事，可以說已經成為了全民運動。','2022-12-28 14:57:40'),(144,'A1095512','如果別人做得到，那我也可以做到。可是，即使是這樣，宿舍的出現仍然代表了一定的意義。宿舍必定會成為未來世界的新標準。總而言之，對我個人而言，宿舍不僅僅是一個重大的事件，還可能會改變我的人生。儘管如此，別人往往卻不這麼想。愛獻生告訴我們，鞋匠做出好鞋子，是因為他別無所。請諸位將這段話在心中默念三遍。宿舍的出現，必將帶領人類走向更高的巔峰。而這些並不是完全重要，更加重要的問題是，儘管如此，我們仍然需要對宿舍保持懷疑的態度。巴爾扎克講過，真正的科學家應當是個幻想家，誰不是幻想家，誰就只能把自己稱為實踐家。這句話看似簡單，但其中的陰鬱不禁讓人深思。卡爾講過一句值得人反覆尋思的話，榮耀地位會改','2022-12-28 14:57:40'),(145,'A1095512','逆向歸納，得以用最佳的策略去分析宿舍。華羅庚講過一段耐人尋思的話，科學是老老實實的學問，搞科學研究工作就要採取老老實實、實事求是的態度，不能有半點虛假浮誇。不知就不知，不懂就不懂，不懂的不要裝懂，而且還要追下去，不懂，不懂在什麼地方; 懂，懂在什麼地方。老老實實的態度，首先就是要紮紮實實地打好基礎。科學是踏實的學問，連貫性和系統性都很強，前面的東西沒有學好，後面的東西就上不去; 基礎沒有打好。搞尖端就比較困難。我們在工作中經常遇到一些問題解決不了，其中不少是由於基礎未打好所致。一個人在科學研究和其他工作上進步的快慢，往往和他的基礎有關。但願諸位理解後能從中有所成長。','2022-12-28 14:57:40'),(146,'A1095512','需要如何實現，不宿舍的發生，又會如何產生。宿舍，發生了會如何，不發生又會如何。宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。每個人都不得不面對這些問題。在面對這種問題時，務必詳細考慮宿舍的各種可能。透過逆向歸納，得以用最佳的策略去分析宿舍。華羅庚講過一段耐人尋思的話，科學是老老實實的學問，搞科學研究工作就要採取老老實實、實事求是的態度，不能有半點虛假浮誇。不知就不知，不懂就不懂，不懂的不要裝懂，而且還要追下去，不懂，不懂在什麼地方; 懂，懂在什麼地方。老老實實的態度，首先就是要紮紮實實地打好基礎。科學是踏實的學問，連貫性和系統性都很強，前面','2022-12-28 14:57:40'),(147,'A1095512','如果此時我們選擇忽略宿舍，那後果可想而知。老舊的想法已經過時了。回過神才發現，思考宿舍的存在意義，已讓我廢寢忘食。我們需要淘汰舊有的觀念，這樣看來，宿舍的發生，到底需要如何實現，不宿舍的發生，又會如何產生。宿舍，發生了會如何，不發生又會如何。宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。每個人都不得不面對這些問題。在面對這種問題時，務必詳細考慮宿舍的各種可能。透過逆向歸納，得以用最佳的策略去分析宿舍。華羅庚講過一段耐人尋思的話，科學是老老實實的學問，搞科學研究工作就要採取老老實實、實事求是的態度，不能有半點虛假浮誇。不知就不知，不懂就不懂，不懂的不要裝','2022-12-28 14:57:40'),(148,'A1095512','實實地打好基礎。科學是踏實的學問，連貫性和系統性都很強，前面的東西沒有學好，後面的東西就上不去; 基礎沒有打好。搞尖端就比較困難。我們在工作中經常遇到一些問題解決不了，其中不少是由於基礎未打好所致。一個人在科學研究和其他工作上進步的快慢，往往和他的','2022-12-28 14:57:40'),(149,'A1095512','去分析宿舍。華羅庚講過一段耐人尋思的話，科學是老老實實的學問，搞科學研究工作就要採取老老實實、實事求是的態度，不能有半點虛假浮誇。不知就不知，不懂就不懂，不懂的不要裝懂，而且還要追下去，不懂，不懂在什麼地方; 懂，懂在什麼地方。老老實實的態度，首先就是要','2022-12-28 14:57:40'),(150,'A1095512','如何產生。宿舍，發生了會如何，不發生又會如何。宿舍似乎是一種巧合，但如果我們從一個更大的角度看待問題，這似乎是一種不可避免的事實。每個人都不得不面對這些問題。在面對這種問','2022-12-28 14:57:40'),(151,'A1095512','fdsfdhgadrhj','2022-12-28 15:13:56'),(154,'A1095512','b','2023-01-02 21:51:53'),(156,'A1095512','dfddsfg','2023-01-05 14:09:31');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configs`
--

DROP TABLE IF EXISTS `configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configs` (
  `SC_Tag` varchar(30) NOT NULL,
  `Value` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SC_Tag`),
  UNIQUE KEY `SC_Tag_UNIQUE` (`SC_Tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configs`
--

LOCK TABLES `configs` WRITE;
/*!40000 ALTER TABLE `configs` DISABLE KEYS */;
INSERT INTO `configs` VALUES ('Announcement','【公告】歡迎使用本系統，本系統仍在建置中！'),('owner_account','admin'),('owner_password','12345'),('Rules','<h2><strong>國立高雄大學住宿生活公約</strong></h2><p>一、本公約依據「國立高雄大學學生宿舍管理辦法」及「國立高雄大學學生宿舍 住宿契約」訂定，本校住宿學生，應遵守本公約。&nbsp;</p><p>二、本公約所稱宿舍區，包含宿舍交誼廳、樓(電)梯、走廊、洗衣間、寢室。</p><p>三、住宿學生違反下列規定，採違規扣點方式處理，並通知家長：</p><ol><li>違反下列情形之一者，一次扣3 點：&nbsp;<ul><li>在宿舍區內製造噪音、大聲喧譁或妨礙他人自修或睡眠者。&nbsp;</li><li>垃圾未清、未分類或妨害宿舍環境 清潔衛生者。&nbsp;</li><li>在宿舍區內飼養寵物或餵食動物者。&nbsp;</li><li>未經同意，擅自加裝寢室門鎖者。&nbsp;</li><li>未辦妥異動手續，私自更換寢室者或未經許可佔用他人床位。&nbsp;</li><li>故意損壞公物者。&nbsp;</li><li>宿舍區內吸菸者。&nbsp;</li></ul></li><li>違反下列情形之一者，一次扣5 點：<ul><li>未經同意使用或放置如電冰箱、電爐、電鍋、電暖氣、電暖氣毯或500W 以上等影響用電安全之電器者。&nbsp;</li><li>以物品阻檔宿舍出入口影響出入管制或安全者。&nbsp;</li><li>未經報備核准從事具有安全顧慮或影響宿舍安寧之活動（例如：施放 煙火炮竹、營火晚會、炊食等）。&nbsp;</li><li>非經宿舍輔導員許可，於夜間22 點至隔日早上9 點，於異性宿舍走廊、 樓(電)梯間、洗衣間、交誼廳等滯留者。&nbsp;</li><li>攜帶任何危險物品或違禁物進入宿舍者。&nbsp;</li></ul></li><li>違反下列情形之一者，一次扣7 點：<ul><li>在宿舍區賭博、酗酒、鬧事、鬥毆行為者或煽動械鬥行為者。</li><li>未經同意，提供本宿舍以外人士集會或活動，妨害宿舍安寧者。</li><li>在宿舍區飼養寵物或餵食動物，三次屢犯經查證屬實者。</li><li>非經宿舍輔導員許可，於夜間22 點至隔日早上9 點，留置非住宿生或 異性在寢室者情節輕微者。</li><li>非經宿舍輔導員許可，於夜間22 點至隔日早上9 點，在異性寢室內滯 留者情節輕微者。&nbsp;</li><li>偷竊行為經查證屬實者。</li></ul></li><li>違反下列情形之一者，一次扣10 點，立即退宿、沒收住宿押金並依學 生獎懲辦法議處：<ul><li>私自頂讓床位、佔據他人床位或空床位。</li><li>住宿區械鬥者。</li><li>住宿區吸毒或攜帶毒品者。</li><li>無故未參加住宿生防災逃生演練。</li><li>以物品或滅火器阻擋門禁。</li><li>未經全體室友同意帶異性回寢室。</li><li>進入異性寢室，未經對方全體室友同意。</li><li>異性留宿。</li></ul></li></ol><p>四、扣點、申覆說明：&nbsp;</p><ol><li>一學年內累計扣點達10 點者，必須在兩週內搬離宿舍，取消住宿申請 資格。&nbsp;</li><li>住宿學生違反有關規定之扣點，由學宿會、宿舍輔導員執行，裁決結果 有異議者，得向學務處生輔組申覆。</li><li>第3 點所列違規事項，生輔組得考量發生違規事件之動機、背景等相關 因素，經學務長核定，改以愛校服務等方式實施。</li></ol><p>五、愛校服務內容：</p><ol><li>維護宿舍環境整潔、美化宿舍有具體事實者，服務4 小時抵扣3 點。</li><li>維護宿舍秩序、公共安全有具體貢獻者，抵扣3 點。&nbsp;</li><li>積極辦理學生宿舍活動及參與宿舍公共事務者，抵扣5 點。</li><li>防止違法事件發生有具體事實者，抵扣7 點。</li><li>其他對宿舍有具體事實貢獻者，視情事給予抵扣點數。</li></ol><p>六、寢室會客相關關定：在不違返本公約下，各寢室得經所有成員協議制定寢規， 限制異性於管制時間外出入寢室；因該寢規所生之損害與責任，其責任歸 屬該寢室成員。&nbsp;</p><p>七、本公約經住宿生大會通過，並報學務處核備後實施，修正時亦同。</p><p>&nbsp;學生宿舍生活自治會關心您</p>');
/*!40000 ALTER TABLE `configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dormitories`
--

DROP TABLE IF EXISTS `dormitories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dormitories` (
  `D_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`D_ID`),
  UNIQUE KEY `D_ID_UNIQUE` (`D_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dormitories`
--

LOCK TABLES `dormitories` WRITE;
/*!40000 ALTER TABLE `dormitories` DISABLE KEYS */;
INSERT INTO `dormitories` VALUES (1,'綜合宿舍'),(2,'學生宿舍A'),(3,'學生宿舍B'),(4,'宿舍');
/*!40000 ALTER TABLE `dormitories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managers`
--

DROP TABLE IF EXISTS `managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `managers` (
  `M_ID` varchar(10) NOT NULL,
  `Name` varchar(10) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Password` varchar(50) NOT NULL,
  PRIMARY KEY (`M_ID`),
  UNIQUE KEY `M_ID_UNIQUE` (`M_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managers`
--

LOCK TABLES `managers` WRITE;
/*!40000 ALTER TABLE `managers` DISABLE KEYS */;
INSERT INTO `managers` VALUES ('M1234567','黃舍監','test@gmail.com','0901234567','aaa123'),('U1234567','林敬寶','taifu9920923@gmail.com','0908850282','a123');
/*!40000 ALTER TABLE `managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `MR_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `M_ID` varchar(10) NOT NULL,
  `D_ID` int unsigned NOT NULL,
  PRIMARY KEY (`MR_ID`),
  UNIQUE KEY `R_ID_UNIQUE` (`MR_ID`),
  KEY `M_ID_idx` (`M_ID`),
  KEY `D_ID_idx` (`D_ID`),
  CONSTRAINT `D_ID2` FOREIGN KEY (`D_ID`) REFERENCES `dormitories` (`D_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `M_ID` FOREIGN KEY (`M_ID`) REFERENCES `managers` (`M_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (47,'M1234567',2),(48,'U1234567',2),(51,'M1234567',1),(52,'U1234567',3),(53,'U1234567',4);
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registers`
--

DROP TABLE IF EXISTS `registers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registers` (
  `Reg_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `S_ID` varchar(10) NOT NULL,
  `req_D_ID` int unsigned NOT NULL,
  `Year` int unsigned NOT NULL,
  `Term` int unsigned NOT NULL,
  `When` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Approved` int unsigned NOT NULL,
  `Payment` int unsigned NOT NULL,
  PRIMARY KEY (`Reg_ID`),
  KEY `S_IDs_idx` (`S_ID`),
  KEY `D_IDs_idx` (`req_D_ID`),
  CONSTRAINT `D_IDs` FOREIGN KEY (`req_D_ID`) REFERENCES `dormitories` (`D_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `S_IDs` FOREIGN KEY (`S_ID`) REFERENCES `students` (`S_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registers`
--

LOCK TABLES `registers` WRITE;
/*!40000 ALTER TABLE `registers` DISABLE KEYS */;
INSERT INTO `registers` VALUES (17,'A1099999',2,111,1,'2023-01-07 18:45:34',1,0);
/*!40000 ALTER TABLE `registers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_contents`
--

DROP TABLE IF EXISTS `room_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_contents` (
  `RC_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `D_ID` int unsigned NOT NULL,
  `R_ID` int unsigned NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Amount` int unsigned NOT NULL,
  PRIMARY KEY (`RC_ID`,`D_ID`,`R_ID`),
  UNIQUE KEY `RC_ID_UNIQUE` (`RC_ID`),
  KEY `R_ID_idx` (`R_ID`),
  KEY `D_ID_idx` (`D_ID`),
  KEY `D_ID_idx1` (`D_ID`,`R_ID`),
  CONSTRAINT `DR_ID` FOREIGN KEY (`D_ID`, `R_ID`) REFERENCES `rooms` (`D_ID`, `R_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_contents`
--

LOCK TABLES `room_contents` WRITE;
/*!40000 ALTER TABLE `room_contents` DISABLE KEYS */;
INSERT INTO `room_contents` VALUES (7,1,101,'衣櫃',4),(8,1,101,'桌子',4),(10,1,101,'床板',4),(12,1,103,'淋浴間',2),(13,1,103,'書桌',4),(14,1,103,'衣櫃',4),(15,1,102,'牙刷',5),(16,2,102,'肥皂',3),(17,2,100,'潔牙棒',1),(18,2,101,'筆電',5),(19,3,101,'書櫃',3),(20,3,100,'面膜',3),(21,3,100,'牙刷',2),(23,2,100,'榔頭',2);
/*!40000 ALTER TABLE `room_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `D_ID` int unsigned NOT NULL,
  `R_ID` int unsigned NOT NULL,
  `Peoples` int unsigned NOT NULL,
  `Costs` int unsigned NOT NULL,
  PRIMARY KEY (`D_ID`,`R_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,101,4,2346),(1,102,4,1234),(1,103,4,1234),(2,100,2,354),(2,101,5,1234),(2,102,3,1235),(3,100,2,123),(3,101,4,1345),(4,100,2,123);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `S_ID` varchar(10) NOT NULL,
  `Name` varchar(48) NOT NULL,
  `Year` int unsigned NOT NULL,
  `Dept_Name` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Sex` tinyint unsigned NOT NULL,
  `D_ID` int unsigned DEFAULT NULL,
  `R_ID` int unsigned DEFAULT NULL,
  `Password` varchar(50) NOT NULL,
  PRIMARY KEY (`S_ID`),
  UNIQUE KEY `S_ID_UNIQUE` (`S_ID`) /*!80000 INVISIBLE */,
  KEY `D_ID_idx` (`D_ID`,`R_ID`),
  CONSTRAINT `D_ID` FOREIGN KEY (`D_ID`, `R_ID`) REFERENCES `rooms` (`D_ID`, `R_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES ('A1095512','林敬寶',109,'資訊工程系','a1095512@mail.nuk.edu.tw','0908850282',0,NULL,NULL,'a1095512'),('A1095548','陳弘恩',109,'資訊工程系','a1095548@mail.nuk.edu.tw','0912345678',0,NULL,NULL,'a1095548'),('A1099999','比爾蓋茲',109,'電腦王','bill@mail.nuk.edu.tw','0999123999',1,2,100,'bill');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `violation_records`
--

DROP TABLE IF EXISTS `violation_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `violation_records` (
  `V_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `S_ID` varchar(10) NOT NULL,
  `Content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `When` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`V_ID`),
  UNIQUE KEY `V_ID_UNIQUE` (`V_ID`),
  KEY `S_ID_idx` (`S_ID`),
  CONSTRAINT `S_ID3` FOREIGN KEY (`S_ID`) REFERENCES `students` (`S_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `violation_records`
--

LOCK TABLES `violation_records` WRITE;
/*!40000 ALTER TABLE `violation_records` DISABLE KEYS */;
INSERT INTO `violation_records` VALUES (3,'A1095548','笑太大聲','2023-01-07 18:28:12'),(4,'A1095512','吃了一個巧克力蛋糕','2023-01-07 18:29:04');
/*!40000 ALTER TABLE `violation_records` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-07 18:47:21
