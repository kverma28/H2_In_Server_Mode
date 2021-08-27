CREATE USER om IDENTIFIED BY om;

--GRANT ALL PRIVILEGES TO om;   // This is not applicable for H2 database

CREATE TABLE customers
(
  customer_id           NUMBER          NOT NULL,
  customer_first_name   VARCHAR2(50),
  customer_last_name    VARCHAR2(50)    NOT NULL,
  customer_address      VARCHAR2(255)   NOT NULL,
  customer_city         VARCHAR2(50)    NOT NULL,
  customer_state        CHAR(2)         NOT NULL,
  customer_zip          VARCHAR2(20)    NOT NULL,
  customer_phone        VARCHAR2(30)    NOT NULL,
  customer_fax          VARCHAR2(30),
  CONSTRAINT customers_pk PRIMARY KEY (customer_id)
);

CREATE TABLE items
(
  item_id       NUMBER		NOT NULL,
  title         VARCHAR2(50)	NOT NULL,
  artist        VARCHAR2(50)	NOT NULL,
  unit_price    NUMBER		NOT NULL,
  CONSTRAINT items_pk PRIMARY KEY (item_id),
  CONSTRAINT title_artist_unq UNIQUE (title, artist)
);

CREATE TABLE orders
(
  order_id          NUMBER      NOT NULL,
  customer_id       NUMBER      NOT NULL,
  order_date        DATE        NOT NULL,
  shipped_date      DATE,
  CONSTRAINT orders_pk PRIMARY KEY (order_id),
  CONSTRAINT orders_fk_customers FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

CREATE TABLE order_details
(
  order_id      NUMBER        NOT NULL,
  item_id       NUMBER        NOT NULL,
  order_qty     NUMBER        NOT NULL,
  CONSTRAINT order_details_pk PRIMARY KEY (order_id, item_id),
  CONSTRAINT order_details_fk_orders FOREIGN KEY (order_id) REFERENCES orders (order_id),
  CONSTRAINT order_details_fk_items FOREIGN KEY (item_id) REFERENCES items (item_id)
);