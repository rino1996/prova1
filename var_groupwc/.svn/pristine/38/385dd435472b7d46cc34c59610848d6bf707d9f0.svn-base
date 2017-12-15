SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `elar_project` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;

-- -----------------------------------------------------
-- Table `elar_project`.`locations`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `elar_project`.`locations` (
  `id_location` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(100) NULL ,
  `description` VARCHAR(255) NULL ,
  `is_active` TINYINT(1) NULL ,
  `is_deleted` TINYINT(1) NULL ,
  PRIMARY KEY (`id_location`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Identifies locations for motes and not grouped sensors';


-- -----------------------------------------------------
-- Table `elar_project`.`motes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `elar_project`.`motes` (
  `id_mote` INT NOT NULL AUTO_INCREMENT ,
  `description` VARCHAR(255) NULL ,
  `mote_identifier` INT NULL ,
  `id_location` INT NULL ,
  `is_active` TINYINT(1) NULL ,
  `is_deleted` TINYINT(1) NULL ,
  PRIMARY KEY (`id_mote`) ,
  INDEX `fk_motes_locations1` (`id_location` ASC) ,
  CONSTRAINT `fk_motes_locations1`
    FOREIGN KEY (`id_location` )
    REFERENCES `elar_project`.`locations` (`id_location` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Identifies motes (sensor groups in the system)';


-- -----------------------------------------------------
-- Table `elar_project`.`panels`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `elar_project`.`panels` (
  `id_panel` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NULL ,
  `description` VARCHAR(255) NULL ,
  `is_active` TINYINT(1) NULL ,
  `is_deleted` TINYINT(1) NULL ,
  PRIMARY KEY (`id_panel`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Device agrupations to form a panel.';


-- -----------------------------------------------------
-- Table `elar_project`.`devices`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `elar_project`.`devices` (
  `id_device` INT NOT NULL AUTO_INCREMENT ,
  `id_mote` INT NULL ,
  `device_type` TINYINT(1) NULL COMMENT '0 : Sensor\n1 : Actuator' ,
  `io_type` TINYINT(1) NULL COMMENT '0 : Analog\n1 : Digital' ,
  `name` VARCHAR(100) NULL ,
  `description` VARCHAR(255) NULL ,
  `default_value` DOUBLE NULL ,
  `min_value` DOUBLE NULL ,
  `max_value` DOUBLE NULL ,
  `is_recorded` TINYINT(1) NULL COMMENT '0 : write only to table volatile\n1 : write to volatile and records (for historial analysis)' ,
  `id_panel` INT NULL ,
  `read_order` INT NULL COMMENT 'Order of received parameter from Squidbee\n1 : first\n2 : second\n3 : third' ,
  `measure_unit` VARCHAR(50) NULL COMMENT 'Unit for value measured by device (C, F, Lux, etc.)' ,
  `is_active` TINYINT(1) NULL ,
  `is_deleted` TINYINT(1) NULL ,
  PRIMARY KEY (`id_device`) ,
  INDEX `fk_devices_motes` (`id_mote` ASC) ,
  INDEX `fk_devices_panels1` (`id_panel` ASC) ,
  CONSTRAINT `fk_devices_motes`
    FOREIGN KEY (`id_mote` )
    REFERENCES `elar_project`.`motes` (`id_mote` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_devices_panels1`
    FOREIGN KEY (`id_panel` )
    REFERENCES `elar_project`.`panels` (`id_panel` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Identifies independent devices conected to motes';


-- -----------------------------------------------------
-- Table `elar_project`.`rules`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `elar_project`.`rules` (
  `id_rule` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NULL ,
  `description` VARCHAR(255) NULL ,
  `is_critical` TINYINT(1) NULL COMMENT 'for alert trigger' ,
  `is_active` TINYINT(1) NULL ,
  `is_deleted` TINYINT(1) NULL ,
  PRIMARY KEY (`id_rule`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'User defined rules connecting  actions and alerts.';


-- -----------------------------------------------------
-- Table `elar_project`.`actions`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `elar_project`.`actions` (
  `id_action` INT NOT NULL AUTO_INCREMENT ,
  `id_rule` INT NULL ,
  `id_device` INT NULL ,
  `value` DOUBLE NULL ,
  `is_active` TINYINT(1) NULL ,
  `is_deleted` TINYINT(1) NULL ,
  PRIMARY KEY (`id_action`) ,
  INDEX `fk_actions_rules1` (`id_rule` ASC) ,
  INDEX `fk_actions_devices1` (`id_device` ASC) ,
  CONSTRAINT `fk_actions_rules1`
    FOREIGN KEY (`id_rule` )
    REFERENCES `elar_project`.`rules` (`id_rule` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_actions_devices1`
    FOREIGN KEY (`id_device` )
    REFERENCES `elar_project`.`devices` (`id_device` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `elar_project`.`conditions`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `elar_project`.`conditions` (
  `id_condition` INT NOT NULL AUTO_INCREMENT ,
  `id_rule` INT NULL ,
  `id_device` INT NULL ,
  `operator` VARCHAR(2) NULL COMMENT 'Valid operators:\n==\n>=\n<=\n>\n<\n!=' ,
  `condition_type` TINYINT(1) NULL COMMENT '0 : Value condition\n1 : Time condition ' ,
  `value` DOUBLE NULL COMMENT 'Value of device\nor selected time\n\n(depends on condition type)' ,
  `is_active` TINYINT(1) NULL ,
  `is_deleted` TINYINT(1) NULL ,
  PRIMARY KEY (`id_condition`) ,
  INDEX `fk_conditions_rules1` (`id_rule` ASC) ,
  INDEX `fk_conditions_devices1` (`id_device` ASC) ,
  CONSTRAINT `fk_conditions_rules1`
    FOREIGN KEY (`id_rule` )
    REFERENCES `elar_project`.`rules` (`id_rule` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conditions_devices1`
    FOREIGN KEY (`id_device` )
    REFERENCES `elar_project`.`devices` (`id_device` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `elar_project`.`records`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `elar_project`.`records` (
  `id_record` INT NOT NULL AUTO_INCREMENT ,
  `id_device` INT NULL ,
  `date` INT NULL ,
  `value` DOUBLE NULL ,
  PRIMARY KEY (`id_record`) ,
  INDEX `fk_records_devices1` (`id_device` ASC) ,
  CONSTRAINT `fk_records_devices1`
    FOREIGN KEY (`id_device` )
    REFERENCES `elar_project`.`devices` (`id_device` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Record device values if devices.is_recorded=1';


-- -----------------------------------------------------
-- Table `elar_project`.`volatile`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `elar_project`.`volatile` (
  `id_volatile` INT NOT NULL AUTO_INCREMENT ,
  `id_device` INT NULL ,
  `date` INT NULL ,
  `value` DOUBLE NULL ,
  PRIMARY KEY (`id_volatile`) ,
  INDEX `fk_volatile_devices1` (`id_device` ASC) ,
  CONSTRAINT `fk_volatile_devices1`
    FOREIGN KEY (`id_device` )
    REFERENCES `elar_project`.`devices` (`id_device` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Records from devices. Used to graph charts in real time.';


-- -----------------------------------------------------
-- Table `elar_project`.`alerts`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `elar_project`.`alerts` (
  `id_alert` INT NOT NULL AUTO_INCREMENT ,
  `id_rule` INT NULL ,
  `notification_type` INT NULL COMMENT '0 : SMS\n1 : Telephone\n2 : Mail\netc.\n\n(User defined)' ,
  `message` VARCHAR(255) NULL ,
  `date` INT NULL ,
  `is_sent` TINYINT(1) NULL ,
  `is_active` TINYINT(1) NULL ,
  `is_deleted` TINYINT(1) NULL ,
  PRIMARY KEY (`id_alert`) ,
  INDEX `fk_alerts_rules1` (`id_rule` ASC) ,
  CONSTRAINT `fk_alerts_rules1`
    FOREIGN KEY (`id_rule` )
    REFERENCES `elar_project`.`rules` (`id_rule` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Alert types and definitions.';



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
