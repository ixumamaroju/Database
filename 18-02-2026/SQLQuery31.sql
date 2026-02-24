use college_db;
create table Customers1(
customer_id bigint primary key,
customer_name varchar(20),
email varchar(60) unique,
phone_no varchar(20) unique
);
alter table Customers1 add created_at date,
deleted_at date;


insert into Customers1 (customer_id,customer_name,email,phone_no,created_at,deleted_at) values
(1,'Ravi','ravi@gamil.com','9876543210','2025-01-01',NULL),
(2,'Anjali','anjali@gmail.com','9123456780','2025-01-02',NULL),
(3,'Suresh','suresh@gmail.com','9988776655','2025-01-03', NULL),
(4, 'Meena', 'meena@gmail.com', '9001122334', '2025-01-04', NULL),
(5, 'Arjun', 'arjun@gmail.com', '9112233445', '2025-01-05', NULL);

select * from Customers1;

create table orderss (
order_id BIGINT PRIMARY KEY,
customer_id BIGINT NOT NULL,
order_date DATE NOT NULL,
order_status VARCHAR(20) NOT NULL CHECK (order_status IN('PLACED','SHIPPED','COMPLETED','CANCELLED')),
created_at DATE,
deleted_at DATE NULL,
FOREIGN KEY (customer_id) REFERENCES Customers1(customer_id)
);

INSERT INTO orderss(order_id,customer_id,order_date,order_status,created_at,deleted_at) VALUES
(101, 1, '2025-01-05', 'PLACED', '2025-01-05', NULL),
(102, 2, '2025-01-06', 'PLACED', '2025-01-06', NULL),
(103, 3, '2025-01-07', 'PLACED', '2025-01-07', NULL),
(104, 4, '2025-01-08', 'PLACED', '2025-01-08', NULL),
(105, 5, '2025-01-09', 'PLACED', '2025-01-09', NULL);

SELECT * FROM orderss;

CREATE TABLE invoice(
invoice_id BIGINT PRIMARY KEY,
customer_id BIGINT NOT NULL,
invoice_num VARCHAR(50) UNIQUE NOT NULL,
invoice_date DATE NOT NULL,
subtotal decimal(12,2) NOT NULL CHECK (subtotal >=0),
tax_amount decimal(12,2) NOT NULL  CHECK (tax_amount >=0),
extra_charges decimal(12,2) NOT NULL CHECK(extra_charges >=0),
total_amount decimal(12,2)NOT NULL CHECK(total_amount >=0),
status VARCHAR(20) NOT NULL CHECK(status IN ('DRAFT','PARTIALLY_PAID','PAID')),
is_locked BIT NOT NULL DEFAULT 0,
version_num INT NOT NULL DEFAULT 1,
created_at DATE ,
deleted_at DATE NULL,
FOREIGN KEY (customer_id) REFERENCES Customers1 (customer_id)
);

INSERT INTO invoice( invoice_id,customer_id,invoice_num,invoice_date,subtotal,tax_amount,extra_charges,total_amount,status,is_locked,version_num,created_at,deleted_at) VALUES
(201, 1, 'INV-001', '2025-01-07', 10000, 1800, 500, 12300, 'PAID', 1, 1, '2025-01-07', NULL),
(202, 2, 'INV-002', '2025-01-08', 20000, 3600, 800, 24400, 'PARTIALLY_PAID', 0, 1, '2025-01-08', NULL),
(203, 3, 'INV-003', '2025-01-09', 15000, 2700, 700, 18400, 'PAID', 1, 1, '2025-01-09', NULL),
(204, 4, 'INV-004', '2025-01-10', 5000, 900, 200, 6100, 'DRAFT', 0, 1, '2025-01-10', NULL),
(205, 5, 'INV-005', '2025-01-11', 8000, 1440, 300, 9740, 'PARTIALLY_PAID', 0, 1, '2025-01-11', NULL);

SELECT * FROM invoice;

CREATE TABLE shippment(
shipment_id BIGINT PRIMARY KEY,
order_id BIGINT NOT NULL,
invoice_id BIGINT NOT NULL,
shipment_date DATE NOT NULL,
shipment_cost DECIMAL (12,2) NOT NULL CHECK(shipment_cost>=0),
created_at DATE,
deleted_at DATE NULL,
FOREIGN KEY (order_id) REFERENCES orderss (order_id),
FOREIGN KEY (invoice_id) REFERENCES invoice (invoice_id)
);

INSERT INTO shippment (shipment_id,order_id,invoice_id,shipment_date,shipment_cost,created_at,deleted_at) VALUES
(301, 101, 201, '2025-01-06', 6000, '2025-01-06', NULL),
(302, 101, 201, '2025-01-06', 4000, '2025-01-06', NULL),
(303, 102, 202, '2025-01-07', 20000, '2025-01-07', NULL),
(304, 103, 203, '2025-01-08', 15000, '2025-01-08', NULL),
(305, 104, 204, '2025-01-09', 5000, '2025-01-09', NULL),
(306, 105, 205, '2025-01-10', 8000, '2025-01-10', NULL);

SELECT * FROM shippment;

CREATE TABLE Payment (payment_id INT PRIMARY KEY,
customer_id BIGINT NOT NULL,
payment_num VARCHAR(100) UNIQUE NOT NULL,
total_paid DECIMAL(12,2) NOT NULL CHECK(total_paid >=0),
payment_mode VARCHAR(30) NOT NULL CHECK (payment_mode IN('CASH','UPI','BANK_TRANSFER','CARD')),
created_at DATE ,
deleted_at DATE NULL,
FOREIGN KEY (customer_id) REFERENCES Customers1 (customer_id));

ALTER TABLE Payment add payment_date DATE;
INSERT INTO Payment(payment_id,customer_id,payment_num,payment_date,total_paid,payment_mode,created_at,deleted_at)VALUES
(401, 1, 'PAY-001', '2025-01-08', 12300, 'UPI', '2025-01-08', NULL),
(402, 2, 'PAY-002', '2025-01-09', 10000, 'CARD', '2025-01-09', NULL),
(403, 3, 'PAY-003', '2025-01-10', 18400, 'BANK_TRANSFER', '2025-01-10', NULL),
(404, 5, 'PAY-004', '2025-01-12', 5000, 'UPI', '2025-01-12', NULL);

SELECT * FROM Payment;

CREATE TABLE invoice_payment (
invoice_payment_id BIGINT PRIMARY KEY,
payment_id INT NOT NULL,
invoice_id BIGINT NOT NULL,
amount_applied DECIMAL(12,2) NOT NULL CHECK(amount_applied >=0),
created_at DATE,
FOREIGN KEY (payment_id) REFERENCES  Payment (payment_id),
FOREIGN KEY (invoice_id) REFERENCES invoice (invoice_id)
);


INSERT INTO invoice_payment(invoice_payment_id,payment_id,invoice_id,amount_applied,created_at) VALUES
(501, 401, 201, 12300, '2025-01-08'),
(502, 402, 202, 10000, '2025-01-09'),
(503, 403, 203, 18400, '2025-01-10'),
(504, 404, 205, 5000, '2025-01-12');

SELECT * FROM invoice_payment;

CREATE TRIGGER trg_prevent_paid_update
ON invoice
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM deleted d
        WHERE d.is_locked = 1
    )
    BEGIN
        RAISERROR ('Paid invoice cannot be modified', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

UPDATE invoice
SET subtotal = 50000
WHERE invoice_id = 201;

CREATE TABLE invoice_version (
version_id BIGINT IDENTITY(1,1) PRIMARY KEY,
invoice_id BIGINT NOT NULL,
version_number INT NOT NULL,
subtotal DECIMAL(12,2),
tax_amount DECIMAL(12,2),
extra_charges DECIMAL(12,2),
total_amount DECIMAL(12,2),
modified_date DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_invoice_versioning
ON invoice
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO invoice_version (
        invoice_id,
        version_number,
        subtotal,
        tax_amount,
        extra_charges,
        total_amount,
        modified_date
    )
    SELECT 
        d.invoice_id,
        d.version_num,
        d.subtotal,
        d.tax_amount,
        d.extra_charges,
        d.total_amount,
        GETDATE()
    FROM deleted d;
END;

UPDATE invoice
SET subtotal = 21000,
    version_num = version_num + 1
WHERE invoice_id = 202;

SELECT * FROM invoice;


INSERT INTO Customers1 VALUES
(6, 'Kiran', 'kiran@gmail.com', '9000000001', '2025-02-01', NULL);
INSERT INTO orderss VALUES
(106, 6, '2025-02-02', 'PLACED', '2025-02-02', NULL),
(107, 6, '2025-02-03', 'PLACED', '2025-02-03', NULL);

INSERT INTO invoice VALUES
(206, 6, 'INV-006', '2025-02-06', 10000, 1800, 200, 12000, 'PAID', 0, 1, '2025-02-06', NULL),
(207, 6, 'INV-007', '2025-02-06', 8000, 1440, 100, 9540, 'PARTIALLY_PAID', 0, 1, '2025-02-06', NULL);

UPDATE invoice SET is_locked=1 where invoice_id=206;

INSERT INTO shippment VALUES
(307, 106, 206, '2025-02-04', 1000, '2025-02-04', NULL),
(308, 107, 207, '2025-02-05', 800, '2025-02-05', NULL);

INSERT INTO Payment VALUES
(405, 6, 'PAY-005',20000, 'UPI', '2025-02-07', NULL,'2025-02-07');

INSERT INTO invoice_payment VALUES
(505, 405, 206, 12000, '2025-02-07'),
(506, 405, 207, 8000,  '2025-02-07');

INSERT INTO Customers1 VALUES
(7, 'Rahul', 'rahul@gmail.com', '9876500000', '2025-03-01', NULL);

INSERT INTO orderss VALUES
(108, 7, '2025-03-02', 'PLACED', '2025-03-02', NULL);

INSERT INTO invoice VALUES
(208,7, 'INV-008', '2025-03-05',12000, 2160, 500, 14660,'DRAFT', 0, 1, '2025-03-05', NULL);

INSERT INTO shippment VALUES
(309, 108, 208, '2025-03-03', 5000, '2025-03-03', NULL),
(310, 108, 208, '2025-03-04', 7000, '2025-03-04', NULL);


SELECT i.invoice_num ,s.shipment_date,s.shipment_cost 
FROM invoice i LEFT JOIN shippment s 
ON i.invoice_id=s.invoice_id;

SELECT p.payment_num ,inp.amount_applied 
FROM Payment p 
JOIN invoice_payment inp 
ON p.payment_id=inp.payment_id
WHERE inp.invoice_id=203;

SELECT invoice_num ,status 
FROM invoice 
WHERE status='PAID';

SELECT i.invoice_num ,i.total_amount,SUM(inp.amount_applied) as total_paid 
FROM invoice i 
JOIN invoice_payment inp 
ON i.invoice_id=inp.invoice_id
GROUP BY i.invoice_num,i.total_amount
HAVING i.total_amount =SUM(inp.amount_applied) ;

SELECT invoice_num,invoice_date ,total_amount 
FROM invoice
WHERE invoice_date BETWEEN '2025-01-05' AND '2025-01-10';

SELECT invoice_num, subtotal, tax_amount, extra_charges, total_amount
FROM invoice;