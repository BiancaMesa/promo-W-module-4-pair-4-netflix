-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema netflix
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema netflix
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `netflix` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `netflix` ;

-- -----------------------------------------------------
-- Table `netflix`.`actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`actors` (
  `idActors` INT NOT NULL AUTO_INCREMENT,
  `nameActors` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `birthday` DATE NULL DEFAULT NULL,
  `image` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`idActors`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`movies` (
  `idMovies` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `genre` VARCHAR(45) NOT NULL,
  `image` VARCHAR(1000) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `movieYear` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idMovies`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`users` (
  `idUsers` INT NOT NULL AUTO_INCREMENT,
  `users` VARCHAR(45) NOT NULL,
  `passwordUsers` VARCHAR(45) NOT NULL,
  `nameUsers` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `plan_details` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsers`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`users_has_movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`users_has_movies` (
  `id_users_has_movies` INT NOT NULL AUTO_INCREMENT,
  `fk_idUsers` INT NOT NULL,
  `fk_idMovies` INT NOT NULL,
  PRIMARY KEY (`id_users_has_movies`, `fk_idUsers`, `fk_idMovies`),
  INDEX `fk_users_has_movies_movies1_idx` (`fk_idMovies` ASC) VISIBLE,
  INDEX `fk_users_has_movies_users_idx` (`fk_idUsers` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_movies_users`
    FOREIGN KEY (`fk_idUsers`)
    REFERENCES `netflix`.`users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_movies_movies1`
    FOREIGN KEY (`fk_idMovies`)
    REFERENCES `netflix`.`movies` (`idMovies`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`actors_has_movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`actors_has_movies` (
  `id_actors_has_movies` INT NOT NULL AUTO_INCREMENT,
  `fk_idActors` INT NOT NULL,
  `fk_idMovies` INT NOT NULL,
  PRIMARY KEY (`id_actors_has_movies`, `fk_idActors`, `fk_idMovies`),
  INDEX `fk_actors_has_movies_movies1_idx` (`fk_idMovies` ASC) VISIBLE,
  INDEX `fk_actors_has_movies_actors1_idx` (`fk_idActors` ASC) VISIBLE,
  CONSTRAINT `fk_actors_has_movies_actors1`
    FOREIGN KEY (`fk_idActors`)
    REFERENCES `netflix`.`actors` (`idActors`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_actors_has_movies_movies1`
    FOREIGN KEY (`fk_idMovies`)
    REFERENCES `netflix`.`movies` (`idMovies`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
