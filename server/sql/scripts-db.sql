-- Create a new database called 'CooHomelessDB'
USE CooHomelessDB;

CREATE DATABASE CooHomelessDB

-- Create a new table called 'ORGANIZATION'
CREATE TABLE ORGANIZATION
(
    ID_ORGANIZATION INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, -- primary key column
    NOME [NVARCHAR](50) NOT NULL,
    DESC_ORGANIZATION [NVARCHAR](100),
    CNPJ INTEGER NOT NULL
    -- specify more columns here
);
GO

-- Create a new table called 'COLLABORATOR'
CREATE TABLE COLLABORATOR
(
    ID_COLLABORATOR INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, -- primary key column
    DESC_COLLABORATOR [NVARCHAR](50) NOT NULL,
    Column2 [NVARCHAR](50) NOT NULL
    -- specify more columns here
);
GO


-- Create a new table called 'METTING_POINT'
CREATE TABLE METTING_POINT
(
    METTING_POINTId INT NOT NULL PRIMARY KEY, -- primary key column
    Column1 [NVARCHAR](50) NOT NULL,
    Column2 [NVARCHAR](50) NOT NULL
    -- specify more columns here
);
GO
create table METTING_POINT
(
 ID_METTING_POINT integer auto_increment not null,
 ID_LOCALIZATION,
 ID_HOMELESS,
 -- 
);


-- Create the table in the specified schema
CREATE TABLE LOCALIZATION
(
    ID_LOCALIZATION INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, -- primary key column
    LATITUDE [NVARCHAR](50) NOT NULL,
    LONGETUDE [NVARCHAR](50) NOT NULL
    -- specify more columns here
);
GO

create table homeless(
 id_homeless integer auto_increment not null
);
 
create table donation(
 id_homeless integer auto_increment not null
);

create table city(
 id_city integer auto_increment not null
 );