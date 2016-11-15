DROP PROCEDURE SYSTEM.SP_CREATE_ABILITY;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_CREATE_ABILITY(ablty_name IN VARCHAR,is_valid OUT CHAR)
AS
    number_of_row INTEGER;
BEGIN
    SELECT COUNT(*) INTO number_of_row FROM T_ABILITY WHERE ability_name = ablty_name;
    IF number_of_row = 0 THEN
        INSERT INTO T_ABILITY(ABILITY_NAME) VALUES(ablty_name);
        is_valid := '1';
    ELSE
        is_valid := '0';
    END IF;        
END;
/


DROP PROCEDURE SYSTEM.SP_CREATE_ABILITY_LEVEL;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_CREATE_ABILITY_LEVEL(lvl_name IN VARCHAR,is_valid OUT CHAR)
AS
    number_of_row INTEGER;
BEGIN
    SELECT COUNT(*) INTO number_of_row FROM T_ABILITY_LEVEL WHERE level_name = lvl_name;
    IF number_of_row = 0 THEN
        INSERT INTO T_ABILITY_LEVEL(LEVEL_NAME) VALUES(lvl_name);
        is_valid := '1';
    ELSE
        is_valid := '0';
    END IF;     
END;
/


DROP PROCEDURE SYSTEM.SP_CREATE_DEPARTMENT;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_CREATE_DEPARTMENT(dep_name IN VARCHAR,is_valid OUT CHAR)
AS
    number_of_row INTEGER;
BEGIN
    SELECT COUNT(*) INTO number_of_row FROM T_DEPARTMENT WHERE department_name = dep_name;
    IF number_of_row = 0 THEN
        INSERT INTO T_DEPARTMENT(DEPARTMENT_NAME) VALUES(dep_name);
        is_valid := '1';
    ELSE
        is_valid := '0';
    END IF;        
END;
/


DROP PROCEDURE SYSTEM.SP_CREATE_EDUCATION;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_CREATE_EDUCATION(edu_subject IN VARCHAR,edu_content IN VARCHAR,start_date IN VARCHAR,finish_date IN VARCHAR,educator_id IN INTEGER,is_valid OUT CHAR)
AS
BEGIN
    INSERT INTO T_EDUCATION(EDUCATION_SUBJECT,EDUCATION_CONTENT,PLANNED_DATE,COMPLETE_DATE,USER_FK) VALUES(edu_subject,edu_content,TO_DATE(start_date,'DD-MM-YYYY'),TO_DATE(finish_date,'DD-MM-YYYY'),educator_id);
    is_valid := '1';
END;
/


DROP PROCEDURE SYSTEM.SP_CREATE_ROLE;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_CREATE_ROLE(r_name IN VARCHAR, unt_id IN INTEGER, dep_id IN INTEGER, is_valid OUT CHAR)
AS
    --unit_id INTEGER;
    --dep_id INTEGER;
    number_of_row INTEGER;
BEGIN
    SELECT COUNT(*) INTO number_of_row FROM T_ROLE WHERE role_name = r_name;
    IF number_of_row = 0 THEN
        --SELECT PK INTO unit_id FROM T_UNIT WHERE unit_name = unt_name; 
        --SELECT PK INTO dep_id FROM T_DEPARTMENT WHERE department_name = dep_name;
        INSERT INTO T_ROLE(ROLE_NAME,UNIT_FK,DEPARTMENT_FK) VALUES(r_name,unt_id,dep_id);
        is_valid := '1';
    ELSE
        is_valid := '0';
    END IF;
END;
/


DROP PROCEDURE SYSTEM.SP_CREATE_STATE;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_CREATE_STATE(stt_name IN VARCHAR,is_valid OUT CHAR)
AS
    number_of_row INTEGER;
BEGIN    
    SELECT COUNT(*) INTO number_of_row FROM T_STATE WHERE state_name = stt_name;
    IF number_of_row = 0 THEN
        INSERT INTO T_STATE(STATE_NAME) VALUES(stt_name);
        is_valid := '1';
    ELSE
        is_valid := '0';
    END IF;  
END;
/


DROP PROCEDURE SYSTEM.SP_CREATE_UNIT;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_CREATE_UNIT(unt_name IN VARCHAR,dep_id IN INTEGER,is_valid OUT CHAR)
AS
    --dep_id INTEGER;
    number_of_row INTEGER;
BEGIN
    SELECT COUNT(*) INTO number_of_row FROM T_UNIT WHERE unit_name = unt_name;
    IF number_of_row = 0 THEN
        --SELECT PK INTO dep_id FROM T_DEPARTMENT WHERE department_name = dep_name;
        INSERT INTO T_UNIT(UNIT_NAME,DEPARTMENT_FK) VALUES(unt_name,dep_id);
        is_valid := '1';
    ELSE
        is_valid := '0';
    END IF;        
END;
/


DROP PROCEDURE SYSTEM.SP_REMOVE_DEPARTMENT;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_REMOVE_DEPARTMENT(dep_id IN INTEGER,is_valid OUT CHAR)
AS
    number_of_role INTEGER;
    number_of_unit INTEGER;
BEGIN
    SELECT COUNT(*) INTO number_of_unit FROM T_UNIT WHERE DEPARTMENT_FK = dep_id;
    SELECT COUNT(*) INTO number_of_role FROM T_ROLE WHERE DEPARTMENT_FK = dep_id;
    
    IF number_of_unit = 0 AND number_of_role = 0 THEN
        DELETE FROM T_DEPARTMENT WHERE PK = dep_id;
        is_valid := '1';
    ELSE
        is_valid := '0';
    END IF;
END;
/


DROP PROCEDURE SYSTEM.SP_UPDATE_ABILITY;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_UPDATE_ABILITY(ablty_id IN INTEGER,ablty_name IN VARCHAR,is_valid OUT CHAR)
AS
BEGIN
    UPDATE T_ABILITY SET ABILITY_NAME = ablty_name WHERE PK = ablty_id;
    is_valid := '1';
END;
/


DROP PROCEDURE SYSTEM.SP_UPDATE_ABILITY_LEVEL;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_UPDATE_ABILITY_LEVEL(lvl_id IN INTEGER,lvl_name IN VARCHAR,is_valid OUT CHAR)
AS
BEGIN
    UPDATE T_ABILITY_LEVEL SET LEVEL_NAME = lvl_name WHERE PK = lvl_id;
    is_valid := '1';
END;
/


DROP PROCEDURE SYSTEM.SP_UPDATE_DEPARTMENT;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_UPDATE_DEPARTMENT(dep_id IN INTEGER,dep_name IN VARCHAR,is_valid OUT CHAR)
AS
BEGIN
    UPDATE T_DEPARTMENT SET DEPARTMENT_NAME = dep_name WHERE PK = dep_id;
    is_valid := '1';
END;
/


DROP PROCEDURE SYSTEM.SP_UPDATE_ROLE;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_UPDATE_ROLE(rle_id IN INTEGER,rle_name IN VARCHAR,unt_id IN INTEGER,dep_id IN INTEGER,is_valid OUT CHAR)
AS
BEGIN
    UPDATE T_ROLE SET ROLE_NAME = rle_name,UNIT_FK = unt_id, DEPARTMENT_FK = dep_id WHERE PK = rle_id;
    is_valid := '1';
END;
/


DROP PROCEDURE SYSTEM.SP_UPDATE_UNIT;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_UPDATE_UNIT(unt_id IN INTEGER,unt_name IN VARCHAR,dep_id IN INTEGER,is_valid OUT CHAR)
AS
BEGIN
    UPDATE T_UNIT SET UNIT_NAME = unt_name,DEPARTMENT_FK = dep_id WHERE PK = unt_id;
    is_valid := '1';
END;
/


DROP PROCEDURE SYSTEM.SP_USER_LOGIN;

CREATE OR REPLACE PROCEDURE SYSTEM.SP_USER_LOGIN(user_id IN VARCHAR,user_pw IN VARCHAR,is_valid OUT CHAR)
AS
    number_of_row NUMERIC ;
BEGIN
    SELECT COUNT(*) INTO number_of_row FROM T_USER WHERE u_id = user_id AND u_pw = user_pw;

    IF number_of_row = 1 THEN
        is_valid := '1';
    ELSE
        is_valid := '0';
        
    END IF;
END;
/
ALTER TABLE SYSTEM.T_ABILITY
 DROP PRIMARY KEY CASCADE;

DROP TABLE SYSTEM.T_ABILITY CASCADE CONSTRAINTS;

CREATE TABLE SYSTEM.T_ABILITY
(
  PK             INTEGER                        NOT NULL,
  ABILITY_NAME   VARCHAR2(40 BYTE)              NOT NULL,
  CREATION_TIME  TIMESTAMP(6)                   DEFAULT CURRENT_TIMESTAMP     NOT NULL,
  MODIFIED_TIME  TIMESTAMP(6),
  IS_ACTIVE      CHAR(1 BYTE)                   DEFAULT 'Y'                   NOT NULL
)
TABLESPACE SYSTEM
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


ALTER TABLE SYSTEM.T_ABILITY_LEVEL
 DROP PRIMARY KEY CASCADE;

DROP TABLE SYSTEM.T_ABILITY_LEVEL CASCADE CONSTRAINTS;

CREATE TABLE SYSTEM.T_ABILITY_LEVEL
(
  PK             INTEGER                        NOT NULL,
  LEVEL_NAME     VARCHAR2(40 BYTE)              NOT NULL,
  CREATION_TIME  TIMESTAMP(6)                   DEFAULT CURRENT_TIMESTAMP     NOT NULL,
  MODIFIED_TIME  TIMESTAMP(6),
  IS_ACTIVE      CHAR(1 BYTE)                   DEFAULT 'Y'                   NOT NULL
)
TABLESPACE SYSTEM
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


ALTER TABLE SYSTEM.T_DEPARTMENT
 DROP PRIMARY KEY CASCADE;

DROP TABLE SYSTEM.T_DEPARTMENT CASCADE CONSTRAINTS;

CREATE TABLE SYSTEM.T_DEPARTMENT
(
  PK               INTEGER                      NOT NULL,
  DEPARTMENT_NAME  VARCHAR2(40 BYTE)            NOT NULL,
  IS_ACTIVE        CHAR(1 BYTE)                 DEFAULT 'Y'                   NOT NULL,
  CREATION_TIME    TIMESTAMP(6)                 DEFAULT CURRENT_TIMESTAMP     NOT NULL,
  MODIFIED_TIME    TIMESTAMP(6)
)
TABLESPACE SYSTEM
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


ALTER TABLE SYSTEM.T_STATE
 DROP PRIMARY KEY CASCADE;

DROP TABLE SYSTEM.T_STATE CASCADE CONSTRAINTS;

CREATE TABLE SYSTEM.T_STATE
(
  PK             INTEGER                        NOT NULL,
  STATE_NAME     VARCHAR2(40 BYTE)              NOT NULL,
  CREATION_TIME  TIMESTAMP(6)                   DEFAULT CURRENT_TIMESTAMP     NOT NULL,
  MODIFIED_TIME  TIMESTAMP(6)                   NOT NULL,
  IS_ACTIVE      CHAR(1 BYTE)                   DEFAULT 'Y'                   NOT NULL
)
TABLESPACE SYSTEM
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


ALTER TABLE SYSTEM.T_UNIT
 DROP PRIMARY KEY CASCADE;

DROP TABLE SYSTEM.T_UNIT CASCADE CONSTRAINTS;

CREATE TABLE SYSTEM.T_UNIT
(
  PK             INTEGER                        NOT NULL,
  UNIT_NAME      VARCHAR2(40 BYTE)              NOT NULL,
  IS_ACTIVE      CHAR(1 BYTE)                   DEFAULT 'Y'                   NOT NULL,
  DEPARTMENT_FK  INTEGER                        NOT NULL,
  CREATION_TIME  TIMESTAMP(6)                   DEFAULT CURRENT_TIMESTAMP     NOT NULL,
  MODIFIED_TIME  TIMESTAMP(6)
)
TABLESPACE SYSTEM
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


--  There is no statement for index SYSTEM.SYS_C0014795.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014796.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014797.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014798.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014799.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014800.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014801.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014802.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014803.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014804.
--  The object is created when the parent object is created.

CREATE OR REPLACE TRIGGER SYSTEM.TRG_ABILITY_LEVEL_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_ABILITY_LEVEL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_ABILITY_LEVEL_PK.nextval;
    END IF;                   
    IF :new.MODIFIED_TIME IS NULL THEN   
        :new.MODIFIED_TIME := :new.CREATION_TIME; 
    END IF;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_ABILITY_LEVEL_UPDATE
BEFORE UPDATE
ON SYSTEM.T_ABILITY_LEVEL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.LEVEL_NAME != :old.LEVEL_NAME THEN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_ABILITY_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_ABILITY
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL  THEN
        :new.PK := SEQ_ABILITY_PK.nextval;
        
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
        
    END IF;    
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_ABILITY_UPDATE
BEFORE UPDATE
ON SYSTEM.T_ABILITY
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :old.ABILITY_NAME != :new.ABILITY_NAME THEN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_DEPARMENT_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_DEPARTMENT
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_DEPARTMENT_PK.nextval;
    END IF;    
        
    IF :new.MODIFIED_TIME IS NULL  THEN 
        :new.MODIFIED_TIME := :new.CREATION_TIME;        
    END IF;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_DEPARTMENT_UPDATE
BEFORE UPDATE
ON SYSTEM.T_DEPARTMENT
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :old.DEPARTMENT_NAME != :new.DEPARTMENT_NAME THEN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_STATE_NEW_RECORD 
BEFORE INSERT ON SYSTEM.T_STATE
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_STATE_PK.nextval;
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;    
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_STATE_UPDATE_RECORD 
BEFORE INSERT ON SYSTEM.T_STATE
FOR EACH ROW
DECLARE
BEGIN
    IF :old.STATE_NAME != :new.STATE_NAME THEN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF; 
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_UNIT_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_UNIT
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_UNIT_PK.nextval;        
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;    
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_UNIT_UPDATE
BEFORE UPDATE
ON SYSTEM.T_UNIT
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF  
        (:old.UNIT_NAME != :new.UNIT_NAME OR 
            :old.DEPARTMENT_FK != :new.DEPARTMENT_FK) THEN
            
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
        
    END IF;
END;
/


ALTER TABLE SYSTEM.T_ROLE
 DROP PRIMARY KEY CASCADE;

DROP TABLE SYSTEM.T_ROLE CASCADE CONSTRAINTS;

CREATE TABLE SYSTEM.T_ROLE
(
  PK             INTEGER                        NOT NULL,
  ROLE_NAME      VARCHAR2(60 BYTE)              NOT NULL,
  IS_ACTIVE      CHAR(1 BYTE)                   DEFAULT 'Y'                   NOT NULL,
  UNIT_FK        INTEGER,
  CREATION_TIME  TIMESTAMP(6)                   DEFAULT CURRENT_TIMESTAMP     NOT NULL,
  MODIFIED_TIME  TIMESTAMP(6),
  DEPARTMENT_FK  INTEGER
)
TABLESPACE SYSTEM
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


ALTER TABLE SYSTEM.T_USER
 DROP PRIMARY KEY CASCADE;

DROP TABLE SYSTEM.T_USER CASCADE CONSTRAINTS;

CREATE TABLE SYSTEM.T_USER
(
  PK             INTEGER                        NOT NULL,
  U_ID           VARCHAR2(20 BYTE)              NOT NULL,
  U_PW           VARCHAR2(40 BYTE)              NOT NULL,
  FIRST_NAME     VARCHAR2(40 BYTE)              NOT NULL,
  LAST_NAME      VARCHAR2(20 BYTE)              NOT NULL,
  DATE_OF_BIRTH  DATE                           NOT NULL,
  PHONE_NUMBER   VARCHAR2(11 BYTE)              NOT NULL,
  ADDRESS        VARCHAR2(255 BYTE)             NOT NULL,
  CREATION_TIME  TIMESTAMP(6)                   DEFAULT CURRENT_TIMESTAMP     NOT NULL,
  MODIFIED_TIME  TIMESTAMP(6),
  IS_ACTIVE      CHAR(1 BYTE)                   DEFAULT 'Y'                   NOT NULL,
  ROLE_FK        INTEGER                        NOT NULL
)
TABLESPACE SYSTEM
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


ALTER TABLE SYSTEM.T_USER_ABILITY_REL
 DROP PRIMARY KEY CASCADE;

DROP TABLE SYSTEM.T_USER_ABILITY_REL CASCADE CONSTRAINTS;

CREATE TABLE SYSTEM.T_USER_ABILITY_REL
(
  PK                NUMBER(9),
  USER_FK           INTEGER,
  ABILITY_FK        INTEGER,
  ABILITY_LEVEL_FK  INTEGER,
  CREATION_TIME     TIMESTAMP(6)                DEFAULT CURRENT_TIMESTAMP     NOT NULL,
  MODIFIED_TIME     TIMESTAMP(6)
)
TABLESPACE SYSTEM
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


--  There is no statement for index SYSTEM.SYS_C0014805.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014806.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014807.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014808.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014809.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014810.
--  The object is created when the parent object is created.

CREATE OR REPLACE TRIGGER SYSTEM.TRG_ROLE_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_ROLE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_ROLE_PK.nextval;
    END IF;    
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;    
    END IF;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_ROLE_UPDATE
BEFORE UPDATE
ON SYSTEM.T_ROLE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF  
        (:new.ROLE_NAME != :old.ROLE_NAME OR
            :new.UNIT_FK != :old.UNIT_FK OR 
                :new.DEPARTMENT_FK != :old.DEPARTMENT_FK) THEN
                
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_USER_ABILITY_REL_NEW_RCRD
BEFORE INSERT
ON SYSTEM.T_USER_ABILITY_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_USER_ABILITY_REL_PK.nextval;
        
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_USER_ABILITY_UPDATE
BEFORE UPDATE
ON SYSTEM.T_USER_ABILITY_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_USER_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_USER
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF  :new.PK IS NULL THEN
        :new.PK := SEQ_USER_PK.nextval;
        
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_USER_UPDATE
BEFORE UPDATE
ON SYSTEM.T_USER
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF  
            (:new.U_ID != :old.U_ID OR
                :new.U_PW != :old.U_PW OR
                    :new.FIRST_NAME != :old.FIRST_NAME OR
                        :new.LAST_NAME != :old.LAST_NAME OR
                            :new.DATE_OF_BIRTH != :old.DATE_OF_BIRTH OR
                                :new.PHONE_NUMBER != :old.PHONE_NUMBER OR
                                    :new.ADDRESS != :old.ADDRESS OR 
                                        :new.IS_ACTIVE != :old.IS_ACTIVE OR
                                            :new.ROLE_FK != :old.ROLE_FK) THEN
                                                
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF;
END;
/


ALTER TABLE SYSTEM.T_EDUCATION
 DROP PRIMARY KEY CASCADE;

DROP TABLE SYSTEM.T_EDUCATION CASCADE CONSTRAINTS;

CREATE TABLE SYSTEM.T_EDUCATION
(
  PK                 NUMBER(2),
  EDUCATION_SUBJECT  VARCHAR2(100 BYTE)         NOT NULL,
  EDUCATION_CONTENT  VARCHAR2(1000 BYTE)        NOT NULL,
  IS_ACTIVE          CHAR(1 BYTE)               DEFAULT 'Y'                   NOT NULL,
  CREATION_TIME      TIMESTAMP(6)               DEFAULT CURRENT_TIMESTAMP     NOT NULL,
  MODIFIED_TIME      TIMESTAMP(6),
  PLANNED_DATE       DATE                       NOT NULL,
  COMPLETE_DATE      DATE                       NOT NULL,
  USER_FK            INTEGER
)
TABLESPACE SYSTEM
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


ALTER TABLE SYSTEM.T_EDUCATION_ABILITY_REL
 DROP PRIMARY KEY CASCADE;

DROP TABLE SYSTEM.T_EDUCATION_ABILITY_REL CASCADE CONSTRAINTS;

CREATE TABLE SYSTEM.T_EDUCATION_ABILITY_REL
(
  PK             NUMBER(5),
  EDUCATION_FK   INTEGER                        NOT NULL,
  ABILITY_FK     INTEGER                        NOT NULL,
  CREATION_TIME  TIMESTAMP(6)                   DEFAULT CURRENT_TIMESTAMP     NOT NULL,
  MODIFIED_TIME  TIMESTAMP(6)
)
TABLESPACE SYSTEM
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


ALTER TABLE SYSTEM.T_EDUCATION_STATE_REL
 DROP PRIMARY KEY CASCADE;

DROP TABLE SYSTEM.T_EDUCATION_STATE_REL CASCADE CONSTRAINTS;

CREATE TABLE SYSTEM.T_EDUCATION_STATE_REL
(
  PK             INTEGER                        NOT NULL,
  CREATION_TIME  TIMESTAMP(6)                   DEFAULT CURRENT_TIMESTAMP     NOT NULL,
  MODIFIED_TIME  TIMESTAMP(6)                   NOT NULL,
  EDUCATION_ID   INTEGER                        NOT NULL,
  STATE_ID       INTEGER                        NOT NULL
)
TABLESPACE SYSTEM
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


ALTER TABLE SYSTEM.T_EDUCATION_USER_REL
 DROP PRIMARY KEY CASCADE;

DROP TABLE SYSTEM.T_EDUCATION_USER_REL CASCADE CONSTRAINTS;

CREATE TABLE SYSTEM.T_EDUCATION_USER_REL
(
  PK             NUMBER(7),
  EDUCATION_FK   INTEGER                        NOT NULL,
  USER_FK        INTEGER                        NOT NULL,
  CREATION_TIME  TIMESTAMP(6)                   DEFAULT CURRENT_TIMESTAMP     NOT NULL,
  MODIFIED_TIME  TIMESTAMP(6)
)
TABLESPACE SYSTEM
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


--  There is no statement for index SYSTEM.SYS_C0014811.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014812.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014813.
--  The object is created when the parent object is created.

--  There is no statement for index SYSTEM.SYS_C0014814.
--  The object is created when the parent object is created.

CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_ABILITY_NEW_RCRD
BEFORE INSERT
ON SYSTEM.T_EDUCATION_ABILITY_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_EDUCATION_ABILITY_REL_PK.nextval;  
    END IF;
              
    IF :new.MODIFIED_TIME IS NULL THEN 
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_ABILITY_UPDATE
BEFORE UPDATE
ON SYSTEM.T_EDUCATION_ABILITY_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_EDUCATION
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    stt_id INTEGER;
BEGIN
    IF :new.PK IS NULL THEN 
        :new.PK := SEQ_EDUCATION_PK.nextval;
    END IF;            
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;    
    END IF;
    SELECT PK INTO stt_id FROM T_STATE WHERE STATE_NAME = 'PLANNED';
    INSERT INTO T_EDUCATION_STATE_REL(STATE_ID,EDUCATION_ID) VALUES(stt_id,:new.PK);
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_STATE_NEW_RECORD
BEFORE INSERT ON SYSTEM.T_EDUCATION_STATE_REL
FOR EACH ROW
DECLARE
BEGIN
    IF  :new.PK IS NULL THEN
        :new.PK := SEQ_EDUCATION_STATE_REL_PK.nextval;        
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_STATE_UPDATE
BEFORE UPDATE
ON SYSTEM.T_EDUCATION_STATE_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_UPDATE
BEFORE UPDATE
ON SYSTEM.T_EDUCATION
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF  :new.EDUCATION_SUBJECT != :old.EDUCATION_SUBJECT OR
            :new.EDUCATION_CONTENT != :old.EDUCATION_CONTENT OR
                :new.USER_FK != :old.USER_FK OR
                    :new.IS_ACTIVE != :old.IS_ACTIVE THEN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_USER_REL
BEFORE UPDATE
ON SYSTEM.T_EDUCATION_USER_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
END;
/


CREATE OR REPLACE TRIGGER SYSTEM.TRG_USER_EDUCATION_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_EDUCATION_USER_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF  :new.PK IS NULL THEN
        :new.PK := SEQ_USER_EDUCATION_REL_PK.nextval;
        
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;
END;
/


ALTER TABLE SYSTEM.T_ABILITY ADD (
  PRIMARY KEY
  (PK)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE,
  UNIQUE (ABILITY_NAME)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_ABILITY_LEVEL ADD (
  PRIMARY KEY
  (PK)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE,
  UNIQUE (LEVEL_NAME)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_DEPARTMENT ADD (
  PRIMARY KEY
  (PK)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE,
  UNIQUE (DEPARTMENT_NAME)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_STATE ADD (
  PRIMARY KEY
  (PK)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE,
  UNIQUE (STATE_NAME)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_UNIT ADD (
  PRIMARY KEY
  (PK)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE,
  UNIQUE (UNIT_NAME)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_ROLE ADD (
  PRIMARY KEY
  (PK)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE,
  UNIQUE (ROLE_NAME)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_USER ADD (
  PRIMARY KEY
  (PK)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE,
  UNIQUE (U_ID)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE,
  UNIQUE (PHONE_NUMBER)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_USER_ABILITY_REL ADD (
  PRIMARY KEY
  (PK)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_EDUCATION ADD (
  PRIMARY KEY
  (PK)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_EDUCATION_ABILITY_REL ADD (
  PRIMARY KEY
  (PK)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_EDUCATION_STATE_REL ADD (
  PRIMARY KEY
  (PK)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_EDUCATION_USER_REL ADD (
  PRIMARY KEY
  (PK)
  USING INDEX
    TABLESPACE SYSTEM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_UNIT ADD (
  FOREIGN KEY (DEPARTMENT_FK) 
  REFERENCES SYSTEM.T_DEPARTMENT (PK)
  ON DELETE CASCADE
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_ROLE ADD (
  CONSTRAINT FK_ROLE_DEPARTMENT 
  FOREIGN KEY (DEPARTMENT_FK) 
  REFERENCES SYSTEM.T_DEPARTMENT (PK)
  ON DELETE CASCADE
  ENABLE VALIDATE,
  FOREIGN KEY (UNIT_FK) 
  REFERENCES SYSTEM.T_UNIT (PK)
  ON DELETE CASCADE
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_USER ADD (
  FOREIGN KEY (ROLE_FK) 
  REFERENCES SYSTEM.T_ROLE (PK)
  ON DELETE CASCADE
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_USER_ABILITY_REL ADD (
  FOREIGN KEY (USER_FK) 
  REFERENCES SYSTEM.T_USER (PK)
  ON DELETE CASCADE
  ENABLE VALIDATE,
  FOREIGN KEY (ABILITY_FK) 
  REFERENCES SYSTEM.T_ABILITY (PK)
  ON DELETE CASCADE
  ENABLE VALIDATE,
  FOREIGN KEY (ABILITY_LEVEL_FK) 
  REFERENCES SYSTEM.T_ABILITY_LEVEL (PK)
  ON DELETE CASCADE
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_EDUCATION ADD (
  CONSTRAINT T_EDUCATION_R01 
  FOREIGN KEY (USER_FK) 
  REFERENCES SYSTEM.T_USER (PK)
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_EDUCATION_ABILITY_REL ADD (
  FOREIGN KEY (EDUCATION_FK) 
  REFERENCES SYSTEM.T_EDUCATION (PK)
  ON DELETE CASCADE
  ENABLE VALIDATE,
  FOREIGN KEY (ABILITY_FK) 
  REFERENCES SYSTEM.T_ABILITY (PK)
  ON DELETE CASCADE
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_EDUCATION_STATE_REL ADD (
  FOREIGN KEY (EDUCATION_ID) 
  REFERENCES SYSTEM.T_EDUCATION (PK)
  ON DELETE CASCADE
  ENABLE VALIDATE,
  FOREIGN KEY (STATE_ID) 
  REFERENCES SYSTEM.T_STATE (PK)
  ON DELETE CASCADE
  ENABLE VALIDATE);

ALTER TABLE SYSTEM.T_EDUCATION_USER_REL ADD (
  FOREIGN KEY (EDUCATION_FK) 
  REFERENCES SYSTEM.T_EDUCATION (PK)
  ON DELETE CASCADE
  ENABLE VALIDATE,
  FOREIGN KEY (USER_FK) 
  REFERENCES SYSTEM.T_USER (PK)
  ON DELETE CASCADE
  ENABLE VALIDATE);
DROP SEQUENCE SYSTEM.SEQ_ABILITY_LEVEL_PK;

CREATE SEQUENCE SYSTEM.SEQ_ABILITY_LEVEL_PK
  START WITH 21
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  GLOBAL;


DROP SEQUENCE SYSTEM.SEQ_ABILITY_PK;

CREATE SEQUENCE SYSTEM.SEQ_ABILITY_PK
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  GLOBAL;


DROP SEQUENCE SYSTEM.SEQ_DEPARTMENT_PK;

CREATE SEQUENCE SYSTEM.SEQ_DEPARTMENT_PK
  START WITH 300
  INCREMENT BY 5
  MAXVALUE 999999999999999999999999999
  MINVALUE 100
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  GLOBAL;


DROP SEQUENCE SYSTEM.SEQ_EDUCATION_ABILITY_REL_PK;

CREATE SEQUENCE SYSTEM.SEQ_EDUCATION_ABILITY_REL_PK
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  GLOBAL;


DROP SEQUENCE SYSTEM.SEQ_EDUCATION_PK;

CREATE SEQUENCE SYSTEM.SEQ_EDUCATION_PK
  START WITH 21
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  GLOBAL;


DROP SEQUENCE SYSTEM.SEQ_EDUCATION_STATE_REL_PK;

CREATE SEQUENCE SYSTEM.SEQ_EDUCATION_STATE_REL_PK
  START WITH 0
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER
  NOKEEP
  GLOBAL;


DROP SEQUENCE SYSTEM.SEQ_ROLE_PK;

CREATE SEQUENCE SYSTEM.SEQ_ROLE_PK
  START WITH 10000
  INCREMENT BY 500
  MAXVALUE 999999999999999999999999999
  MINVALUE 10000
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  GLOBAL;


DROP SEQUENCE SYSTEM.SEQ_STATE_PK;

CREATE SEQUENCE SYSTEM.SEQ_STATE_PK
  START WITH 3
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER
  NOKEEP
  GLOBAL;


DROP SEQUENCE SYSTEM.SEQ_UNIT_PK;

CREATE SEQUENCE SYSTEM.SEQ_UNIT_PK
  START WITH 1000
  INCREMENT BY 50
  MAXVALUE 999999999999999999999999999
  MINVALUE 1000
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  GLOBAL;


DROP SEQUENCE SYSTEM.SEQ_USER_ABILITY_REL_PK;

CREATE SEQUENCE SYSTEM.SEQ_USER_ABILITY_REL_PK
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  GLOBAL;


DROP SEQUENCE SYSTEM.SEQ_USER_EDUCATION_REL_PK;

CREATE SEQUENCE SYSTEM.SEQ_USER_EDUCATION_REL_PK
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  GLOBAL;


DROP SEQUENCE SYSTEM.SEQ_USER_PK;

CREATE SEQUENCE SYSTEM.SEQ_USER_PK
  START WITH 5000
  INCREMENT BY 4
  MAXVALUE 999999999999999999999999999
  MINVALUE 5000
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  GLOBAL;
DROP TRIGGER SYSTEM.TRG_ABILITY_LEVEL_NEW_RECORD;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_ABILITY_LEVEL_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_ABILITY_LEVEL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_ABILITY_LEVEL_PK.nextval;
    END IF;                   
    IF :new.MODIFIED_TIME IS NULL THEN   
        :new.MODIFIED_TIME := :new.CREATION_TIME; 
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_ABILITY_LEVEL_UPDATE;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_ABILITY_LEVEL_UPDATE
BEFORE UPDATE
ON SYSTEM.T_ABILITY_LEVEL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.LEVEL_NAME != :old.LEVEL_NAME THEN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_ABILITY_NEW_RECORD;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_ABILITY_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_ABILITY
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL  THEN
        :new.PK := SEQ_ABILITY_PK.nextval;
        
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
        
    END IF;    
END;
/


DROP TRIGGER SYSTEM.TRG_ABILITY_UPDATE;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_ABILITY_UPDATE
BEFORE UPDATE
ON SYSTEM.T_ABILITY
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :old.ABILITY_NAME != :new.ABILITY_NAME THEN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_DEPARMENT_NEW_RECORD;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_DEPARMENT_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_DEPARTMENT
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_DEPARTMENT_PK.nextval;
    END IF;    
        
    IF :new.MODIFIED_TIME IS NULL  THEN 
        :new.MODIFIED_TIME := :new.CREATION_TIME;        
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_DEPARTMENT_UPDATE;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_DEPARTMENT_UPDATE
BEFORE UPDATE
ON SYSTEM.T_DEPARTMENT
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :old.DEPARTMENT_NAME != :new.DEPARTMENT_NAME THEN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_EDUCATION_ABILITY_NEW_RCRD;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_ABILITY_NEW_RCRD
BEFORE INSERT
ON SYSTEM.T_EDUCATION_ABILITY_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_EDUCATION_ABILITY_REL_PK.nextval;  
    END IF;
              
    IF :new.MODIFIED_TIME IS NULL THEN 
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_EDUCATION_ABILITY_UPDATE;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_ABILITY_UPDATE
BEFORE UPDATE
ON SYSTEM.T_EDUCATION_ABILITY_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
END;
/


DROP TRIGGER SYSTEM.TRG_EDUCATION_NEW_RECORD;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_EDUCATION
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    stt_id INTEGER;
BEGIN
    IF :new.PK IS NULL THEN 
        :new.PK := SEQ_EDUCATION_PK.nextval;
    END IF;            
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;    
    END IF;
    SELECT PK INTO stt_id FROM T_STATE WHERE STATE_NAME = 'PLANNED';
    INSERT INTO T_EDUCATION_STATE_REL(STATE_ID,EDUCATION_ID) VALUES(stt_id,:new.PK);
END;
/


DROP TRIGGER SYSTEM.TRG_EDUCATION_STATE_NEW_RECORD;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_STATE_NEW_RECORD
BEFORE INSERT ON SYSTEM.T_EDUCATION_STATE_REL
FOR EACH ROW
DECLARE
BEGIN
    IF  :new.PK IS NULL THEN
        :new.PK := SEQ_EDUCATION_STATE_REL_PK.nextval;        
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_EDUCATION_STATE_UPDATE;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_STATE_UPDATE
BEFORE UPDATE
ON SYSTEM.T_EDUCATION_STATE_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
END;
/


DROP TRIGGER SYSTEM.TRG_EDUCATION_UPDATE;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_UPDATE
BEFORE UPDATE
ON SYSTEM.T_EDUCATION
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF  :new.EDUCATION_SUBJECT != :old.EDUCATION_SUBJECT OR
            :new.EDUCATION_CONTENT != :old.EDUCATION_CONTENT OR
                :new.USER_FK != :old.USER_FK OR
                    :new.IS_ACTIVE != :old.IS_ACTIVE THEN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_EDUCATION_USER_REL;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_EDUCATION_USER_REL
BEFORE UPDATE
ON SYSTEM.T_EDUCATION_USER_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
END;
/


DROP TRIGGER SYSTEM.TRG_ROLE_NEW_RECORD;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_ROLE_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_ROLE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_ROLE_PK.nextval;
    END IF;    
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;    
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_ROLE_UPDATE;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_ROLE_UPDATE
BEFORE UPDATE
ON SYSTEM.T_ROLE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF  
        (:new.ROLE_NAME != :old.ROLE_NAME OR
            :new.UNIT_FK != :old.UNIT_FK OR 
                :new.DEPARTMENT_FK != :old.DEPARTMENT_FK) THEN
                
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_STATE_NEW_RECORD;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_STATE_NEW_RECORD 
BEFORE INSERT ON SYSTEM.T_STATE
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_STATE_PK.nextval;
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;    
END;
/


DROP TRIGGER SYSTEM.TRG_STATE_UPDATE_RECORD;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_STATE_UPDATE_RECORD 
BEFORE INSERT ON SYSTEM.T_STATE
FOR EACH ROW
DECLARE
BEGIN
    IF :old.STATE_NAME != :new.STATE_NAME THEN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF; 
END;
/


DROP TRIGGER SYSTEM.TRG_UNIT_NEW_RECORD;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_UNIT_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_UNIT
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_UNIT_PK.nextval;        
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;    
END;
/


DROP TRIGGER SYSTEM.TRG_UNIT_UPDATE;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_UNIT_UPDATE
BEFORE UPDATE
ON SYSTEM.T_UNIT
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF  
        (:old.UNIT_NAME != :new.UNIT_NAME OR 
            :old.DEPARTMENT_FK != :new.DEPARTMENT_FK) THEN
            
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
        
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_USER_ABILITY_REL_NEW_RCRD;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_USER_ABILITY_REL_NEW_RCRD
BEFORE INSERT
ON SYSTEM.T_USER_ABILITY_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.PK IS NULL THEN
        :new.PK := SEQ_USER_ABILITY_REL_PK.nextval;
        
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_USER_ABILITY_UPDATE;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_USER_ABILITY_UPDATE
BEFORE UPDATE
ON SYSTEM.T_USER_ABILITY_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
END;
/


DROP TRIGGER SYSTEM.TRG_USER_EDUCATION_NEW_RECORD;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_USER_EDUCATION_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_EDUCATION_USER_REL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF  :new.PK IS NULL THEN
        :new.PK := SEQ_USER_EDUCATION_REL_PK.nextval;
        
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_USER_NEW_RECORD;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_USER_NEW_RECORD
BEFORE INSERT
ON SYSTEM.T_USER
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF  :new.PK IS NULL THEN
        :new.PK := SEQ_USER_PK.nextval;
        
    END IF;
    IF :new.MODIFIED_TIME IS NULL THEN
        :new.MODIFIED_TIME := :new.CREATION_TIME;
    END IF;
END;
/


DROP TRIGGER SYSTEM.TRG_USER_UPDATE;

CREATE OR REPLACE TRIGGER SYSTEM.TRG_USER_UPDATE
BEFORE UPDATE
ON SYSTEM.T_USER
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF  
            (:new.U_ID != :old.U_ID OR
                :new.U_PW != :old.U_PW OR
                    :new.FIRST_NAME != :old.FIRST_NAME OR
                        :new.LAST_NAME != :old.LAST_NAME OR
                            :new.DATE_OF_BIRTH != :old.DATE_OF_BIRTH OR
                                :new.PHONE_NUMBER != :old.PHONE_NUMBER OR
                                    :new.ADDRESS != :old.ADDRESS OR 
                                        :new.IS_ACTIVE != :old.IS_ACTIVE OR
                                            :new.ROLE_FK != :old.ROLE_FK) THEN
                                                
        :new.MODIFIED_TIME := CURRENT_TIMESTAMP;
    END IF;
END;
/