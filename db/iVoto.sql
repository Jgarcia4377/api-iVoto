-- MySQL Script generated by MySQL Workbench
-- Tue Jun  4 23:32:04 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema iVoto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema iVoto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `iVoto` DEFAULT CHARACTER SET utf8 ;
USE `iVoto` ;

-- -----------------------------------------------------
-- Table `iVoto`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `iVoto`.`persona` (
  `idpersona` INT NOT NULL AUTO_INCREMENT,
  `cedula` VARCHAR(10) NOT NULL,
  `nombres` VARCHAR(50) NOT NULL,
  `apellido_p` VARCHAR(45) NOT NULL,
  `apellido_m` VARCHAR(45) NOT NULL,
  `huella_dactilar` VARCHAR(10) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(10) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idpersona`),
  UNIQUE INDEX `cedula_UNIQUE` (`cedula` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `iVoto`.`tipo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `iVoto`.`tipo_usuario` (
  `idtipo` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `iVoto`.`estado_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `iVoto`.`estado_usuario` (
  `idestado` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idestado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `iVoto`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `iVoto`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARBINARY(100) NOT NULL,
  `contrasena` VARBINARY(100) NULL,
  `cambio_contrasena` TINYINT NOT NULL,
  `persona_idpersona` INT NOT NULL,
  `tipo_usuario_id` INT NOT NULL,
  `estado_usuario_id` INT NOT NULL,
  PRIMARY KEY (`idusuario`),
  INDEX `fk_usuario_persona_idx` (`persona_idpersona` ASC),
  INDEX `fk_usuario_tipo_usuario1_idx` (`tipo_usuario_id` ASC),
  INDEX `fk_usuario_estado_usuario1_idx` (`estado_usuario_id` ASC),
  CONSTRAINT `fk_usuario_persona`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `iVoto`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_tipo_usuario1`
    FOREIGN KEY (`tipo_usuario_id`)
    REFERENCES `iVoto`.`tipo_usuario` (`idtipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_estado_usuario1`
    FOREIGN KEY (`estado_usuario_id`)
    REFERENCES `iVoto`.`estado_usuario` (`idestado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;