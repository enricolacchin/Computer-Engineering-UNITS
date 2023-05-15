USE enricolac_progettoBasiDiDati;

-- FILTERS DISABLE --
/*!40101 SET NAMES utf8 */;
/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- TABLE CREATION --
DROP TABLE IF EXISTS offices;
CREATE TABLE offices(
  officeCode INT(4) PRIMARY KEY AUTO_INCREMENT,
  country varchar(45),
  city varchar(45),
  address varchar(100),
  postalCode INT(7),
  phone INT(13),
  mail varchar(100) DEFAULT 'info@domain.com'
);

DROP TABLE IF EXISTS departments;
CREATE TABLE departments(
    depName varchar(50) PRIMARY KEY,
    manager INT(4),
    office INT(4),
    FOREIGN KEY (manager) REFERENCES employees(employeeID),
    FOREIGN KEY (office) REFERENCES offices(officeCode)
);

DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
    employeeID INT(4) PRIMARY KEY AUTO_INCREMENT,
    firstName varchar(20) NOT NULL,
    lastName varchar(20) NOT NULL,
    jobTitle varchar(50) DEFAULT NULL,
    phone int(13),
    mail varchar(100),
    reportsTo int(10),
    BOD char(1) DEFAULT 'F' CHECK(BOD IN ('T','F')),
    FOREIGN KEY (reportsTo) REFERENCES employees(employeeID)
);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
  customerID INT(5) PRIMARY KEY AUTO_INCREMENT,
  name varchar(45) NOT NULL,
  department varchar(50),
  status char(30) CHECK(status IN ('Ongoing Negotiation', 'Agreed', 'In Progress', 'Done')),
  agreementDeadline DATE,
  address varchar(100),
  phone INT(13),
  mail varchar(100),
  website varchar(100),
  inChargeOf INT(4),
  FOREIGN KEY (department) REFERENCES departments(depName),
  FOREIGN KEY (inChargeOf) REFERENCES employees(employeeID)
);

DROP TABLE IF EXISTS suppliers;
CREATE TABLE suppliers(
   supplierID INT(5) PRIMARY KEY AUTO_INCREMENT,
   name varchar(50) NOT NULL,
   department varchar(50) NOT NULL,
   address varchar(100),
   phone INT(13),
   mail varchar(100),
   website varchar(100),
   vatNumber INT(20),
   FOREIGN KEY (department) REFERENCES departments(depName)
);

DROP TABLE IF EXISTS collaborators;
CREATE TABLE collaborators(
   collaboratorID INT(5) PRIMARY KEY AUTO_INCREMENT,
   name varchar(50) NOT NULL,
   department varchar(50) NOT NULL,
   job varchar(50) NOT NULL,
   phone INT(13),
   mail varchar(100),
   website varchar(100),
   vatNumber INT(20),
  FOREIGN KEY (department) REFERENCES departments(depName)
);

DROP TABLE IF EXISTS invoices;
CREATE TABLE invoices(
    invoiceID INT(6) PRIMARY KEY AUTO_INCREMENT,
    status varchar(10) NOT NULL CHECK (status IN ('Draft', 'Not Paid', 'Paid')),
    issuedDate DATE,
    amount INT(8)
);

DROP TABLE IF EXISTS projects;
CREATE TABLE projects(
    name varchar(100) PRIMARY KEY,
    department varchar(50) NOT NULL,
    projectDate DATE,
    invoice INT(6) DEFAULT NULL,
    client INT(5) NOT NULL,
    FOREIGN KEY (department) REFERENCES departments(depName),
    FOREIGN KEY (invoice) REFERENCES invoices(invoiceID),
    FOREIGN KEY (client) REFERENCES customers(customerID)
);

-- N-N RELATIONS --
DROP TABLE IF EXISTS suppliersRequire;
CREATE TABLE suppliersRequire(
  projectName varchar(100),
  supplierID INT(5),
  PRIMARY KEY(projectName, supplierID),
  FOREIGN KEY (projectName) REFERENCES projects(name),
  FOREIGN KEY (supplierID) REFERENCES suppliers(supplierID)
);

DROP TABLE IF EXISTS employeesAfference;
CREATE TABLE employeesAfference(
  employeeID INT(4),
  departmentName varchar(50),
  PRIMARY KEY (employeeID, departmentName),
  FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
  FOREIGN KEY (departmentName) REFERENCES departments(depName)
);

-- FILTERS RE-ENABLE --
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


-- TABLE OFFICES
INSERT INTO offices VALUES (NULL, 'Italy', 'Bolzano', 'p.zza Walther 1', '39100', 1234567890, 'bolzano@domain.com');
INSERT INTO offices VALUES (NULL, 'Italy', 'Triest', 'p.zza Unita d''Italia 1', '34121', 1234567890, 'triest@domain.com');
INSERT INTO offices VALUES (NULL, 'Italy', 'Trient', 'p.zza Duomo 1', '38000', 1234567890, 'trient@domain.com');
INSERT INTO offices VALUES (NULL, 'Italy', 'Naples', 'p.zza del Plebiscito 1', '80013', 1234567890, 'naples@domain.com');
INSERT INTO offices VALUES (NULL, 'USA', 'Miami', 'Brickell Bay', '1100', 1234567890, 'miami@domain.com');
INSERT INTO offices VALUES (NULL, 'NMK', 'Tetovo', 'Tetovo Square', '1200', 1234567890, 'tetovo@domain.com');
INSERT INTO offices VALUES (NULL, 'CH', 'Zurich', 'Bahnhofstrasse', '8000', 1234567890, 'zurich@domain.com');


-- TABLE DEPARTMENTS
INSERT INTO departments VALUES ('Aviation', NULL, 5);
INSERT INTO departments VALUES ('IT & Digital', NULL, 2);
INSERT INTO departments VALUES ('SoMe', NULL, 2);
INSERT INTO departments VALUES ('Talent Management', NULL, 3);
INSERT INTO departments VALUES ('Marketing', NULL, 1);
INSERT INTO departments VALUES ('Graphic Design', NULL, 6);
INSERT INTO departments VALUES ('Photo & Video', NULL, 6);
INSERT INTO departments VALUES ('Legal', NULL, 4);

-- TABLE EMPLOYEES
INSERT INTO employees VALUES (NULL, 'John', 'Doe', 'CEO', 1234567890, 'doe@domain.com', NULL, 'T');
INSERT INTO employees VALUES (NULL, 'Cristina', 'Rodriguez', 'CDO', 1234567890, 'rodriguez@domain.com', NULL, 'T');
INSERT INTO employees VALUES (NULL, 'Richard', 'Pique', 'Executive Operations Supervisor', 1234567890, 'pique@domain.com', NULL, 'T');
INSERT INTO employees VALUES (NULL, 'Christian', 'Morrison', 'Team Leader', 1234567890, 'morrison@domain.com', NULL, 'F');
INSERT INTO employees VALUES (NULL, 'Liam', 'Smith', 'Marketing Manager', 1234567890, 'smith@domain.com', NULL, 'F');
INSERT INTO employees VALUES (NULL, 'James', 'Williams', 'Graphic Designer', 1234567890, 'williams@domain.com', NULL, 'F');
INSERT INTO employees VALUES (NULL, 'Richard', 'Johnson', 'Lawyer', 1234567890, 'johnson@domain.com', NULL, 'T');

-- TABLE EMPLOYEES AFFERENCE
INSERT INTO employeesAfference VALUES (1, 'Aviation');
INSERT INTO employeesAfference VALUES (1, 'Marketing');
INSERT INTO employeesAfference VALUES (2, 'IT & Digital');
INSERT INTO employeesAfference VALUES (2, 'SoMe');
INSERT INTO employeesAfference VALUES (3, 'Talent Management');
INSERT INTO employeesAfference VALUES (4, 'IT & Digital');
INSERT INTO employeesAfference VALUES (5, 'Marketing');
INSERT INTO employeesAfference VALUES (6, 'Graphic Design');
INSERT INTO employeesAfference VALUES (7, 'Legal');

-- TABLE COLLABORATORS
INSERT INTO collaborators VALUES (NULL, 'Eric Rosen', 'IT & Digital', 'Graphic Designer', 1234567890 , 'rosen@domain.com', NULL, 0123456);
INSERT INTO collaborators VALUES (NULL, 'Magnus Carlsen', 'Aviation', 'Broker Cargo', 1234567890 , 'carlsen@domain.com', NULL, 0123456);
INSERT INTO collaborators VALUES (NULL, 'Hikaru Nakamura', 'It & Digital', 'Social Media Manager', 1234567890 , 'nakamura@domain.com', NULL, 0123456);

-- TABLE CUSTOMERS
INSERT INTO customers VALUES (NULL, 'Università di Trieste', 'SoMe', 'In Progress', '2023-12-31', 'Piazzale Europa 1', 040123456, 'info@units.it', 'units.it', 3);
INSERT INTO customers VALUES (NULL, 'Camera di Commecio IT in Svizzera', 'SoMe', 'Ongoing Negotiation' , NULL, 'Zurich', 987654321, 'info@cameradicommercio.ch', 'cameradicommercio.ch', 2);
INSERT INTO customers VALUES (NULL, 'GOV USA', 'Aviation', 'In Progress', '2025-12-31', 'Washington DC', 123456789, 'usa@gov.com', 'usa.gov.com', 2);
INSERT INTO customers VALUES (NULL, 'Kim Kardashian', 'Talent Management', 'Agreed', '2024-12-31', NULL , NULL, 'kim@kardashian.com', 'kardashian.com', 4);
INSERT INTO customers VALUES (NULL, 'Lambo Cars', 'SoMe', 'Agreed', '2024-06-30', 'Sant''Agata Bolognese', NULL, 'info@lambocars.com', 'lambocars.it', 2);

-- TABLE SUPPLIERS
INSERT INTO suppliers VALUES (NULL, 'Tim Cook', 'Photo & Video', 'Cupertino', 123456789, 'tim@cook.com', 'cook.com', 'US1234567');
INSERT INTO suppliers VALUES (NULL, 'John Elkan', 'Marketing', 'Turin', 123456789, 'john@elkan.com', 'elkan.com', 'IT1234567');
INSERT INTO suppliers VALUES (NULL, 'JetOps', 'Aviation', 'Miami', 123456789, 'info@jetops.com', 'jetops.com', 'US7654321');
INSERT INTO suppliers VALUES (NULL, 'John F. Kennedy', 'Photo & Video', 'Washington DC', 123456789, 'johnf@kennedy.com', 'kennedy.com', 'US3456789');

-- TABLE INVOICES
INSERT INTO invoices VALUES(NULL, 'Not Paid', '2023-02-20', 3000);
INSERT INTO invoices VALUES(NULL, 'Paid', '2023-01-05', 100000);

-- TABLE PROJECT
INSERT INTO projects VALUES ('Event 2023-02-18', 'Marketing', '2023-02-18', 1, 5);
INSERT INTO projects VALUES ('Flight JFK-VCE-CDG-JFK', 'Aviation', '2023-01-01', 2, 3);
INSERT INTO projects VALUES ('Annual Meeting', 'SoMe', '2023-08-12', NULL, 2);

-- TABLE SUPPLIERS REQUIRE
INSERT INTO suppliersRequire VALUES('Flight JFK-VCE-CDG-JFK', 3);
INSERT INTO suppliersRequire VALUES('Annual Meeting', 2);
INSERT INTO suppliersRequire VALUES('Annual Meeting', 4);

-- TABLE DEPARTMENTS MANAGER UPDATE
UPDATE departments SET manager = 1 WHERE depName = 'Aviation';
UPDATE departments SET manager = 2 WHERE depName = 'IT & Digital' OR depName = 'SoMe';
UPDATE departments SET manager = 3 WHERE depName = 'Talent Management';
UPDATE departments SET manager = 5 WHERE depName = 'Marketing';
UPDATE departments SET manager = 6 WHERE depName = 'Graphic Design' OR depName = 'Photo & Video';
UPDATE departments SET manager = 7 WHERE depName = 'Legal';

UPDATE employees SET reportsTo = NULL WHERE jobTitle = 'CEO';
UPDATE employees SET reportsTo = 1 WHERE employeeID = 2 OR employeeID = 3 OR employeeID = 5 OR employeeID = 7;
UPDATE employees SET reportsTo = 2 WHERE employeeID = 4 OR employeeID = 6;