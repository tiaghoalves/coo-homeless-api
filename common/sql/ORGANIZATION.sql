-- SCRIPTS TABLE: ORGANIZATION 

-- TABLE 'ORGANIZATION'
CREATE TABLE ORGANIZATION (
    ID_ORGANIZATION INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `NAME` VARCHAR(100),
    DESC_ORGANIZATION VARCHAR(100),
    CNPJ VARCHAR(14),
	PRIMARY KEY(ID_ORGANIZATION)
);