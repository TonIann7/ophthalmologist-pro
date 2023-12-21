CREATE TABLE PATIENT (
        CF CHAR(16) PRIMARY KEY NOT NULL,
        FIRSTNAME VARCHAR2(30) NOT NULL,
        LASTNAME VARCHAR2(30) NOT NULL
);

CREATE TABLE PRESCRIPTION (
        NUM_PRESCRIPTION NUMBER(3) NOT NULL,
        PRESCRIPTION_DATE DATE NOT NULL,
        LEFT_AXLE NUMBER,
        RIGHT_AXLE NUMBER,
        LEFT_SPHERE NUMBER,
        RIGHT_SPHERE NUMBER,
        LEFT_CYLINDER NUMBER,
        RIGHT_CYLINDER NUMBER,
        PRESCRIPTION_DUR NUMBER,
        INTERPUPILLARY_DIST NUMBER,
        SEMIDAV NUMBER,
        CORNEAL_APEX_DIST NUMBER,
        PANTHOSCOPIC_ANGLE NUMBER,
        INSET NUMBER,
        LENS_TYPE VARCHAR2(25),
        TREATMENT VARCHAR2(16),
        CF_PAZ CHAR(16) NOT NULL,
        CONSTRAINT PRESCRIPTION_PK PRIMARY KEY (NUM_PRESCRIPTION),
        CONSTRAINT PAZ
                FOREIGN KEY (CF_PAZ)
                REFERENCES PATIENT(CF)
);

CREATE TABLE DOCTOR (
        CF CHAR(16) PRIMARY KEY NOT NULL,
        SPECIALIZATION VARCHAR2(30),
        YEARS_EXP NUMBER
);

CREATE TABLE PRESCRIBES (
        CF_MED CHAR(16) NOT NULL,
        NUM_PRESCRIPTION  NUMBER(3) NOT NULL,
        CONSTRAINT MED
                FOREIGN KEY (CF_MED)
                REFERENCES DOCTOR(CF),
        CONSTRAINT PRESC
                FOREIGN KEY (NUM_PRESCRIPTION)
                REFERENCES PRESCRIPTION(NUM_PRESCRIPTION)
);

CREATE SEQUENCE NUM_PRESCRIPTION_INC;

CREATE OR REPLACE TRIGGER PRESCRIPTION_on_insert
  BEFORE INSERT ON PRESCRIPTION
  FOR EACH ROW
BEGIN
  SELECT NUM_PRESCRIPTION_INC.nextval
  INTO :new.NUM_PRESCRIPTION
  FROM dual;
END;
/