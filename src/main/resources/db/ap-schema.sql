CREATE USER ap IDENTIFIED BY ap;

--GRANT ALL PRIVILEGES TO ap;   // This is not applicable for H2 database

CREATE TABLE general_ledger_accounts
(
  account_number        NUMBER          NOT NULL,
  account_description   VARCHAR2(50)    NOT NULL,
  CONSTRAINT gl_accounts_pk PRIMARY KEY (account_number),
  CONSTRAINT gl_account_description_uq UNIQUE (account_description)
);

CREATE TABLE terms
(
  terms_id              NUMBER          NOT NULL,
  terms_description     VARCHAR2(50)    NOT NULL,
  terms_due_days        NUMBER          NOT NULL,
  CONSTRAINT terms_pk PRIMARY KEY (terms_id)
);


CREATE TABLE vendors
(
  vendor_id                     NUMBER          NOT NULL,
  vendor_name                   VARCHAR2(50)    NOT NULL,
  vendor_address1               VARCHAR2(50),
  vendor_address2               VARCHAR2(50),
  vendor_city                   VARCHAR2(50)    NOT NULL,
  vendor_state                  CHAR(2)         NOT NULL,
  vendor_zip_code               VARCHAR2(20)    NOT NULL,
  vendor_phone                  VARCHAR2(50),
  vendor_contact_last_name      VARCHAR2(50),
  vendor_contact_first_name     VARCHAR2(50),
  default_terms_id              NUMBER          NOT NULL,
  default_account_number        NUMBER          NOT NULL,
  CONSTRAINT vendors_pk PRIMARY KEY (vendor_id),
  CONSTRAINT vendors_vendor_name_uq UNIQUE (vendor_name),
  CONSTRAINT vendors_fk_terms FOREIGN KEY (default_terms_id) REFERENCES terms (terms_id),
  CONSTRAINT vendors_fk_accounts FOREIGN KEY (default_account_number) REFERENCES general_ledger_accounts (account_number)
);

CREATE TABLE invoices
(
  invoice_id            NUMBER,
  vendor_id             NUMBER          NOT NULL,
  invoice_number        VARCHAR2(50)    NOT NULL,
  invoice_date          DATE            NOT NULL,
  invoice_total         NUMBER(9,2)     NOT NULL,
  payment_total         NUMBER(9,2)                 DEFAULT 0,
  credit_total          NUMBER(9,2)                 DEFAULT 0,
  terms_id              NUMBER          NOT NULL,
  invoice_due_date      DATE            NOT NULL,
  payment_date          DATE,
  CONSTRAINT invoices_pk PRIMARY KEY (invoice_id),
  CONSTRAINT invoices_fk_vendors FOREIGN KEY (vendor_id) REFERENCES vendors (vendor_id),
  CONSTRAINT invoices_fk_terms FOREIGN KEY (terms_id) REFERENCES terms (terms_id)
);

CREATE TABLE invoice_line_items
(
  invoice_id              NUMBER        NOT NULL,
  invoice_sequence        NUMBER        NOT NULL,
  account_number          NUMBER        NOT NULL,
  line_item_amt           NUMBER(9,2)   NOT NULL,
  line_item_description   VARCHAR2(100) NOT NULL,
  CONSTRAINT line_items_pk PRIMARY KEY (invoice_id, invoice_sequence),
  CONSTRAINT line_items_fk_invoices FOREIGN KEY (invoice_id) REFERENCES invoices (invoice_id),
  CONSTRAINT line_items_fk_acounts FOREIGN KEY (account_number) REFERENCES general_ledger_accounts (account_number)
);

-- Create the indexes
CREATE INDEX vendors_terms_id_ix ON vendors (default_terms_id);
CREATE INDEX vendors_account_number_ix ON vendors (default_account_number);

CREATE INDEX invoices_invoice_date_ix ON invoices (invoice_date DESC);
CREATE INDEX invoices_vendor_id_ix ON invoices (vendor_id);
CREATE INDEX invoices_terms_id_ix ON invoices (terms_id);
CREATE INDEX line_items_account_number_ix ON invoice_line_items (account_number);

-- Create the sequences
CREATE SEQUENCE vendor_id_seq START WITH 124;
CREATE SEQUENCE invoice_id_seq START WITH 115;

-- Create the test tables that aren't explicitly
-- related to the previous five tables
CREATE TABLE vendor_contacts
(
  vendor_id       NUMBER        NOT NULL,
  last_name       VARCHAR2(50)  NOT NULL,
  first_name      VARCHAR2(50)  NOT NULL
);

CREATE TABLE invoice_archive
(
  invoice_id          NUMBER          NOT NULL,
  vendor_id           NUMBER          NOT NULL,
  invoice_number      VARCHAR2(50)    NOT NULL,
  invoice_date        DATE            NOT NULL,
  invoice_total       NUMBER          NOT NULL,
  payment_total       NUMBER          NOT NULL,
  credit_total        NUMBER          NOT NULL,
  terms_id            NUMBER          NOT NULL,
  invoice_due_date    DATE            NOT NULL,
  payment_date        DATE
);