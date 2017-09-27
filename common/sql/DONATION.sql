-- SCRIPTS TABLE: DONATION

-- TABLE 'DONATION'
CREATE TABLE DONATION (
    ID_DONATION INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
    ID_DONATION_STATUS INTEGER NOT NULL,
    ID_DONATION_ITEM INTEGER NOT NULL,
    PRIMARY KEY(ID_DONATION),
    CONSTRAINT FK_DONATION_DONATION_STATUS FOREIGN KEY(ID_DONATION) REFERENCES DONATION_STATUS(ID_DONATION_STATUS),
    CONSTRAINT FK_DONATION_DONATION_ITEM FOREIGN KEY(ID_DONATION) REFERENCES DONATION_ITEM(ID_DONATION_ITEM)
);

-- TABLE 'DONATION_STATUS'
CREATE TABLE DONATION_STATUS (
    ID_DONATION_STATUS INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	`TYPE` ENUM('FAIL', 'DOING', 'DONE'),
    PRIMARY KEY(ID_DONATION_STATUS)
);

-- TABLE 'DONATION_ITEM'
CREATE TABLE DONATION_ITEM (
    ID_DONATION_ITEM INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `TYPE` ENUM('VESTIMENTA', 'ALIMENTO', 'SAÚDE', 'HIGIENE', 'ANIMAL'),
    PRIMARY KEY(ID_DONATION_STATUS)
);



