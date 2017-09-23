-- SCRIPTS TABLE: HOMELESS

-- TABLE 'HOMELESS'
CREATE TABLE HOMELESS (
    ID_HOMELESS INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	`NAME` VARCHAR(50),
	PHOTO VARCHAR(200),
	ID_HOMELESS_DETAIL INTEGER NOT NULL,
	ID_HOMELESS_STATUS INTEGER NOT NULL,
	PRIMARY KEY(ID_HOMELESS),
	CONSTRAINT FK_HOMELESS_HOMELESS_DATAIL FOREIGN KEY(ID_HOMELESS_DETAIL) REFERENCES HOMELESS_DETAIL(ID_HOMELESS_DETAIL),
	CONSTRAINT FK_HOMELESS_HOMELESS_STATUS FOREIGN KEY(ID_HOMELESS_STATUS) REFERENCES HOMELESS_STATUS(ID_HOMELESS_STATUS)
);

-- TABLE 'HOMELESS_STATUS'
CREATE TABLE HOMELESS_STATUS (
    ID_HOMELESS_STATUS INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	TIPO VARCHAR(20),
	PRIMARY KEY(ID_HOMELESS_STATUS)
);

-- TABLE 'HOMELESS_DETAIL'
CREATE TABLE HOMELESS_DETAIL (
    ID_HOMELESS_DETAIL INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	GENDER VARCHAR(20),
	BIRTH_DATE DATETIME,
	HAIR_COLOR VARCHAR(20),
	HAIR_TYPE VARCHAR(20),
	ETNIA VARCHAR(20),
	EYES VARCHAR(20),
	TIPO_FISICO VARCHAR(20),
    PRIMARY KEY(ID_HOMELESS_DETAIL)
);
