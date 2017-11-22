-- Create a new database called 'COOHOMELESS_DB'
-- Connect to the 'master' database to run this snippet
CREATE DATABASE IF NOT EXISTS COOHOMELESS_DB;
USE COOHOMELESS_DB;

-- DROP DB
DROP DATABASE COOHOMELESS_DB;


-- SCRIPTS TABLE: ORGANIZATION
-- TABLE 'ORGANIZATION'
CREATE TABLE `organization` (
    ID INT NOT NULL AUTO_INCREMENT,
    `NAME` VARCHAR(100),
    DESC_ORGANIZATION VARCHAR(100),
    CNPJ VARCHAR(14),
    EMAIL VARCHAR(100),
    ENDERECO VARCHAR(100),
    FONE VARCHAR(100),
	URI_PROFILE_IMAGE VARCHAR(255) DEFAULT '/path/to/default_ong_pic',
	PRIMARY KEY(ID)
);

-- SCRIPTS TABLE: CONTRIBUTOR
-- TABLE 'CONTRIBUTOR'
CREATE TABLE `contributor` (
    ID INT NOT NULL AUTO_INCREMENT,
    `NAME` VARCHAR(100),
    CPF VARCHAR(50),
    EMAIL VARCHAR(100),
	URI_PROFILE_IMAGE VARCHAR(255) DEFAULT '/path/to/default_contributor_pic',
	PRIMARY KEY(ID)
);

-- SCRIPTS TABLE: HOMELESS
-- TABLE 'HOMELESS'
CREATE TABLE `homeless` (
    ID INT AUTO_INCREMENT NOT NULL,
	`NAME` VARCHAR(50),
	PHOTO VARCHAR(200),
    BACKGROUND VARCHAR(250),
	`ANONYMOUS` CHAR(1) NOT NULL DEFAULT 'Y',
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(ID),
	CONSTRAINT CHK_HOMELESS CHECK (`ANONYMOUS` = 'Y' OR `ANONYMOUS` = 'N')
);

-- TABLE 'HOMELESS_INFO'
CREATE TABLE `homeless_info` (
    ID INT AUTO_INCREMENT NOT NULL,
	GENDER VARCHAR(20),
	BIRTH_DATE DATETIME,
	HAIR_COLOR VARCHAR(20),
	HAIR_TYPE VARCHAR(20),
	ETNIA VARCHAR(20),
	EYES VARCHAR(20),
	PHYSICAL_TYPE VARCHAR(20),
    ID_HOMELESS INT NOT NULL,
    CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(ID),
    CONSTRAINT FK_HOMELESS_INFO_HOMELESS FOREIGN KEY(ID_HOMELESS) REFERENCES `homeless`(ID)
);

-- SCRIPTS TABLE: MEETING_POINT_CONTRIBUTOR
-- TABLE 'MEETING_POINT_CONTRIBUTOR'
CREATE TABLE `meeting_point_contributor` (
    ID INT NOT NULL AUTO_INCREMENT,
    LOCATION POINT,
    ID_HOMELESS INT NOT NULL,
    ID_CONTRIBUTOR INT NOT NULL,
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(ID),
    CONSTRAINT FK_MEETING_POINT_CONTRIBUTOR_HOMELESS FOREIGN KEY(ID_HOMELESS) REFERENCES `homeless`(ID),
    CONSTRAINT FK_MEETING_POINT_CONTRIBUTOR_CONTRIBUTOR FOREIGN KEY(ID_CONTRIBUTOR) REFERENCES `contributor`(ID)
);

-- SCRIPTS TABLE: MEETING_POINT_ORGANIZATION
-- TABLE 'MEETING_POINT_ORGANIZATION'
CREATE TABLE `meeting_point_ong` (
    ID INT NOT NULL AUTO_INCREMENT,
    LOCATION POINT,
    ID_HOMELESS INT NOT NULL,
    ID_ORGANIZATION INT NOT NULL,
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(ID),
    CONSTRAINT FK_MEETING_POINT_ONG_HOMELESS FOREIGN KEY(ID_HOMELESS) REFERENCES `homeless`(ID),
    CONSTRAINT FK_MEETING_POINT_ONG_ORGANIZATION FOREIGN KEY(ID_ORGANIZATION) REFERENCES `organization`(ID)
);

-- SCRIPTS TABLE: LOCATION_CONTRIBUTOR
-- TABLE 'LOCATION_CONTRIBUTOR'
CREATE TABLE `location_contributor` (
    ID INT NOT NULL AUTO_INCREMENT,
    CITY VARCHAR(20),
	UF VARCHAR(20),
	DESC_LOCATION_CONTRIBUTOR VARCHAR(200),
    LATITUDE DECIMAL NOT NULL,
    LONGITUDE DECIMAL NOT NULL,
    ID_MEETING_POINT_CONTRIBUTOR INT NOT NULL,
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(ID),
	CONSTRAINT FK_LOCATION_CONTRIBUTOR_MEETING_POINT FOREIGN KEY(ID_MEETING_POINT_CONTRIBUTOR) REFERENCES `meeting_point_contributor`(ID)
);
-- INDEX FOR 'ID_MEETING' IN 'LOCATION_CONTRIBUTOR'
CREATE INDEX IDX_LOCATION_CONTRIBUTOR_MEETING ON `location_contributor`(ID_MEETING_POINT_CONTRIBUTOR);

-- SCRIPTS TABLE: LOCATION_ONG
-- TABLE 'LOCATION_ONG'
CREATE TABLE `location_ong` (
    ID INT NOT NULL AUTO_INCREMENT,
    CITY VARCHAR(20),
	UF VARCHAR(20),
	DESC_LOCATION_ONG VARCHAR(200),
    LATITUDE DECIMAL NOT NULL,
    LONGITUDE DECIMAL NOT NULL,
	ID_MEETING_POINT_ONG INT NOT NULL,
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(ID),
	CONSTRAINT FK_LOCATION_ONG_MEETING_POINT FOREIGN KEY(ID_MEETING_POINT_ONG) REFERENCES `meeting_point_ong`(ID)
);
-- INDEX FOR 'ID_MEETING' IN 'LOCATION_ONG'
CREATE INDEX IDX_LOCATION_ONG_MEETING ON `location_ong`(ID_MEETING_POINT_ONG);







-- 8========== DOAÇÂO MEU PAU =========D
-- SCRIPTS TABLE: DONATION
-- TABLE 'DONATION'
CREATE TABLE `donation` (
    ID INT AUTO_INCREMENT NOT NULL,
    ID_DONATION_STATUS INT NOT NULL,
    ID_DONATION_ITEM INT NOT NULL,
    PRIMARY KEY(ID),
    CONSTRAINT FK_DONATION_DONATION_STATUS FOREIGN KEY(ID_DONATION_STATUS) REFERENCES `donation_status`(ID),
    CONSTRAINT FK_DONATION_DONATION_ITEM FOREIGN KEY(ID_DONATION_ITEM) REFERENCES `donation_item`(ID)
);

-- TABLE 'DONATION_STATUS'
CREATE TABLE `donation_status` (
    ID INT AUTO_INCREMENT NOT NULL,
	`TYPE` ENUM('FAIL', 'DOING', 'DONE'),
    CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(ID)
);

-- TABLE 'DONATION_ITEM'
CREATE TABLE `donation_item` (
    ID INT AUTO_INCREMENT NOT NULL,
    `TYPE` ENUM('VESTIMENTA', 'ALIMENTO', 'SAÚDE', 'HIGIENE', 'ANIMAL'),
    PRIMARY KEY(ID)
);

