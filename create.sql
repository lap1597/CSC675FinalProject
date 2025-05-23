-- MySQL Script generated by MySQL Workbench
-- Wed Apr 16 11:23:04 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`People`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`People` ;

CREATE TABLE IF NOT EXISTS `mydb`.`People` (
                                               `personID` INT NOT NULL,
                                               `Name` VARCHAR(45) NOT NULL,
                                               `Job_Type` VARCHAR(45) NOT NULL,
                                               PRIMARY KEY (`personID`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Content/Show`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Content/Show` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Content/Show` (
                                                     `content_Id` INT NOT NULL,
                                                     `Rating` VARCHAR(20) NOT NULL,
                                                     `Show_Name` VARCHAR(45) NOT NULL,
                                                     `Watch_History` INT NOT NULL,
                                                     `Release_year` INT NOT NULL,
                                                     `Description` VARCHAR(256) NOT NULL,
                                                     PRIMARY KEY (`content_Id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Employees` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Employees` (
                                                  `personId` INT NOT NULL,
                                                  `contentId` INT NOT NULL,
                                                  `date_started` DATE NOT NULL,
                                                  `salary` INT NOT NULL,
                                                  INDEX `FK_employee_people_idx` (`personId` ASC) VISIBLE,
                                                  INDEX `FK_employee_content_idx` (`contentId` ASC) VISIBLE,
                                                  CONSTRAINT `FK_employee_people`
                                                      FOREIGN KEY (`personId`)
                                                          REFERENCES `mydb`.`People` (`personID`)
                                                          ON DELETE CASCADE
                                                          ON UPDATE CASCADE,
                                                  CONSTRAINT `FK_employee_content`
                                                      FOREIGN KEY (`contentId`)
                                                          REFERENCES `mydb`.`Content/Show` (`content_Id`)
                                                          ON DELETE CASCADE
                                                          ON UPDATE CASCADE)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Review` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Review` (
                                               `review_id` INT NOT NULL,
                                               `content_id` INT NOT NULL,
                                               `Review_Description` VARCHAR(45) NOT NULL,
                                               `date_added` DATE NOT NULL,
                                               PRIMARY KEY (`review_id`, `content_id`),
                                               INDEX `FK_review_content_idx` (`content_id` ASC) VISIBLE,
                                               CONSTRAINT `FK_review_content`
                                                   FOREIGN KEY (`content_id`)
                                                       REFERENCES `mydb`.`Content/Show` (`content_Id`)
                                                       ON DELETE CASCADE
                                                       ON UPDATE CASCADE)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Availability`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Availability` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Availability` (
                                                     `availability_id` INT NOT NULL,
                                                     `Platform` VARCHAR(45) NOT NULL,
                                                     PRIMARY KEY (`availability_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Genre` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Genre` (
                                              `genre_id` INT NOT NULL,
                                              `genre_name` VARCHAR(45) NOT NULL,
                                              PRIMARY KEY (`genre_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Format`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Format` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Format` (
                                               `Format_id` INT NOT NULL,
                                               `Format_type` VARCHAR(45) NOT NULL,
                                               PRIMARY KEY (`Format_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Accessability`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Accessability` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Accessability` (
                                                      `accessability_id` INT NOT NULL,
                                                      `language` VARCHAR(45) NOT NULL,
                                                      `captions` TINYINT NOT NULL,
                                                      PRIMARY KEY (`accessability_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Country` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Country` (
                                                `country_id` INT NOT NULL,
                                                `country_name` VARCHAR(45) NULL,
                                                PRIMARY KEY (`country_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Metadata` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Metadata` (
                                                 `content_id` INT NOT NULL,
                                                 `availability_id` INT NOT NULL,
                                                 `country_id` INT NOT NULL,
                                                 `accessability_id` INT NOT NULL,
                                                 `TotalCountry` INT NOT NULL,
                                                 `TotalPlatform` INT NOT NULL,
                                                 `TotalGenre` INT NOT NULL,
                                                 `TotalLanguages` INT NOT NULL,
                                                 `TotalFormat` INT NOT NULL,
                                                 `Format_id` INT NOT NULL,
                                                 `genre_id` INT NOT NULL,
                                                 `country_name` VARCHAR(45) NOT NULL,
                                                 INDEX `FK_meta_content_idx` (`content_id` ASC) VISIBLE,
                                                 INDEX `FK_meta_availability_idx` (`availability_id` ASC) VISIBLE,
                                                 INDEX `FK_meta_country_idx` (`country_id` ASC) VISIBLE,
                                                 INDEX `FK_meta_accessability_idx` (`accessability_id` ASC) VISIBLE,
                                                 INDEX `FK_meta_genre_idx` (`genre_id` ASC) VISIBLE,
                                                 INDEX `FK_meta_formta_idx` (`Format_id` ASC) VISIBLE,
                                                 CONSTRAINT `FK_meta_content`
                                                     FOREIGN KEY (`content_id`)
                                                         REFERENCES `mydb`.`Content/Show` (`content_Id`)
                                                         ON DELETE CASCADE
                                                         ON UPDATE CASCADE,
                                                 CONSTRAINT `FK_meta_availability`
                                                     FOREIGN KEY (`availability_id`)
                                                         REFERENCES `mydb`.`Availability` (`availability_id`)
                                                         ON DELETE CASCADE
                                                         ON UPDATE CASCADE,
                                                 CONSTRAINT `FK_meta_country`
                                                     FOREIGN KEY (`country_id`)
                                                         REFERENCES `mydb`.`Country` (`country_id`)
                                                         ON DELETE CASCADE
                                                         ON UPDATE CASCADE,
                                                 CONSTRAINT `FK_meta_accessability`
                                                     FOREIGN KEY (`accessability_id`)
                                                         REFERENCES `mydb`.`Accessability` (`accessability_id`)
                                                         ON DELETE CASCADE
                                                         ON UPDATE CASCADE,
                                                 CONSTRAINT `FK_meta_genre`
                                                     FOREIGN KEY (`genre_id`)
                                                         REFERENCES `mydb`.`Genre` (`genre_id`)
                                                         ON DELETE CASCADE
                                                         ON UPDATE CASCADE,
                                                 CONSTRAINT `FK_meta_formta`
                                                     FOREIGN KEY (`Format_id`)
                                                         REFERENCES `mydb`.`Format` (`Format_id`)
                                                         ON DELETE CASCADE
                                                         ON UPDATE CASCADE)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User` ;

CREATE TABLE IF NOT EXISTS `mydb`.`User` (
                                             `user_id` INT NOT NULL,
                                             `User_name` VARCHAR(45) NOT NULL,
                                             `Date_of_birth` DATE NOT NULL,
                                             `Gender` VARCHAR(45) NOT NULL,
                                             PRIMARY KEY (`user_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`WatchList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`WatchList` ;

CREATE TABLE IF NOT EXISTS `mydb`.`WatchList` (
                                                  `Watchlist_id` INT NOT NULL,
                                                  `user_id` INT NOT NULL,
                                                  `content_id` INT NOT NULL,
                                                  `number_of_shows` INT NOT NULL,
                                                  `WatchList_name` VARCHAR(45) NOT NULL,
                                                  `date_created` DATE NOT NULL,
                                                  PRIMARY KEY (`Watchlist_id`),
                                                  INDEX `FK_watchlist_user_idx` (`user_id` ASC) VISIBLE,
                                                  INDEX `FK_watchlist_content_idx` (`content_id` ASC) VISIBLE,
                                                  CONSTRAINT `FK_watchlist_user`
                                                      FOREIGN KEY (`user_id`)
                                                          REFERENCES `mydb`.`User` (`user_id`)
                                                          ON DELETE CASCADE
                                                          ON UPDATE CASCADE,
                                                  CONSTRAINT `FK_watchlist_content`
                                                      FOREIGN KEY (`content_id`)
                                                          REFERENCES `mydb`.`Content/Show` (`content_Id`)
                                                          ON DELETE CASCADE
                                                          ON UPDATE CASCADE)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Subscription_Plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Subscription_Plan` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Subscription_Plan` (
                                                          `subcription_id` INT NOT NULL,
                                                          `plan_name` VARCHAR(45) NOT NULL,
                                                          `price` DECIMAL(10,2) NOT NULL,
                                                          PRIMARY KEY (`subcription_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Account` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Account` (
                                                `Account_id` INT NOT NULL,
                                                `user_id` INT NOT NULL,
                                                `email` VARCHAR(45) NOT NULL,
                                                `password` VARCHAR(45) NOT NULL,
                                                `date_created` DATE NOT NULL,
                                                `subscription_id` INT NOT NULL,
                                                PRIMARY KEY (`Account_id`),
                                                INDEX `FK_account_user_idx` (`user_id` ASC) VISIBLE,
                                                INDEX `FK_account_subscriptionPlan_idx` (`subscription_id` ASC) VISIBLE,
                                                CONSTRAINT `FK_account_user`
                                                    FOREIGN KEY (`user_id`)
                                                        REFERENCES `mydb`.`User` (`user_id`)
                                                        ON DELETE CASCADE
                                                        ON UPDATE CASCADE,
                                                CONSTRAINT `FK_account_subscriptionPlan`
                                                    FOREIGN KEY (`subscription_id`)
                                                        REFERENCES `mydb`.`Subscription_Plan` (`subcription_id`)
                                                        ON DELETE CASCADE
                                                        ON UPDATE CASCADE)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment_method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Payment_method` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Payment_method` (
                                                       `payment_id` INT NOT NULL,
                                                       `payment_type` VARCHAR(45) NOT NULL,
                                                       `card_number` VARCHAR(16) NOT NULL,
                                                       `expiration_date` DATE NOT NULL,
                                                       PRIMARY KEY (`payment_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment_History`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Payment_History` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Payment_History` (
                                                        `account_id` INT NOT NULL,
                                                        `payment_id` INT NOT NULL,
                                                        `amount` DECIMAL(10,2) NOT NULL,
                                                        `date` DATE NOT NULL,
                                                        `plan` VARCHAR(45) NOT NULL,
                                                        INDEX `FK_account_user_idx` (`account_id` ASC) VISIBLE,
                                                        INDEX `FK_paymentId_paymentMethod_idx` (`payment_id` ASC) VISIBLE,
                                                        CONSTRAINT `FK_account_payment_history`
                                                            FOREIGN KEY (`account_id`)
                                                                REFERENCES `mydb`.`Account` (`Account_id`)
                                                                ON DELETE CASCADE
                                                                ON UPDATE CASCADE,
                                                        CONSTRAINT `FK_paymentId_paymentMethod`
                                                            FOREIGN KEY (`payment_id`)
                                                                REFERENCES `mydb`.`Payment_method` (`payment_id`)
                                                                ON DELETE CASCADE
                                                                ON UPDATE CASCADE)
