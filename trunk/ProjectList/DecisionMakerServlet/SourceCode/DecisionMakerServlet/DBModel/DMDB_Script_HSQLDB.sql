DROP TABLE WATCHER IF EXISTS;
DROP TABLE ROLE IF EXISTS;
DROP TABLE REQUEST IF EXISTS;
DROP TABLE USER IF EXISTS;

CREATE TABLE USER (
       ID INT NOT NULL IDENTITY
     , USERNAME VARCHAR(50)
     , ENABLED BOOLEAN
);


CREATE TABLE REQUEST (
       ID INT NOT NULL IDENTITY
     , TYPE INT
     , TITLE VARCHAR(200) NOT NULL
     , CONTENT VARCHAR(4000)
     , STARTDATE DATETIME
     , ENDATE DATETIME
     , ASSIGNED_ID INT
     , ASSIGNED_ACCOUNT CHAR(50)
     , ASSIGNED_NAME CHAR(100)
     , WATCHERS INT
     , MANAGER_ID INT
     , MANAGER_ACCOUNT VARCHAR(50)
     , MANAGER_NAME VARCHAR(100)
     , STATUS VARCHAR(30)
     , ATTACHMENT1 BLOB
     , ATTACHMENT2 BLOB
     , ATTACHMENT3 BLOB
     , CREATED DATETIME NOT NULL
     , CREATEDBY_ID INT
     , CREATEDBY_ACCOUNT VARCHAR(50)
     , CREATEDBY_NAME VARCHAR(100)
     , LASTMODIFIED DATETIME
     , LASTMODIFIEDBY_ID INT
     , LASTMODIFIEDBY_NAME VARCHAR(100)
     , LASTMODIFIEDBY_ACCOUNT VARCHAR(50)
     , CONSTRAINT FK_REQUEST_USER FOREIGN KEY (ASSIGNED_ID)
                  REFERENCES USER (ID)
     , CONSTRAINT FK_REQUEST_USER_MANAGER FOREIGN KEY (MANAGER_ID)
                  REFERENCES USER (ID)
     , CONSTRAINT FK_REQUEST_USER_CREATEDBY FOREIGN KEY (CREATEDBY_ID)
                  REFERENCES USER (ID)
);

CREATE TABLE ROLE (
       ID INT NOT NULL IDENTITY
     , USER_ID INT
     , ROLE VARCHAR(32)
     , CONSTRAINT FK_USER_ROLE FOREIGN KEY (USER_ID)
                  REFERENCES USER (ID)
);

CREATE TABLE WATCHER (
       ID INT NOT NULL IDENTITY
     , REQ_ID INT NOT NULL
     , USER_ID INT
     , USER_ACCOUNT VARCHAR(50)
     , USER_NAME VARCHAR(100)
     , CONSTRAINT FK_WATCHER_REQUEST FOREIGN KEY (REQ_ID)
                  REFERENCES REQUEST (ID)
     , CONSTRAINT FK_WATCHER_USER FOREIGN KEY (USER_ID)
                  REFERENCES USER (ID)
);
