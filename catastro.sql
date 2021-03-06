-- MySQL Script generated by MySQL Workbench
-- Thu Nov 19 09:38:48 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema catastro
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema catastro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `catastro` DEFAULT CHARACTER SET utf8 ;
USE `catastro` ;

-- -----------------------------------------------------
-- Table `catastro`.`ZONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catastro`.`ZONA` (
  `NOMBRE` VARCHAR(45) NOT NULL,
  `AREA` INT NULL,
  `CONCEJAL` VARCHAR(45) NULL,
  PRIMARY KEY (`NOMBRE`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `catastro`.`CALLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catastro`.`CALLE` (
  `NOMBRE` VARCHAR(45) NOT NULL,
  `LONGITUD` INT NULL,
  `TIPO` VARCHAR(45) NULL,
  `NOMBRE_ZONA` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NOMBRE`),
  INDEX `NOMBRE_ZONA_idx` (`NOMBRE_ZONA`  ASC),
  CONSTRAINT `NOMBRE_ZON3`
    FOREIGN KEY (`NOMBRE_ZONA`)
    REFERENCES `catastro`.`ZONA` (`NOMBRE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catastro`.`BLOQUE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catastro`.`BLOQUE` (
  `NOMBRE_CALLE` VARCHAR(45) NOT NULL,
  `NUMERO` INT NOT NULL,
  `CANTIDAD_PERSONAS` INT NULL,
  PRIMARY KEY (`NOMBRE_CALLE`, `NUMERO`),
  INDEX `NOMBRE_CALLE_idx` (`NOMBRE_CALLE`  ASC),
  CONSTRAINT `NOMBRE_CALL1`
    FOREIGN KEY (`NOMBRE_CALLE`)
    REFERENCES `catastro`.`CALLE` (`NOMBRE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catastro`.`PISO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catastro`.`PISO` (
  `BLOQUE_CALLE` VARCHAR(45) NOT NULL,
  `BLOQUE_NUMERO` INT NOT NULL,
  `PLANTA` INT NOT NULL,
  `LETRA` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`BLOQUE_CALLE`, `BLOQUE_NUMERO`, `PLANTA`, `LETRA`),
  INDEX `fk_PISO_BLOQUE1_idx` (`BLOQUE_CALLE` ASC, `BLOQUE_NUMERO`  ASC),
  CONSTRAINT `fk_PISO_BLOQUE1`
    FOREIGN KEY (`BLOQUE_CALLE` , `BLOQUE_NUMERO`)
    REFERENCES `catastro`.`BLOQUE` (`NOMBRE_CALLE` , `NUMERO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catastro`.`VIVIENDA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catastro`.`VIVIENDA` (
  `NOMBRE_CALLE` VARCHAR(45) NOT NULL,
  `NUMERO` INT NOT NULL,
  `CANTIDAD_PERSONAS` INT NULL,
  PRIMARY KEY (`NOMBRE_CALLE`, `NUMERO`),
  INDEX `NOMBRE_CALLE_idx` (`NOMBRE_CALLE`  ASC),
  CONSTRAINT `NOMBRE_CALL2`
    FOREIGN KEY (`NOMBRE_CALLE`)
    REFERENCES `catastro`.`CALLE` (`NOMBRE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catastro`.`PERSONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catastro`.`PERSONA` (
  `DNI` VARCHAR(45) NOT NULL,
  `FECHA_NACIMIENTO` VARCHAR(45) NULL,
  `NOMBRE` VARCHAR(45) NULL,
  `TELEFONO` INT NULL,
  `CABEZA_FAMILIA` VARCHAR(45) NOT NULL,
  `FAMILIA` VARCHAR(45) NULL,
  `PISO_CALLE` VARCHAR(45) NULL,
  `PISO_NUMERO` INT NULL,
  `PISO_PLANTA` INT NULL,
  `PISO_LETRA` VARCHAR(45) NULL,
  `VIVIENDA_CALLE` VARCHAR(45) NULL,
  `VIVIENDA_NUMERO` INT NULL,
  PRIMARY KEY (`DNI`),
  INDEX `fk_PERSONA_PISO1_idx` (`PISO_CALLE` ASC, `PISO_NUMERO` ASC, `PISO_PLANTA` ASC, `PISO_LETRA` ASC),
  INDEX `fk_PERSONA_VIVIENDA1_idx` (`VIVIENDA_CALLE` ASC, `VIVIENDA_NUMERO`  ASC),
  CONSTRAINT `fk_PERSONA_PISO1`
    FOREIGN KEY (`PISO_CALLE` , `PISO_NUMERO` , `PISO_PLANTA` , `PISO_LETRA` )
    REFERENCES `catastro`.`PISO` (`BLOQUE_CALLE`, `BLOQUE_NUMERO`, `PLANTA`, `LETRA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PERSONA_VIVIENDA1`
    FOREIGN KEY (`VIVIENDA_CALLE` , `VIVIENDA_NUMERO`)
    REFERENCES `catastro`.`VIVIENDA` (`NOMBRE_CALLE`, `NUMERO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CABEZA_FAMILI`
    FOREIGN KEY (`CABEZA_FAMILIA`)
    REFERENCES `catastro`.`PERSONA` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
