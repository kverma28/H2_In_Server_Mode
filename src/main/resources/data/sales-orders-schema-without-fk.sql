CREATE TABLE OFFICE (
  OFFICE_CODE 	    NUMBER(5) NOT NULL,
  CITY 			    VARCHAR(50) NOT NULL,
  PHONE 		    VARCHAR(50) NOT NULL,
  ADDRESS_LINE1 	VARCHAR(50) NOT NULL,
  ADDRESS_LINE2 	VARCHAR(50) DEFAULT NULL,
  STATE 		    VARCHAR(50) DEFAULT NULL,
  COUNTRY 		    VARCHAR(50) NOT NULL,
  POSTAL_CODE 	    VARCHAR(15) NOT NULL,
  TERRITORY 	    VARCHAR(10) NOT NULL

  ,PRIMARY KEY (OFFICE_CODE)

);

CREATE TABLE PRODUCT_LINE (
  PRODUCT_LINE 		VARCHAR(50) 	NOT NULL,
  TEXT_DESCRIPTION 	VARCHAR(4000) 	DEFAULT NULL,
  HTML_DESCRIPTION 	MEDIUMTEXT,
  IMAGE 			MEDIUMBLOB

  ,PRIMARY KEY (PRODUCT_LINE)

);


CREATE TABLE PRODUCT (
  PRODUCT_CODE 			VARCHAR(15) 	NOT NULL,
  PRODUCT_NAME 			VARCHAR(70) 	NOT NULL,
  PRODUCT_LINE 			VARCHAR(50) 	NOT NULL,
  PRODUCT_SCALE 		VARCHAR(10) 	NOT NULL,
  PRODUCT_VENDOR 		VARCHAR(50) 	NOT NULL,
  PRODUCT_DESCRIPTION 	TEXT 			NOT NULL,
  QUANTITY_IN_STOCK 	SMALLINT(6) 	NOT NULL,
  BUY_PRICE 			DECIMAL(10,2) 	NOT NULL,
  MSRP 					DECIMAL(10,2) 	NOT NULL

  ,PRIMARY KEY (PRODUCT_CODE)
  ,CONSTRAINT PRODUCT_FK FOREIGN KEY (PRODUCT_LINE) REFERENCES PRODUCT_LINE (PRODUCT_LINE)

);


CREATE TABLE EMPLOYEE (
  EMPLOYEE_ID 	    NUMBER(11) 		NOT NULL,
  LAST_NAME 		VARCHAR(50) 	NOT NULL,
  FIRST_NAME 		VARCHAR(50) 	NOT NULL,
  EXTENSION 		VARCHAR(10) 	NOT NULL,
  EMAIL 			VARCHAR(100) 	NOT NULL,
  OFFICE_CODE 		NUMBER(5) 	NOT NULL,
  REPORTS_TO 		NUMBER(11) 		DEFAULT NULL,
  JOB_TITLE 		VARCHAR(50) 	NOT NULL

  ,PRIMARY KEY (EMPLOYEE_ID)
  ,CONSTRAINT EMPLOYEES_FK_1 FOREIGN KEY (REPORTS_TO) REFERENCES EMPLOYEE (EMPLOYEE_ID)
  ,CONSTRAINT EMPLOYEES_FK_2 FOREIGN KEY (OFFICE_CODE) REFERENCES OFFICE (OFFICE_CODE)

);



CREATE TABLE CUSTOMER (
  CUSTOMER_ID			        NUMBER(11) 	    NOT NULL,
  CUSTOMER_NAME 				VARCHAR(50)     NOT NULL,
  CONTACT_LAST_NAME 			VARCHAR(50)     NOT NULL,
  CONTACT_FIRST_NAME 			VARCHAR(50)     NOT NULL,
  PHONE 					    VARCHAR(50)     NOT NULL,
  ADDRESS_LINE1 				VARCHAR(50)     NOT NULL,
  ADDRESS_LINE2 				VARCHAR(50)     DEFAULT NULL,
  CITY 						    VARCHAR(50)     NOT NULL,
  STATE 					    VARCHAR(50)     DEFAULT NULL,
  POSTAL_CODE 				    VARCHAR(15)     DEFAULT NULL,
  COUNTRY 					    VARCHAR(50)     NOT NULL,
  SALES_REP_EMPLOYEE_ID 	    NUMBER(11) 	    DEFAULT NULL,
  CREDIT_LIMIT 				    NUMBER(10,2)    DEFAULT NULL

  ,PRIMARY KEY (CUSTOMER_ID)
  ,CONSTRAINT CUSTOMER_FK FOREIGN KEY (SALES_REP_EMPLOYEE_ID) REFERENCES EMPLOYEE (EMPLOYEE_ID)

);


CREATE TABLE ORDERS (
  ORDER_NUMBER 		NUMBER(11) 	NOT NULL,
  ORDER_DATE 		DATE 		NOT NULL,
  REQUIRED_DATE 	DATE 		NOT NULL,
  SHIPPED_DATE 		DATE 		DEFAULT NULL,
  STATUS 			VARCHAR(15) NOT NULL,
  COMMENTS 			TEXT,
  CUSTOMER_ID 	    NUMBER(11) 	NOT NULL

  ,PRIMARY KEY (ORDER_NUMBER)
  ,CONSTRAINT ORDERS_FK FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID)

);



CREATE TABLE ORDER_DETAIL (
  ORDER_NUMBER 		    NUMBER(11) 		NOT NULL,
  PRODUCT_CODE 		    VARCHAR(15) 	NOT NULL,
  QUANTITY_ORDERED 	    NUMBER(11) 		NOT NULL,
  PRICE_EACH 		    NUMBER(10,2) 	NOT NULL,
  ORDER_LINE_NUMBER 	NUMBER(6) 		NOT NULL

  ,PRIMARY KEY (ORDER_NUMBER,PRODUCT_CODE)
  ,CONSTRAINT ORDER_DETAILS_FK_1 FOREIGN KEY (ORDER_NUMBER) REFERENCES ORDERS (ORDER_NUMBER)
  ,CONSTRAINT ORDER_DETAILS_FK_2 FOREIGN KEY (PRODUCT_CODE) REFERENCES PRODUCT (PRODUCT_CODE)

);



CREATE TABLE PAYMENT (
  CUSTOMER_ID 	    INT(11) 		NOT NULL,
  CHECK_NUMBER 		VARCHAR(50) 	NOT NULL,
  PAYMENT_DATE 		DATE 			NOT NULL,
  AMOUNT 			DECIMAL(10,2) 	NOT NULL

  ,PRIMARY KEY (CUSTOMER_ID,CHECK_NUMBER)
  ,CONSTRAINT PAYMENTS_FK FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID)

);

--Tables for spring security authentication

create table USERS(
    USERNAME VARCHAR(50) not null primary key,
    PASSWORD VARCHAR(50) not null,
    ENABLED BOOLEAN not null
);

create table AUTHORITIES (
    USERNAME VARCHAR(50) not null,
    AUTHORITY VARCHAR(50) not null,
    constraint fk_authorities_users foreign key(username) references users(username)
);

create unique index ix_auth_username on authorities (username,authority);
