create database zawody_bjj; 
use zawody_bjj;
CREATE TABLE `zawody_bjj`.`login` (
  `id_login` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `haslo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_login`),
  UNIQUE INDEX `id_login_UNIQUE` (`id_login` ASC),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC));
LOAD DATA LOCAL INFILE 'C:/Users/oem/Desktop/loginyxlsx.txt' INTO TABLE login;
select * from login;
delete from  dane_os;
CREATE TABLE `zawody_bjj`.`dane_os` (
  `id_login` INT NOT NULL AUTO_INCREMENT,
  `imie_nazwisko` VARCHAR(45) NOT NULL,
  `kategoria` INT NOT NULL,
  `klub` INT NOT NULL,
  PRIMARY KEY (`id_login`),
  CONSTRAINT `id_login`
    FOREIGN KEY (`id_login`)
    REFERENCES `zawody_bjj`.`login` (`id_login`));
ALTER TABLE `zawody_bjj`.`dane_os` 
COLLATE = utf8_polish_ci ;
LOAD DATA LOCAL INFILE 'C:/Users/oem/Desktop/adult.txt' INTO TABLE dane_os;
select * from dane_os;
CREATE TABLE `zawody_bjj`.`kluby` (
  `id_klubu` INT NOT NULL AUTO_INCREMENT,
  `nazwa_klubu` VARCHAR(45) NULL,
  PRIMARY KEY (`id_klubu`),
  UNIQUE INDEX `id_klubu_UNIQUE` (`id_klubu` ASC));
ALTER TABLE `zawody_bjj`.`kluby` 
COLLATE = utf8_polish_ci ;
LOAD DATA LOCAL INFILE 'C:/Users/oem/Desktop/kluby.txt' INTO TABLE kluby;
select * from kluby;
delete from kluby where id_klubu = '65';
ALTER TABLE `zawody_bjj`.`dane_os` 
ADD INDEX `klub_idx` (`klub` ASC);
ALTER TABLE `zawody_bjj`.`dane_os` 
ADD CONSTRAINT `klub`
  FOREIGN KEY (`klub`)
  REFERENCES `zawody_bjj`.`kluby` (`id_klubu`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
CREATE TABLE `zawody_bjj`.`sedziowie` (
  `id_sedziego` INT NOT NULL AUTO_INCREMENT,
  `imie_sedziego` VARCHAR(45) NULL,
  PRIMARY KEY (`id_sedziego`));
LOAD DATA LOCAL INFILE 'C:/Users/oem/Desktop/sedziowie.txt' INTO TABLE sedziowie;
select * from sedziowie;
CREATE TABLE `zawody_bjj`.`maty` (
  `id_maty` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_maty`));
insert into  maty values(1);
insert into  maty values(2);
insert into  maty values(3);
insert into  maty values(4);
insert into  maty values(5);
insert into  maty values(6);
select * from maty;
CREATE TABLE `zawody_bjj`.`kategorie_wagowe` (
  `id_kategorii` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(45) NOT NULL,
  `mata` INT NOT NULL,
  `sedzia` INT NOT NULL,
  `godzina` DATE NOT NULL,
  PRIMARY KEY (`id_kategorii`),
  INDEX `mata_idx` (`mata` ASC),
  INDEX `sedzia_idx` (`sedzia` ASC),
  CONSTRAINT `mata`
    FOREIGN KEY (`mata`)
    REFERENCES `zawody_bjj`.`maty` (`id_maty`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sedzia`
    FOREIGN KEY (`sedzia`)
    REFERENCES `zawody_bjj`.`sedziowie` (`id_sedziego`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
ALTER TABLE `zawody_bjj`.`kategorie_wagowe` 
DROP COLUMN `godzina`;
LOAD DATA LOCAL INFILE 'C:/Users/oem/Desktop/zawody/Kategoriewag.txt' INTO TABLE kategorie_wagowe;
select * from kategorie_wagowe;
select imie_nazwisko, kategorie_wagowe.nazwa, nazwa_klubu from dane_os, kategorie_wagowe, kluby where kategoria = id_kategorii and id_klubu = klub order by kategorie_wagowe.nazwa;
CREATE TABLE `zawody_bjj`.`medalisci` (
  `id_medalisty` INT NOT NULL AUTO_INCREMENT,
  `id_zawodnika` INT NOT NULL,
  `id_kategorii` INT NOT NULL,
  `id_klubu` INT NOT NULL,
  `miejsce` INT NOT NULL,
  PRIMARY KEY (`id_medalisty`),
  INDEX `id_zawodnika_idx` (`id_zawodnika` ASC),
  INDEX `id_kategorii_idx` (`id_kategorii` ASC),
  INDEX `id_klubu_idx` (`id_klubu` ASC),
  CONSTRAINT `id_zawodnika`
    FOREIGN KEY (`id_zawodnika`)
    REFERENCES `zawody_bjj`.`dane_os` (`id_login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_kategorii`
    FOREIGN KEY (`id_kategorii`)
    REFERENCES `zawody_bjj`.`kategorie_wagowe` (`id_kategorii`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_klubu`
    FOREIGN KEY (`id_klubu`)
    REFERENCES `zawody_bjj`.`kluby` (`id_klubu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
ALTER TABLE `zawody_bjj`.`kluby` 
CHANGE COLUMN `nazwa_klubu` `nazwa_klubu` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL ,
ADD COLUMN `zlote_medale` INT NOT NULL AFTER `nazwa_klubu`,
ADD COLUMN `srebrne_medale` INT NOT NULL AFTER `zlote_medale`,
ADD COLUMN `brazowe medale` INT NOT NULL AFTER `srebrne_medale`,
ADD COLUMN `punkty` INT NOT NULL AFTER `brazowe medale`;
select * from kluby;
ALTER TABLE `zawody_bjj`.`kluby` 
CHANGE COLUMN `brazowe medale` `brazowe_medale` INT(11) NOT NULL ;
select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =1 order by kategorie_wagowe.nazwa;
create view biale_plus_100_i_5 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =1 order by kategorie_wagowe.nazwa;
create view biale_100_i_5 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =2 order by kategorie_wagowe.nazwa;
create view biale_64 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =3 order by kategorie_wagowe.nazwa;
create view biale_70 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =4 order by kategorie_wagowe.nazwa;
create view biale_76 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =5 order by kategorie_wagowe.nazwa;
create view biale_82_i_3 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =6 order by kategorie_wagowe.nazwa;
create view biale_88_i_3 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =7 order by kategorie_wagowe.nazwa;
create view biale_94_i_3 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =8 order by kategorie_wagowe.nazwa;
create view elita_plus_100_i_5 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =9 order by kategorie_wagowe.nazwa;
create view elita_100_i_5 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =10 order by kategorie_wagowe.nazwa;
create view elita_64 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =11 order by kategorie_wagowe.nazwa;
create view elita_70 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =12 order by kategorie_wagowe.nazwa;
create view elita_76 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =13 order by kategorie_wagowe.nazwa;
create view elita_82_i_3 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =14 order by kategorie_wagowe.nazwa;
create view elita_88_i_3 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =15 order by kategorie_wagowe.nazwa;
create view elita_94_i_3 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =16 order by kategorie_wagowe.nazwa;
create view niebieskie_plus_100_i_5 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =17 order by kategorie_wagowe.nazwa;
create view niebieskie_100_i_5 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =18 order by kategorie_wagowe.nazwa;
create view niebieskie_64 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =19 order by kategorie_wagowe.nazwa;
create view niebieskie_70 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =20 order by kategorie_wagowe.nazwa;
create view niebieskie_76 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =21 order by kategorie_wagowe.nazwa;
create view niebieskie_82_i_3 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =22 order by kategorie_wagowe.nazwa;
create view niebieskie_88_i_3 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =23 order by kategorie_wagowe.nazwa;
create view niebieskie_94_i_3 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =24 order by kategorie_wagowe.nazwa;
create view purpurowe_plus_100_i_5 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =25 order by kategorie_wagowe.nazwa;
create view purpurowe_100_i_5 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =26 order by kategorie_wagowe.nazwa;
create view purpurowe_57_i_5 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =27 order by kategorie_wagowe.nazwa;
create view purpurowe_64 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =28 order by kategorie_wagowe.nazwa;
create view purpurowe_70 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =29 order by kategorie_wagowe.nazwa;
create view purpurowe_76 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =30 order by kategorie_wagowe.nazwa;
create view purpurowe_82_i_3 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =31 order by kategorie_wagowe.nazwa;
create view purpurowe_88_i_3 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =32 order by kategorie_wagowe.nazwa;
create view purpurowe_94_i_3 as select imie_nazwisko as 'imie i nazwisko', nazwa_klubu as 'klub', kategorie_wagowe.nazwa as 'kategoria wagowa' from dane_os, kluby, kategorie_wagowe where kategoria = id_kategorii and id_klubu = klub and id_kategorii =33 order by kategorie_wagowe.nazwa;
create view ranking_klubow as select nazwa_klubu as 'Nazwa klubu', zlote_medale as 'Zlote medale', srebrne_medale as 'Srebrne medale', brazowe_medale as 'Brazowe medale', punkty as 'Punkty' from kluby order by punkty limit 10;
select * from ranking_klubow;

CREATE trigger `zawody_bjj`.`medalisci_AFTER_INSERT` AFTER INSERT ON `medalisci` FOR EACH ROW
BEGIN
if miejsce = 1 and id_kategorii != 1 and id_kategorii != 2 and id_kategorii != 3 and id_kategorii != 4 and id_kategorii != 5 and id_kategorii != 6 and id_kategorii != 7 and id_kategorii != 8 and id_kategorii != 9 then
set  new.kluby.zlote_medale = kluby.zlote_medale+1 and new.kluby.punkty = kluby.punkty+5;
elseif  miejsce = 2 and id_kategorii != 1 and id_kategorii != 2 and id_kategorii != 3 and id_kategorii != 4 and id_kategorii != 5 and id_kategorii != 6 and id_kategorii != 7 and id_kategorii != 8 and id_kategorii != 9 then
set  new.kluby.srebrne_medale = kluby.srebrne_medale and new.kluby.punkty = kluby.punkty+3;
elseif miejsce = 3 and id_kategorii != 1 and id_kategorii != 2 and id_kategorii != 3 and id_kategorii != 4 and id_kategorii != 5 and id_kategorii != 6 and id_kategorii != 7 and id_kategorii != 8 and id_kategorii != 9 then
set  new.kluby.zlote_medale = kluby.zlote_medale and new.kluby.punkty = kluby.punkty+3;
end if;
END;
select * from kluby;