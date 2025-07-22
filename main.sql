#Drop tables if exist
DROP TABLE IF EXISTS maintenance_log;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS snack_purchase;
DROP TABLE IF EXISTS snack_bar;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS dependents;

#Tables
CREATE TABLE memberships(
    membership_type_id INT PRIMARY KEY NOT NULL,
    membership_status VARCHAR(10),
    price DECIMAL(9,2)
);

CREATE TABLE dependents(
    dependent_id INT PRIMARY KEY,
    dependent_rank INT,
    relationship VARCHAR(20)
);

CREATE TABLE members(
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    BirthDate DATE,
    PhoneNum VARCHAR(15),
    membership_type_id INT NOT NULL,
    dependents BOOL,
    FOREIGN KEY(membership_type_id) REFERENCES memberships(membership_type_id),
    FOREIGN KEY(member_id) REFERENCES dependents(dependent_id)
    );

CREATE TABLE equipment (
    serial_number VARCHAR(20) PRIMARY KEY,
    location VARCHAR(20)
);

CREATE TABLE maintenance_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    serial_number VARCHAR(20),
    date DATE,
    description VARCHAR(100),
    technician VARCHAR(30),
    FOREIGN KEY(serial_number) REFERENCES equipment(serial_number)
);

CREATE TABLE snack_bar (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(40),
    price DECIMAL(10,2),
    quantity INT
);

CREATE TABLE snack_purchase (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10,2),
    purchase_date DATE,
    FOREIGN KEY(member_id) REFERENCES members(member_id),
    FOREIGN KEY(product_id) REFERENCES snack_bar(product_id)
);


#Queries
INSERT INTO memberships
VALUES (1, "Bronze", 19.99),
    (2, "Gold", 49.99),
    (3, "Plainum", 89.99);

SELECT * FROM memberships