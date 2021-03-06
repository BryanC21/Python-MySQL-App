-- MySQL Script generated by MySQL Workbench
-- Thu Nov  5 14:53:20 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

-- SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
-- SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema HealthCareOrgDB
-- -----------------------------------------------------
-- DROP SCHEMA IF EXISTS `HealthCareOrgDB` ;

-- -----------------------------------------------------
-- Schema HealthCareOrgDB
-- -----------------------------------------------------
-- CREATE SCHEMA IF NOT EXISTS `HealthCareOrgDB` DEFAULT CHARACTER SET utf8 ;
USE `HealthCareOrgDB` ;

-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`Account` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`Account` (
  `account_id` INT NOT NULL AUTO_INCREMENT,
  `MembershipNumber` VARCHAR(20) NOT NULL,
  `DateCreated` DATE NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE INDEX `MembershipNumber_UNIQUE` (`MembershipNumber` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`HealthRecord`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`HealthRecord` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`HealthRecord` (
  `record_id` INT NOT NULL AUTO_INCREMENT,
  `PrimaryDoctorName` VARCHAR(45) NULL,
  `PreviousVisit` DATE NULL,
  PRIMARY KEY (`record_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`Patient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`Patient` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`Patient` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `DateOfBirth` DATE NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `PhoneNumber` VARCHAR(11) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Account` INT NULL,
  `HealthRecord` INT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `Patient_Account_FK_idx` (`Account` ASC) VISIBLE,
  INDEX `Patient_HealthRecord_FK_idx` (`HealthRecord` ASC) VISIBLE,
  CONSTRAINT `Patient_Account_FK`
    FOREIGN KEY (`Account`)
    REFERENCES `HealthCareOrgDB`.`Account` (`account_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Patient_HealthRecord_FK`
    FOREIGN KEY (`HealthRecord`)
    REFERENCES `HealthCareOrgDB`.`HealthRecord` (`record_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`GeneralAppointment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`GeneralAppointment` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`GeneralAppointment` (
  `general_id` INT NOT NULL AUTO_INCREMENT,
  `Reason` VARCHAR(200) NULL,
  PRIMARY KEY (`general_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`RoutineAppointment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`RoutineAppointment` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`RoutineAppointment` (
  `routine_id` INT NOT NULL AUTO_INCREMENT,
  `DatePreviousVisit` DATE NULL,
  PRIMARY KEY (`routine_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`Doctor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`Doctor` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`Doctor` (
  `doctor_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Title` VARCHAR(45) NULL,
  PRIMARY KEY (`doctor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`Appointments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`Appointments` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`Appointments` (
  `appointment_id` INT NOT NULL AUTO_INCREMENT,
  `Location` VARCHAR(60) NULL,
  `Time/Date` DATETIME NULL,
  `GeneralAppointment` INT NULL,
  `RoutineAppointment` INT NULL,
  `Patient` INT NULL,
  `Doctor` INT NULL,
  PRIMARY KEY (`appointment_id`),
  INDEX `Appointment_General_FK_idx` (`GeneralAppointment` ASC) VISIBLE,
  INDEX `Appointment_Routine_FK_idx` (`RoutineAppointment` ASC) VISIBLE,
  INDEX `Appointment_Doctor_FK_idx` (`Doctor` ASC) VISIBLE,
  INDEX `Appointment_Patient_FK_idx` (`Patient` ASC) VISIBLE,
  CONSTRAINT `Appointment_General_FK`
    FOREIGN KEY (`GeneralAppointment`)
    REFERENCES `HealthCareOrgDB`.`GeneralAppointment` (`general_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Appointment_Routine_FK`
    FOREIGN KEY (`RoutineAppointment`)
    REFERENCES `HealthCareOrgDB`.`RoutineAppointment` (`routine_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Appointment_Doctor_FK`
    FOREIGN KEY (`Doctor`)
    REFERENCES `HealthCareOrgDB`.`Doctor` (`doctor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Appointment_Patient_FK`
    FOREIGN KEY (`Patient`)
    REFERENCES `HealthCareOrgDB`.`Patient` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`Medication`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`Medication` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`Medication` (
  `medication_id` INT NOT NULL AUTO_INCREMENT,
  `Count` INT NOT NULL,
  `CountPerDay` TINYINT NULL,
  `DatePrescribed` DATE NULL,
  `Name` VARCHAR(45) NULL,
  `HealthRecord` INT NOT NULL,
  PRIMARY KEY (`medication_id`),
  INDEX `Medication_HealthRecord_FK_idx` (`HealthRecord` ASC) VISIBLE,
  CONSTRAINT `Medication_HealthRecord_FK`
    FOREIGN KEY (`HealthRecord`)
    REFERENCES `HealthCareOrgDB`.`HealthRecord` (`record_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`Messages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`Messages` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`Messages` (
  `message_id` INT NOT NULL AUTO_INCREMENT,
  `Message` VARCHAR(200) NULL,
  `Date/Time` DATETIME NULL,
  `Subject` VARCHAR(100) NULL,
  `Patient` INT NULL,
  `Doctor` INT NULL,
  PRIMARY KEY (`message_id`),
  INDEX `Message_Patient_FK_idx` (`Patient` ASC) VISIBLE,
  INDEX `Message_Doctor_FK_idx` (`Doctor` ASC) VISIBLE,
  CONSTRAINT `Message_Patient_FK`
    FOREIGN KEY (`Patient`)
    REFERENCES `HealthCareOrgDB`.`Patient` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Message_Doctor_FK`
    FOREIGN KEY (`Doctor`)
    REFERENCES `HealthCareOrgDB`.`Doctor` (`doctor_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`TestResults`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`TestResults` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`TestResults` (
  `test_id` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NULL,
  `Name` VARCHAR(45) NULL,
  `Comments` VARCHAR(100) NULL,
  `HealthRecord` INT NOT NULL,
  PRIMARY KEY (`test_id`),
  INDEX `TestResults_HealthRecord_FK_idx` (`HealthRecord` ASC) VISIBLE,
  CONSTRAINT `TestResults_HealthRecord_FK`
    FOREIGN KEY (`HealthRecord`)
    REFERENCES `HealthCareOrgDB`.`HealthRecord` (`record_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`MedicalCondition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`MedicalCondition` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`MedicalCondition` (
  `condition_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Date` DATE NULL,
  `HealthRecord` INT NOT NULL,
  PRIMARY KEY (`condition_id`),
  INDEX `MedicalCondition_HealthRecord_FK_idx` (`HealthRecord` ASC) VISIBLE,
  CONSTRAINT `MedicalCondition_HealthRecord_FK`
    FOREIGN KEY (`HealthRecord`)
    REFERENCES `HealthCareOrgDB`.`HealthRecord` (`record_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`License`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`License` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`License` (
  `license_id` INT NOT NULL AUTO_INCREMENT,
  `Type` VARCHAR(45) NULL,
  `DateReceived` DATE NULL,
  PRIMARY KEY (`license_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`Specialist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`Specialist` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`Specialist` (
  `specialist_id` INT NOT NULL AUTO_INCREMENT,
  `Type` VARCHAR(45) NULL,
  `Doctor` INT NOT NULL,
  `License` INT NULL,
  PRIMARY KEY (`specialist_id`, `Doctor`),
  INDEX `Specialist_Doctor_FK_idx` (`Doctor` ASC) VISIBLE,
  INDEX `Specialist_License_FK_idx` (`License` ASC) VISIBLE,
  CONSTRAINT `Specialist_Doctor_FK`
    FOREIGN KEY (`Doctor`)
    REFERENCES `HealthCareOrgDB`.`Doctor` (`doctor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Specialist_License_FK`
    FOREIGN KEY (`License`)
    REFERENCES `HealthCareOrgDB`.`License` (`license_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`HealthCareOrganization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`HealthCareOrganization` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`HealthCareOrganization` (
  `org_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  PRIMARY KEY (`org_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`Emergency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`Emergency` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`Emergency` (
  `emergency_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `HealthCareOrg` INT NULL,
  PRIMARY KEY (`emergency_id`),
  INDEX `Emergency_HealthCareOrganization_FK_idx` (`HealthCareOrg` ASC) VISIBLE,
  CONSTRAINT `Emergency_HealthCareOrganization_FK`
    FOREIGN KEY (`HealthCareOrg`)
    REFERENCES `HealthCareOrgDB`.`HealthCareOrganization` (`org_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`EmergencyCareLine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`EmergencyCareLine` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`EmergencyCareLine` (
  `e_line_id` INT NOT NULL AUTO_INCREMENT,
  `Reason` VARCHAR(100) NULL,
  `PriorityLevel` TINYINT NULL,
  `Patient` INT NOT NULL,
  `Department` INT NULL,
  PRIMARY KEY (`e_line_id`),
  INDEX `EmergencyCareLine_Patient_FK_idx` (`Patient` ASC) VISIBLE,
  INDEX `EmergencyCareLine_Department_FK_idx` (`Department` ASC) VISIBLE,
  CONSTRAINT `EmergencyCareLine_Patient_FK`
    FOREIGN KEY (`Patient`)
    REFERENCES `HealthCareOrgDB`.`Patient` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `EmergencyCareLine_Department_FK`
    FOREIGN KEY (`Department`)
    REFERENCES `HealthCareOrgDB`.`Emergency` (`emergency_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`UrgentCare`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`UrgentCare` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`UrgentCare` (
  `urgentcare_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `HealthCareOrg` INT NULL,
  PRIMARY KEY (`urgentcare_id`),
  INDEX `UrgentCare_HealthCareOrganization_FK_idx` (`HealthCareOrg` ASC) VISIBLE,
  CONSTRAINT `UrgentCare_HealthCareOrganization_FK`
    FOREIGN KEY (`HealthCareOrg`)
    REFERENCES `HealthCareOrgDB`.`HealthCareOrganization` (`org_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`UrgentCareLine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`UrgentCareLine` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`UrgentCareLine` (
  `u_line_id` INT NOT NULL AUTO_INCREMENT,
  `Reason` VARCHAR(100) NULL,
  `DateTimeArrived` DATETIME NULL,
  `Patient` INT NOT NULL,
  `Department` INT NULL,
  PRIMARY KEY (`u_line_id`),
  INDEX `UrgentCareLine_Patient_FK_idx` (`Patient` ASC) VISIBLE,
  INDEX `UrgentCareLine_Department_FK_idx` (`Department` ASC) VISIBLE,
  CONSTRAINT `UrgentCareLine_Patient_FK`
    FOREIGN KEY (`Patient`)
    REFERENCES `HealthCareOrgDB`.`Patient` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `UrgentCareLine_Department_FK`
    FOREIGN KEY (`Department`)
    REFERENCES `HealthCareOrgDB`.`UrgentCare` (`urgentcare_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`Employee` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`Employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Title` VARCHAR(45) NULL,
  `HealthCareOrg` INT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `Employee_HealthCareOrganization_FK_idx` (`HealthCareOrg` ASC) VISIBLE,
  CONSTRAINT `Employee_HealthCareOrganization_FK`
    FOREIGN KEY (`HealthCareOrg`)
    REFERENCES `HealthCareOrgDB`.`HealthCareOrganization` (`org_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`Pharmacy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`Pharmacy` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`Pharmacy` (
  `pharmacy_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `HealthCareOrg` INT NULL,
  PRIMARY KEY (`pharmacy_id`),
  INDEX `Pharmacy_HealthCareOrganization_FK_idx` (`HealthCareOrg` ASC) VISIBLE,
  CONSTRAINT `Pharmacy_HealthCareOrganization_FK`
    FOREIGN KEY (`HealthCareOrg`)
    REFERENCES `HealthCareOrgDB`.`HealthCareOrganization` (`org_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthCareOrgDB`.`Lab`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HealthCareOrgDB`.`Lab` ;

CREATE TABLE IF NOT EXISTS `HealthCareOrgDB`.`Lab` (
  `lab_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `HealthCareOrg` INT NULL,
  PRIMARY KEY (`lab_id`),
  INDEX `Lab_HealthCareOrganization_FK_idx` (`HealthCareOrg` ASC) VISIBLE,
  CONSTRAINT `Lab_HealthCareOrganization_FK`
    FOREIGN KEY (`HealthCareOrg`)
    REFERENCES `HealthCareOrgDB`.`HealthCareOrganization` (`org_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
