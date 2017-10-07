-- SCRIPTS TABLE: MEETING

-- TABLE 'MEETING'
CREATE TABLE MEETING (
    ID_MEETING INTEGER NOT NULL AUTO_INCREMENT,
    ID_HOMELESS INTEGER NOT NULL,
	ID_MEETING_ORGANIZATION INTEGER,
	ID_MEETING_CONTRIBUTOR INTEGER,
	PRIMARY KEY(ID_MEETING)
);

-- TABLE 'MEETING_ORGANIZATION'
CREATE TABLE MEETING_ORGANIZATION (
    ID_MEETING_ORGANIZATION INTEGER NOT NULL AUTO_INCREMENT,
    CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(ID_MEETING_CONTRIBUTOR)
);

-- TABLE 'MEETING_CONTRIBUTOR'
CREATE TABLE MEETING_CONTRIBUTOR (
    ID_MEETING_CONTRIBUTOR INTEGER NOT NULL AUTO_INCREMENT,
    CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(ID_MEETING_CONTRIBUTOR)
);
