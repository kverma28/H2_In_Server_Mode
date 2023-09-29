CREATE USER ex IDENTIFIED BY ex;

--GRANT ALL PRIVILEGES TO ex;   // This is not applicable for H2 database

CREATE TABLE active_invoices
(
  invoice_id        NUMBER        NOT NULL,
  vendor_id         NUMBER        NOT NULL,
  invoice_number    VARCHAR2(50)  NOT NULL,
  invoice_date      DATE          NOT NULL,
  invoice_total     NUMBER(9,2)   NOT NULL,
  payment_total     NUMBER(9,2)   NOT NULL,
  credit_total      NUMBER(9,2)   NOT NULL,
  terms_id          NUMBER        NOT NULL,
  invoice_due_date  DATE          NOT NULL,
  payment_date      DATE
);

CREATE TABLE color_sample
(
  color_id      NUMBER                        NOT NULL,
  color_number  NUMBER            DEFAULT 0   NOT NULL,
  color_name    VARCHAR2(10)
);


CREATE TABLE customers
(
  customer_id          NUMBER            NOT NULL,
  customer_last_name   VARCHAR2(30),
  customer_first_name  VARCHAR2(30),
  customer_address     VARCHAR2(60),
  customer_city        VARCHAR2(15),
  customer_state       VARCHAR2(15),
  customer_zip         VARCHAR2(10),
  customer_phone       VARCHAR2(24)
);


CREATE TABLE date_sample
(
  date_id       NUMBER   NOT NULL,
  start_date    DATE
);

CREATE TABLE departments
(
  department_number   NUMBER        NOT NULL,
  department_name     VARCHAR2(50)  NOT NULL,
  CONSTRAINT department_number_unq UNIQUE (department_number)
);

CREATE TABLE employees
(
  employee_id         NUMBER            NOT NULL,
  last_name           VARCHAR2 (35)     NOT NULL,
  first_name          VARCHAR2 (35)     NOT NULL,
  department_number   NUMBER            NOT NULL,
  manager_id          NUMBER
);


CREATE TABLE null_sample
(
  invoice_id      NUMBER            NOT NULL,
  invoice_total   NUMBER(9,2),
  CONSTRAINT invoice_id_unq UNIQUE (invoice_id)
);

CREATE TABLE paid_invoices
(
  invoice_id            NUMBER          NOT NULL,
  vendor_id             NUMBER          NOT NULL,
  invoice_number        VARCHAR2(50)    NOT NULL,
  invoice_date          DATE            NOT NULL,
  invoice_total         NUMBER(9,2)     NOT NULL,
  payment_total         NUMBER(9,2)     NOT NULL,
  credit_total          NUMBER(9,2)     NOT NULL,
  terms_id              NUMBER          NOT NULL,
  invoice_due_date      DATE            NOT NULL,
  payment_date          DATE
);

CREATE TABLE projects
(
  project_number    VARCHAR2(5)   NOT NULL,
  employee_id       NUMBER        NOT NULL
);

CREATE TABLE string_sample
(
  id        VARCHAR2(3),
  name      VARCHAR2(25)
);