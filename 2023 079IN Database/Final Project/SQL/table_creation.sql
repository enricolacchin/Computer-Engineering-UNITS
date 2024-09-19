
-- DROP (if already exists), CREATE AND USE of the new database
/* ---------------------------------------------------
DROP DATABASE IF EXISTS enricolac_progettoBasiDiDati;
CREATE DATABASE enricolac_progettoBasiDiDati;
---------------------------------------------------- */
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
