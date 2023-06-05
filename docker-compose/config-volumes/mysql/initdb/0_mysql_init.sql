
/***************************************
** Initializing Databases
***************************************/

DROP DATABASE IF EXISTS WSO2IS_IDENTITY_DB;
CREATE DATABASE WSO2IS_IDENTITY_DB;
GRANT ALL ON WSO2IS_IDENTITY_DB.* TO 'wso2carbon' @'%' IDENTIFIED BY 'wso2carbon';

DROP DATABASE IF EXISTS WSO2IS_USERSTORE;
CREATE DATABASE WSO2IS_USERSTORE;
GRANT ALL ON WSO2IS_USERSTORE.* TO 'wso2carbon' @'%' IDENTIFIED BY 'wso2carbon';
