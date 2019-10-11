DROP DATABASE IF EXISTS `wso2is_analytics`;

CREATE DATABASE `wso2is_analytics`;

GRANT ALL ON wso2is_analytics.* TO 'wso2carbon'@'%' IDENTIFIED BY 'wso2carbon';
