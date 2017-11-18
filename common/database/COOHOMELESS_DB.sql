-- Create a new database called 'COO_HOMELESS_DB'
-- Connect to the 'master' database to run this snippet
CREATE DATABASE IF NOT EXISTS COOHOMELESS_DB;
USE COOHOMELESS_DB;

-- SCRIPTS TABLE: USER
-- TABLE 'USER'
CREATE TABLE `USER` (
    ID_USER INTEGER NOT NULL AUTO_INCREMENT,
    FULL_NAME VARCHAR(100) NOT NULL,
    URL_PROFILE_IMAGE VARCHAR(255) DEFAULT '/path/to/default_profile_pic',
    USER_TYPE INT,
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(ID_USER)
);

-- SCRIPTS TABLE: ORGANIZATION
-- TABLE 'ORGANIZATION'
CREATE TABLE `ORGANIZATION` (
    ID_ORGANIZATION INTEGER NOT NULL AUTO_INCREMENT,
    `NAME` VARCHAR(100),
    DESC_ORGANIZATION VARCHAR(100),
    CNPJ VARCHAR(14),
    ID_USER INTEGER NOT NULL,
	PRIMARY KEY(ID_ORGANIZATION),
    CONSTRAINT FK_ORGANIZATION_USER FOREIGN KEY(ID_USER) REFERENCES `USER`(ID_USER)
);

-- SCRIPTS TABLE: CONTRIBUTOR
-- TABLE 'CONTRIBUTOR'
CREATE TABLE `CONTRIBUTOR` (
    ID_CONTRIBUTOR INTEGER NOT NULL AUTO_INCREMENT,
    `NAME` VARCHAR(100),
    CPF VARCHAR(11),
    ID_USER INTEGER NOT NULL,
	PRIMARY KEY(ID_CONTRIBUTOR),
    CONSTRAINT FK_CONTRIBUTOR_USER FOREIGN KEY(ID_USER) REFERENCES `USER`(ID_USER)
);

-- SCRIPTS TABLE: HOMELESS
-- TABLE 'HOMELESS'
CREATE TABLE `HOMELESS` (
    ID_HOMELESS INTEGER AUTO_INCREMENT NOT NULL,
	`NAME` VARCHAR(50),
	PHOTO VARCHAR(200),
    BACKGROUND VARCHAR(250),
    STATUS_TYPE ENUM('FOME', 'SAÚDE', 'FRIO'),
	`ANONYMOUS` CHAR(1) NOT NULL DEFAULT 'Y',
	ID_HOMELESS_INFO INTEGER NOT NULL,
	ID_HOMELESS_STATUS INTEGER NOT NULL,
    PRIMARY KEY(ID_HOMELESS),
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT FK_HOMELESS_HOMELESS_DATAIL FOREIGN KEY(ID_HOMELESS_INFO) REFERENCES HOMELESS_INFO(ID_HOMELESS_INFO)
	CONSTRAINT CHK_HOMELESS CHECK (`ANONYMOUS` == 'Y' OR `ANONYMOUS` == 'N')
);

-- TABLE 'HOMELESS_INFO'
CREATE TABLE `HOMELESS_INFO` (
    ID_HOMELESS_INFO INTEGER AUTO_INCREMENT NOT NULL,
	GENDER VARCHAR(20),
	BIRTH_DATE DATETIME,
	HAIR_COLOR VARCHAR(20),
	HAIR_TYPE VARCHAR(20),
	ETNIA VARCHAR(20),
	EYES VARCHAR(20),
	PHYSICAL_TYPE VARCHAR(20),
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(ID_HOMELESS_INFO)
);

-- SCRIPTS TABLE: MEETING_POINT

-- TABLE 'MEETING_POINT'
CREATE TABLE `MEETING_POINT` (
    ID_MEETING_POINT INTEGER NOT NULL AUTO_INCREMENT,
    ID_HOMELESS INTEGER NOT NULL,
    ID_USER INTEGER NOT NULL,
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(ID_MEETING),
    CONSTRAINT FK_MEETING_POINT_HOMELESS FOREIGN KEY(ID_HOMELESS) REFERENCES HOMELESS(ID_HOMELESS),
    CONSTRAINT FK_MEETING_POINT_USER FOREIGN KEY(ID_USER) REFERENCES `USER`(ID_USER)
);

-- SCRIPTS TABLE: LOCALIZATION
-- TABLE 'LOCALIZATION'
CREATE TABLE `LOCALIZATION` (
    ID_LOCALIZATION INTEGER NOT NULL AUTO_INCREMENT,
    CITY VARCHAR(20),
	UF VARCHAR(20),
	DESC_LOCALIZATION VARCHAR(200),
    LATITUDE DECIMAL NOT NULL,
    LONGITUDE DECIMAL NOT NULL,
	ID_MEETING_POINT INTEGER NOT NULL,
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(ID_LOCALIZATION),
	CONSTRAINT FK_LOCALIZATION_MEETING_POINT FOREIGN KEY(ID_MEETING_POINT) REFERENCES MEETING_POINT(ID_MEETING_POINT)
);
--INDEX FOR 'ID_MEETING' IN 'LOCALIZATION'
CREATE INDEX IDX_LOCALIZATION_MEETING ON LOCALIZATION (ID_MEETING);

-- SCRIPTS TABLE: DONATION

-- TABLE 'DONATION'
CREATE TABLE `DONATION` (
    ID_DONATION INTEGER AUTO_INCREMENT NOT NULL,
    ID_DONATION_STATUS INTEGER NOT NULL,
    ID_DONATION_ITEM INTEGER NOT NULL,
    PRIMARY KEY(ID_DONATION),
    CONSTRAINT FK_DONATION_DONATION_STATUS FOREIGN KEY(ID_DONATION) REFERENCES DONATION_STATUS(ID_DONATION_STATUS),
    CONSTRAINT FK_DONATION_DONATION_ITEM FOREIGN KEY(ID_DONATION) REFERENCES DONATION_ITEM(ID_DONATION_ITEM)
);

-- TABLE 'DONATION_STATUS'
CREATE TABLE `DONATION_STATUS` (
    ID_DONATION_STATUS INTEGER AUTO_INCREMENT NOT NULL,
	`TYPE` ENUM('FAIL', 'DOING', 'DONE'),
    CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(ID_DONATION_STATUS)
);

-- TABLE 'DONATION_ITEM'
CREATE TABLE `DONATION_ITEM` (
    ID_DONATION_ITEM INTEGER AUTO_INCREMENT NOT NULL,
    `TYPE` ENUM('VESTIMENTA', 'ALIMENTO', 'SAÚDE', 'HIGIENE', 'ANIMAL'),
    PRIMARY KEY(ID_DONATION_STATUS)
);

