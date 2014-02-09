-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 09, 2014 at 07:03 AM
-- Server version: 5.6.14
-- PHP Version: 5.5.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `credit_suisse`
--

-- --------------------------------------------------------

--
-- Table structure for table `approved_status`
--

CREATE TABLE IF NOT EXISTS `approved_status` (
  `r_id` int(10) unsigned NOT NULL,
  `app_status` tinyint(1) NOT NULL,
  `u_id` int(10) unsigned NOT NULL,
  KEY `r_id` (`r_id`),
  KEY `u_id` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `approve_user`
--

CREATE TABLE IF NOT EXISTS `approve_user` (
  `approve_id` tinyint(1) unsigned NOT NULL,
  `app_stat` varchar(30) NOT NULL,
  PRIMARY KEY (`approve_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `approve_user`
--

INSERT INTO `approve_user` (`approve_id`, `app_stat`) VALUES
(0, 'New User'),
(1, 'Approved User'),
(2, 'Blocked User'),
(3, 'Rejected New User');

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `discussion_id` int(11) NOT NULL,
  `insert_uid` int(11) unsigned NOT NULL,
  `date_inserted_c` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delete_uid` int(11) unsigned DEFAULT NULL,
  `date_deleted_c` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_uid` int(11) unsigned DEFAULT NULL,
  `date_updated_c` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_body` text NOT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT '0',
  `comment_score` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `insert_uid` (`insert_uid`),
  KEY `delete_uid` (`delete_uid`),
  KEY `update_uid` (`update_uid`),
  KEY `discussion_id` (`discussion_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`comment_id`, `discussion_id`, `insert_uid`, `date_inserted_c`, `delete_uid`, `date_deleted_c`, `update_uid`, `date_updated_c`, `comment_body`, `flag`, `comment_score`) VALUES
(2, 2, 8, '2014-01-19 06:40:07', NULL, '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', 'You should try the official GitHub for windows or git bash.', 0, 2),
(5, 4, 5, '2014-01-30 11:31:44', NULL, '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', ' lol!', 0, 0),
(7, 8, 5, '2014-01-30 12:02:25', NULL, '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', ' temp comment to test redirection!', 0, 0),
(9, 10, 12, '2014-01-31 08:55:16', NULL, '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', ' hmmm...looks like it is being updated. now testing if the comment count is being updated or not...', 0, 0),
(10, 3, 5, '2014-02-09 06:02:50', NULL, '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', ' this comment is to check whether adding comment updates the discussion update time or not..', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE IF NOT EXISTS `course` (
  `c_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `c_name` varchar(50) NOT NULL,
  `c_stream` varchar(20) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `avg_rating` double NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`c_id`, `c_name`, `c_stream`, `start_date`, `end_date`, `avg_rating`, `description`) VALUES
(18, 'cs50', 'CS', '2014-01-01', '2014-03-01', 0, 'This is CS50!'),
(19, 'NewNet', 'IT', '2014-05-01', '0000-00-00', 0, ''),
(20, 'Crypto', 'CS', '2014-01-22', '2014-07-17', 0, 'this is crypto'),
(21, 'new', 'new', '2014-01-03', '2014-01-17', 0, ''),
(22, 'newcourse', 'cs', '2014-01-16', '2014-01-18', 0, 'Description!');

-- --------------------------------------------------------

--
-- Table structure for table `create_course`
--

CREATE TABLE IF NOT EXISTS `create_course` (
  `u_id` int(11) unsigned NOT NULL,
  `c_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`c_id`),
  UNIQUE KEY `c_id` (`c_id`),
  KEY `u_id_2` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `create_course`
--

INSERT INTO `create_course` (`u_id`, `c_id`) VALUES
(2, 18),
(2, 19),
(2, 20),
(2, 21),
(2, 22);

-- --------------------------------------------------------

--
-- Table structure for table `discussion`
--

CREATE TABLE IF NOT EXISTS `discussion` (
  `discussion_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0',
  `category_id` int(11) NOT NULL,
  `insert_uid` int(11) unsigned NOT NULL,
  `last_comment_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL,
  `disc_body` text NOT NULL,
  `count_comments` int(11) NOT NULL DEFAULT '0',
  `date_inserted_d` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated_d` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rating` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`discussion_id`),
  KEY `category_id` (`category_id`),
  KEY `last_comment_id` (`last_comment_id`),
  KEY `insert_uid` (`insert_uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `discussion`
--

INSERT INTO `discussion` (`discussion_id`, `type`, `category_id`, `insert_uid`, `last_comment_id`, `name`, `disc_body`, `count_comments`, `date_inserted_d`, `date_updated_d`, `rating`) VALUES
(2, 0, 1, 5, 0, 'Github installation fails on windows', 'I tried installing git hub about 3 months ago, and then again today. It''s the same error i get while installation saying git hub setup corrupt. Here is the link i try to download from. And it fails at 30.00 MB download ( out of total 47 MB). ', 1, '2014-01-19 04:13:19', '0000-00-00 00:00:00', 6),
(3, 0, 1, 8, 0, 'how to prevent from reloading a new page in MVC 4', 'I keep looking around to find a solution but it seems impossible to find the one. Well I am a newbie to MVC 4.\r\n\r\nI make textboxes invisible via css in @Html.BeginForm(....) and then I wrote jquery to show textbox when selecting a one from the dropdownlist. It is working fine. When input value in this textbox then click the submit button and the value will pass to a parameter of a method which is working BUT the textbox is invisible again after clicking. I bet it is reloading a new page so the textbox is gone and you must select it on dropdownlist again to make the textbox visible. I dont want this. I want the textbox to remain after clicking. How to solve this problem?\r\n\r\nI am not sure what causes problem. Is that because of reloading new page? Or my code in jquery is not right? I am lost. Please help!! Your code tip is much appreciated. ', 1, '2014-01-19 04:38:46', '2014-02-09 06:02:50', 2),
(4, 0, 2, 5, 0, 'Executing Async tasks in fragments', 'I am attempting to execute an async task in a fragment after converting my activities into fragments. When I call my async task from the activity I have to pass ''this'' with it in order to allow the async task to change text and things after it receives the information. I am a bit confused on how to do this all with fragments. Here is what I got so far:\r\n\r\nI execute the asynck task with:\r\nMy problem is that I can not pass ''this'' from a fragment...\r\n\r\nBonus Question:\r\n\r\nAlso as you can see I am not done converting my code for the fragments. I need to change this to load a fragment instead of change activity:', 1, '2014-01-19 04:42:45', '0000-00-00 00:00:00', -1),
(8, 0, 1, 5, 0, 'Creating multiple dynamic drop down using databases in php', 'hey guys i was developing a small project for my college and this consists of a table that a prizeid, prizename from a table called prizemaster and names of candidates that can be nominated by staffs from a table called studentmaster. \r\nthe table was successfully created but there seems to a problem. in my first record the drop down is fine but in all other records the drop down is empty. how to i solve this? can anyone explain clearly with code as am new to php.', 1, '2014-01-30 09:12:29', '0000-00-00 00:00:00', 0),
(9, 0, 1, 5, 0, 'Hot swap Node.js files while debugging in Webstorm 7.0.3', 'I''m getting starting with Node.js and Webstorm 7.0.3. I have created a simple Node.js app with express and I run it locally. I want to edit and save a .js file, refresh the broswer, and see the changes. As I understand it, this should pretty much work out-of-the box.\r\n\r\nHere is what does work:\r\n\r\n    I start the Node.js server\r\n    I navigate to an express path with Chrome\r\n    The page renders correctly.\r\n\r\nHere is what doesn''t work:\r\n\r\n    I change the JavaScript function that renders the page\r\n    I save the file\r\n    I refresh the browser\r\n    The Web page does not reflect the changes to the JavaScript function\r\n\r\nHere are the directions I followed from the JetBrains help site:\r\n\r\n    Create a Node.js run/debug configuration called "app.js"\r\n        Check the "After launch" and "with Javascript debugger" options\r\n    Create a JavaScript Debug configuration called "app.js.JavaScript\r\n    Select "Debug" for the "app.js" configuration.\r\n    The Node.js server starts\r\n    Select "Debug" for the "app.js.JavaScript.\r\n    I can now hit breakpoints in the application.\r\n\r\nHowever, if I change the JS function that renders the page, save the file, and refresh the browser, the changes do not appear.', 0, '2014-01-30 11:58:56', '0000-00-00 00:00:00', 0),
(10, 0, 1, 12, 0, 'I''m getting starting with Node.js and Webstorm 7.0.3', 'I am trying to create a sort of parallax effect, I what the section after "ABOUT" containing two different div with image to scroll faster than the rest of the page. I want that whole div to scroll faster so that it looks like the first drawn picture is being wiped up but the similar picture.\r\n\r\nTest site: http://www.onepixelroom.com/AQUODI/ (the section just after "ABOUT")\r\n\r\nExample, scroll down (a lot, yes, it''s annoying :) this site to see the footballer guys change color, I want to do this with both my images: http://www.tridentpp.com/', 1, '2014-01-31 08:54:19', '0000-00-00 00:00:00', 0),
(11, 0, 1, 5, 0, 'this is sixth discussion', ' This is to see whether paginations happens or not', 0, '2014-02-09 05:11:40', '0000-00-00 00:00:00', 0),
(12, 0, 1, 5, 0, 'This is seventh discussion', 'Again the same purpose ', 0, '2014-02-09 05:12:00', '0000-00-00 00:00:00', 0),
(13, 0, 1, 5, 0, 'Eighth now!', '2 more remaining or maybe 3 ', 0, '2014-02-09 05:12:21', '0000-00-00 00:00:00', 0),
(14, 0, 1, 5, 0, 'ninth discussion', 'discussion body for namesake ', 0, '2014-02-09 05:25:27', '0000-00-00 00:00:00', 0),
(15, 0, 1, 5, 0, 'tenth discussion', 'this should be the last of the page ', 0, '2014-02-09 05:26:01', '0000-00-00 00:00:00', 0),
(16, 0, 1, 5, 0, 'eleventh', 'this should be on second page ', 0, '2014-02-09 05:26:24', '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `discussion_category`
--

CREATE TABLE IF NOT EXISTS `discussion_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` text NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `discussion_category`
--

INSERT INTO `discussion_category` (`category_id`, `category_name`) VALUES
(1, 'General'),
(2, 'Doubts');

-- --------------------------------------------------------

--
-- Table structure for table `enroll_course`
--

CREATE TABLE IF NOT EXISTS `enroll_course` (
  `u_id` int(10) unsigned NOT NULL,
  `c_id` int(10) unsigned NOT NULL,
  `completion_stat` tinyint(1) NOT NULL,
  KEY `c_id` (`c_id`),
  KEY `u_id` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `enroll_course`
--

INSERT INTO `enroll_course` (`u_id`, `c_id`, `completion_stat`) VALUES
(5, 18, 0),
(4, 18, 0),
(8, 18, 0),
(5, 21, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rate_resource`
--

CREATE TABLE IF NOT EXISTS `rate_resource` (
  `u_id` int(10) unsigned NOT NULL,
  `r_id` int(10) unsigned NOT NULL,
  `rating` double unsigned NOT NULL,
  KEY `r_id` (`r_id`),
  KEY `u_id` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `resource`
--

CREATE TABLE IF NOT EXISTS `resource` (
  `r_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_id` int(10) unsigned NOT NULL,
  `type_id` int(10) unsigned NOT NULL,
  `filename` varchar(30) NOT NULL,
  `file_type` varchar(30) NOT NULL,
  `file_size` double NOT NULL,
  `file_location` varchar(255) NOT NULL,
  `uploaded_by` int(10) unsigned NOT NULL,
  `uploaded_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `download_status` tinyint(1) NOT NULL DEFAULT '0',
  `avg_rating` double unsigned NOT NULL DEFAULT '0',
  `flag_status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`r_id`),
  KEY `c_id` (`c_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `resource`
--

INSERT INTO `resource` (`r_id`, `c_id`, `type_id`, `filename`, `file_type`, `file_size`, `file_location`, `uploaded_by`, `uploaded_date`, `download_status`, `avg_rating`, `flag_status`) VALUES
(1, 18, 1, 'abstract.pdf.pdf', 'application/pdf', 45081, 'resource/18/abstract.pdf.pdf', 2, '2014-02-08 07:23:13', 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `resource_type`
--

CREATE TABLE IF NOT EXISTS `resource_type` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `r_type` varchar(20) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `resource_type`
--

INSERT INTO `resource_type` (`type_id`, `r_type`) VALUES
(1, 'books'),
(2, 'video_lectures'),
(3, 'slides'),
(4, 'research_papers'),
(5, 'self_written_papers'),
(6, 'notes'),
(7, 'others');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `u_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `u_name` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL,
  `f_name` varchar(20) NOT NULL,
  `l_name` varchar(20) NOT NULL,
  `contact_no` int(10) NOT NULL,
  `dob` date NOT NULL,
  `institute` varchar(40) NOT NULL,
  `stream` varchar(20) NOT NULL,
  `role` varchar(10) NOT NULL,
  `approve_id` tinyint(1) NOT NULL DEFAULT '0',
  `photo` varchar(255) NOT NULL,
  `about` text NOT NULL,
  `show_email` tinyint(4) NOT NULL DEFAULT '0',
  `gender` tinyint(4) NOT NULL DEFAULT '0',
  `user_score` float NOT NULL DEFAULT '0',
  `count_bookmarks` int(11) NOT NULL DEFAULT '0',
  `created_comments` int(11) NOT NULL DEFAULT '0',
  `count_discussions` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`u_id`, `u_name`, `password`, `f_name`, `l_name`, `contact_no`, `dob`, `institute`, `stream`, `role`, `approve_id`, `photo`, `about`, `show_email`, `gender`, `user_score`, `count_bookmarks`, `created_comments`, `count_discussions`) VALUES
(1, 'xyz@gmail.com', 'qwerty', 'a', 'b', 123, '2009-01-13', 'vb', 'cs', 'student', 1, 'images/profiles/01.jpg', '', 0, 0, 0, 0, 1, 0),
(2, 'abc@tech.org', 'qwerty', 'aaa', 'bbb', 4321, '1997-04-02', 'vj', 'it', 'author', 1, 'images/profiles/02.jpg', '', 0, 0, 0, 0, 0, 0),
(3, 'dalvishaarad@gmail.c', 'password', 'Shaarad', 'Dalvi', 2147483647, '2012-04-01', 'vjti', 'comps', 'student', 1, 'images/profiles/03.jpg', '', 0, 0, 2, 0, 0, 0),
(4, 'shaaraddalvi@outlook.com', 'password', 'Shaarad', 'Dalvi', 25406266, '1993-11-01', 'vjti', 'comps', 'student', 1, 'images/profiles/04.jpg', '', 0, 0, 0, 0, 0, 0),
(5, 'sh@yahoo.co.in', 'password', 'shaarad', 'dalvi', 25406266, '2014-11-01', 'vjti', 'comp', 'student', 1, 'images/profiles/05.jpg', '', 0, 0, 1, 0, 1, 6),
(6, 'root', 'rootpass', 'root', 'root', 12345678, '2014-01-01', 'root', 'root', 'admin', 1, 'images/profiles/06.jpg', '', 0, 0, 0, 0, 0, 0),
(7, 'cm', 'qwerty', 'cm', 'cm', 1234567890, '2014-01-05', 'vjti', 'comp', 'cm', 1, 'images/profiles/07.jpg', '', 0, 0, 0, 0, 0, 0),
(8, 'kunalshah', 'pass1234', 'Kunal', 'Shah', 876543321, '2014-01-03', 'veermata JTI', 'computers', 'student', 1, 'images/profiles/08.jpg', '', 0, 0, 2, 0, 0, 0),
(9, 'new1@gmail.com', 'password', 'new1name', 'new1surname', 982680350, '2014-01-01', 'vjti', 'comp', 'student', 2, '', '', 0, 0, 0, 0, 0, 0),
(10, 'new2@gmail.com', 'password', 'new2', 'new2surname', 2147483647, '2014-01-02', 'vjti', 'comp', 'student', 0, '', '', 0, 0, 0, 0, 0, 0),
(11, 'new3', 'password', 'new3fname', 'new3lname', 1234567890, '2013-12-04', 'vjti', 'comp', 'student', 0, '', '', 0, 0, 0, 0, 0, 0),
(12, 'photouser@gmail.com', 'password', 'photof', 'photol', 987654321, '2014-01-06', 'insti', 'comp', 'student', 1, 'images/profiles/lamborghini-cars-logo-emblem.jpg', '', 0, 0, -1, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_comment`
--

CREATE TABLE IF NOT EXISTS `user_comment` (
  `user_comment_id` int(11) NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `vote_status` tinyint(4) NOT NULL DEFAULT '0',
  `bookmarked` tinyint(4) NOT NULL DEFAULT '0',
  `date_last_viewed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`user_comment_id`),
  KEY `comment_id` (`user_comment_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_comment`
--

INSERT INTO `user_comment` (`user_comment_id`, `user_id`, `vote_status`, `bookmarked`, `date_last_viewed`) VALUES
(2, 1, -1, 0, '2014-02-08 05:04:58'),
(2, 5, 1, 0, '2014-02-09 02:15:42'),
(5, 5, 0, 0, '2014-02-08 12:51:49'),
(7, 5, 0, 0, '2014-02-09 01:20:33'),
(9, 5, 0, 0, '2014-02-08 12:51:41'),
(10, 5, 0, 0, '2014-02-09 06:02:50'),
(2, 12, 0, 0, '2014-02-03 11:38:18'),
(5, 12, 0, 0, '2014-02-03 11:53:00'),
(7, 12, 0, 0, '2014-02-03 09:56:01'),
(9, 12, 0, 0, '2014-01-31 08:55:17');

-- --------------------------------------------------------

--
-- Table structure for table `user_discussion`
--

CREATE TABLE IF NOT EXISTS `user_discussion` (
  `u_id` int(11) unsigned NOT NULL,
  `user_discussion_id` int(11) NOT NULL,
  `seen_comments` int(11) NOT NULL,
  `date_last_viewed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bookmarked` tinyint(4) NOT NULL DEFAULT '0',
  `vote_status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`u_id`,`user_discussion_id`),
  KEY `u_id` (`u_id`),
  KEY `discussion_id` (`user_discussion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_discussion`
--

INSERT INTO `user_discussion` (`u_id`, `user_discussion_id`, `seen_comments`, `date_last_viewed`, `bookmarked`, `vote_status`) VALUES
(1, 2, 5, '2014-02-08 05:05:24', 0, -1),
(1, 3, 0, '2014-01-24 07:27:27', 0, 0),
(1, 4, 0, '2014-01-24 07:27:39', 0, 0),
(5, 2, 1, '2014-02-09 05:52:10', 1, 0),
(5, 3, 1, '2014-02-09 06:02:50', 1, 1),
(5, 4, 1, '2014-02-08 12:51:49', 0, 0),
(5, 8, 1, '2014-02-09 01:20:33', 0, 0),
(5, 9, 0, '2014-01-30 11:59:18', 0, 0),
(5, 10, 1, '2014-02-08 12:51:40', 0, 0),
(12, 2, 4, '2014-02-03 11:38:18', 1, 0),
(12, 4, 1, '2014-02-03 11:53:00', 0, 0),
(12, 8, 1, '2014-02-03 09:56:01', 0, 0),
(12, 9, 0, '2014-02-03 09:46:22', 0, 0),
(12, 10, 1, '2014-01-31 08:55:17', 0, 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `approved_status`
--
ALTER TABLE `approved_status`
  ADD CONSTRAINT `approved_status_ibfk_1` FOREIGN KEY (`r_id`) REFERENCES `resource` (`r_id`),
  ADD CONSTRAINT `approved_status_ibfk_2` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`);

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`insert_uid`) REFERENCES `user` (`u_id`),
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`delete_uid`) REFERENCES `user` (`u_id`),
  ADD CONSTRAINT `comment_ibfk_3` FOREIGN KEY (`update_uid`) REFERENCES `user` (`u_id`),
  ADD CONSTRAINT `comment_ibfk_4` FOREIGN KEY (`discussion_id`) REFERENCES `discussion` (`discussion_id`);

--
-- Constraints for table `create_course`
--
ALTER TABLE `create_course`
  ADD CONSTRAINT `c_id_key` FOREIGN KEY (`c_id`) REFERENCES `course` (`c_id`);

--
-- Constraints for table `discussion`
--
ALTER TABLE `discussion`
  ADD CONSTRAINT `discussion_ibfk_3` FOREIGN KEY (`insert_uid`) REFERENCES `user` (`u_id`),
  ADD CONSTRAINT `discussion_ibfk_4` FOREIGN KEY (`category_id`) REFERENCES `discussion_category` (`category_id`);

--
-- Constraints for table `enroll_course`
--
ALTER TABLE `enroll_course`
  ADD CONSTRAINT `enroll_course_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `course` (`c_id`),
  ADD CONSTRAINT `enroll_course_ibfk_2` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`);

--
-- Constraints for table `rate_resource`
--
ALTER TABLE `rate_resource`
  ADD CONSTRAINT `rate_resource_ibfk_2` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`),
  ADD CONSTRAINT `rate_resource_ibfk_3` FOREIGN KEY (`r_id`) REFERENCES `resource` (`r_id`);

--
-- Constraints for table `resource`
--
ALTER TABLE `resource`
  ADD CONSTRAINT `resource_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `course` (`c_id`),
  ADD CONSTRAINT `resource_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `resource_type` (`type_id`);

--
-- Constraints for table `user_comment`
--
ALTER TABLE `user_comment`
  ADD CONSTRAINT `user_comment_ibfk_1` FOREIGN KEY (`user_comment_id`) REFERENCES `comment` (`comment_id`),
  ADD CONSTRAINT `user_comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`u_id`);

--
-- Constraints for table `user_discussion`
--
ALTER TABLE `user_discussion`
  ADD CONSTRAINT `user_discussion_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`),
  ADD CONSTRAINT `user_discussion_ibfk_2` FOREIGN KEY (`user_discussion_id`) REFERENCES `discussion` (`discussion_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
