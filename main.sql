#Drop tables if exist
DROP TABLE IF EXISTS maintenance_log;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS snack_purchase;
DROP TABLE IF EXISTS snack_bar;
DROP TABLE IF EXISTS dependents;
DROP TABLE IF EXISTS weight_class;
DROP TABLE IF EXISTS cardio_class;
DROP TABLE IF EXISTS water_class;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS manager;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS bronze_members;
DROP TABLE IF EXISTS gold_members;
DROP TABLE IF EXISTS platinum_members;



#Tables
CREATE TABLE members(
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    birth_date DATE,
    phone_num VARCHAR(15) UNIQUE,
    membership_type VARCHAR(10) NOT NULL,
    dependents BOOL DEFAULT FALSE
);

CREATE TABLE dependents(
    main_member_id INT NOT NULL,
    dependent_id INT,
    name VARCHAR(30),
    birth_date DATE,
    relationship VARCHAR(20),
    PRIMARY KEY(main_member_id, dependent_id),
    FOREIGN KEY(main_member_id) REFERENCES members(member_id)
);

CREATE TABLE bronze_members(
    member_id INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    monthly_fee DECIMAL(9,2) DEFAULT 10.00
);

CREATE TABLE gold_members(
    member_id INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    monthly_fee DECIMAL(9,2) DEFAULT 20.00
);

CREATE TABLE platinum_members(
    member_id INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    monthly_fee DECIMAL(9,2) DEFAULT 30.00
);

CREATE TABLE equipment (
    serial_number VARCHAR(20) PRIMARY KEY,
    name VARCHAR(40),
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

CREATE TABLE weight_class (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    instructor VARCHAR(40),
    schedule VARCHAR(40),
    class_name VARCHAR(40),
    member_id INT,
    FOREIGN KEY(member_id) REFERENCES members(member_id)
);

CREATE TABLE cardio_class (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    instructor VARCHAR(40),
    schedule VARCHAR(40),
    class_name VARCHAR(40),
    member_id INT,
    FOREIGN KEY(member_id) REFERENCES members(member_id)
);

CREATE TABLE water_class (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    instructor VARCHAR(40),
    schedule VARCHAR(40),
    class_name VARCHAR(40),
    member_id INT,
    FOREIGN KEY(member_id) REFERENCES members(member_id)
);

CREATE TABLE employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    emp_role VARCHAR(40)
);

CREATE TABLE manager (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    emp_role VARCHAR(40)
);

#Queries
INSERT INTO members (`first_name`, `last_name`, `birth_date`, `phone_num`, `membership_type`, `dependents`)
VALUES  ("Joe", "Zink", "2001-11-05", "1234567890", "platinum", TRUE),
        ("Eric", "Kim", "2002-12-06", "0987654321", "gold", FALSE),
        ("David", "Doig", "2003-10-04", "1122734455", "bronze", TRUE),
        ("Alice", "Smith", "2004-01-01", "2233445566", "bronze", TRUE),
        ("Bob", "Brown", "2005-02-02", "3344556677", "gold", FALSE),
        ("Charlie", "Johnson", "2006-03-03", "4455667788", "platinum", TRUE),
        ("Diana", "Prince", "2007-04-04", "5566778899", "gold", FALSE),
        ("Eve", "Adams", "2008-05-05", "6677889900", "bronze", TRUE),
        ("Frank", "Miller", "2009-06-06", "7788990011", "platinum", FALSE),
        ("Grace", "Lee", "2010-07-07", "8899001122", "gold", TRUE),
        ("Hannah", "Thornock", "2011-08-08", "9900112233", "bronze", FALSE),
        ("Ian", "White", "2012-09-09", "0011223344", "platinum", TRUE),
        ("Jack", "Black", "2013-10-10", "1122334455", "gold", FALSE),
        ("Kathy", "Green", "2014-11-11", "2233455566", "bronze", TRUE),
        ("Liam", "Blue", "2015-12-12", "3314556677", "platinum", FALSE),
        ("Mia", "Red", "2016-01-13", "4455661788", "gold", TRUE),
        ("Noah", "Yellow", "2017-02-14", "5566178899", "bronze", FALSE),
        ("Olivia", "Purple", "2018-03-15", "6677819900", "platinum", TRUE),
        ("Paul", "Orange", "2019-04-16", "7788910011", "gold", FALSE),
        ("Quinn", "Pink", "2020-05-17", "8899005122", "bronze", TRUE),
        ("Rita", "Gray", "2021-06-18", "9900112133", "platinum", FALSE),
        ("Sam", "Brown", "2022-07-19", "0011223544", "gold", TRUE),
        ("Tina", "White", "2023-08-20", "1122337455", "bronze", FALSE);

INSERT INTO dependents (`main_member_id`, `dependent_id`, `name`, `birth_date`, `relationship`)
VALUES  (1, 1, "Hannah Thornock", "2004-01-07", "Girlfriend"),
        (1, 2, "John Doe", "2005-02-08", "Brother"),
        (1, 3, "Jane Doe", "2006-03-09", "Sister"),
        (3, 1, "Alice Smith", "2007-04-10", "Daughter"),
        (3, 2, "Bob Brown", "2008-05-11", "Son"),
        (4, 1, "Charlie Johnson", "2009-06-12", "Son"),
        (6, 1, "Diana Prince", "2010-07-13", "Daughter"),
        (6, 2, "Eve Adams", "2011-08-14", "Sister"),
        (8, 1, "Frank Miller", "2012-09-15", "Brother"),
        (8, 2, "Grace Lee", "2013-10-16", "Cousin"),
        (10, 1, "Hannah Thornock", "2014-11-17", "Friend"),
        (10, 2, "Ian White", "2015-12-18", "Cousin"),
        (12, 1, "Jack Black", "2016-01-19", "Brother"),
        (12, 2, "Kathy Green", "2017-02-20", "Sister"),
        (14, 1, "Liam Blue", "2018-03-21", "Son"),
        (14, 2, "Mia Red", "2019-04-22", "Daughter"),
        (16, 1, "Noah Yellow", "2020-05-23", "Son"),
        (16, 2, "Olivia Purple", "2021-06-24", "Daughter"),
        (18, 1, "Paul Orange", "2022-07-25", "Brother"),
        (18, 2, "Quinn Pink", "2023-08-26", "Sister"),
        (20, 1, "Rita Gray", "2024-09-27", "Cousin"),
        (20, 2, "Sam Brown", "2025-10-28", "Friend"),
        (22, 1, "Tina White", "2026-11-29", "Sister"),
        (22, 2, "Zoe Black", "2027-12-30", "Daughter");

INSERT INTO equipment (`serial_number`, `name`, `location`)
VALUES  ("EQ12345", "Treadmill", "Cardio Room"),
        ("EQ12346", "Elliptical", "Cardio Room"),
        ("EQ12347", "Weight Machine", "Strength Room"),
        ("EQ12348", "Yoga Mat", "Yoga Room"),
        ("EQ12349", "Pool Filter", "Swimming Pool"),
        ("EQ12350", "Spin Bike", "Cycling Room"),
        ("EQ12351", "Free Weights Set", "Strength Room"),
        ("EQ12352", "Stretching Mat", "Stretching Area");

INSERT INTO maintenance_log (`serial_number`, `date`, `description`, `technician`)
VALUES  ("EQ12345", "2023-01-01", "Treadmill calibration and belt adjustment", "John Smith"),
        ("EQ12346", "2023-01-02", "Elliptical software update", "Jane Doe"),
        ("EQ12347", "2023-01-03", "Weight machine lubrication", "Mike Johnson"),
        ("EQ12348", "2023-01-04", "Yoga mat replacement", "Sarah Brown"),
        ("EQ12349", "2023-01-05", "Pool filter cleaning and maintenance", "Tom White"),
        ("EQ12350", "2023-01-06", "Spin bike resistance check", "Emily Green"),
        ("EQ12351", "2023-01-07", "Free weights inventory and organization", "Chris Black"),
        ("EQ12352", "2023-01-08", "Stretching mat cleaning and inspection", "Anna Blue");

INSERT INTO snack_bar (`product_name`, `price`, `quantity`)
VALUES  ("Protein Bar", 2.50, 100),
        ("Energy Drink", 3.00, 50),
        ("Water Bottle", 1.00, 200),
        ("Snack Pack", 4.00, 75),
        ("Fruit Smoothie", 5.00, 30),
        ("Granola Bar", 2.00, 120),
        ("Chocolate Bar", 1.50, 80),
        ("Trail Mix", 3.50, 60),
        ("Yogurt Cup", 2.75, 90),
        ("Veggie Chips", 2.25, 110);
INSERT INTO snack_purchase (`member_id`, `product_id`, `quantity`, `total_price`, `purchase_date`)
VALUES  (1, 1, 2, 5.00, "2023-01-02"),
        (2, 2, 1, 3.00, "2023-01-03"),
        (3, 3, 5, 5.00, "2023-01-04"),
        (4, 4, 3, 12.00, "2023-01-05"),
        (5, 5, 2, 10.00, "2023-01-06"),
        (6, 6, 4, 8.00, "2023-01-07"),
        (7, 7, 1, 1.50, "2023-01-08"),
        (8, 8, 6, 21.00, "2023-01-09"),
        (9, 9, 2, 5.50, "2023-01-10"),
        (10, 10, 1, 2.25, "2023-01-11");

INSERT INTO bronze_members (`member_id`, first_name, last_name)
SELECT member_id, first_name, last_name
FROM members
WHERE membership_type = "bronze";

INSERT INTO gold_members (`member_id`, first_name, last_name)
SELECT member_id, first_name, last_name
FROM members
WHERE membership_type = "gold";

INSERT INTO platinum_members (`member_id`, first_name, last_name)
SELECT member_id, first_name, last_name
FROM members
WHERE membership_type = "platinum";

SELECT * FROM members;
SELECT * FROM dependents;
SELECT * FROM bronze_members;
SELECT * FROM gold_members;
SELECT * FROM platinum_members;
SELECT * FROM equipment;
SELECT * FROM maintenance_log;
SELECT * FROM snack_bar;
SELECT * FROM snack_purchase;
