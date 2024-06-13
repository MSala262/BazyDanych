-- CREATE DATABASE projekt;
USE projekt;

----------------------------------------------------------------------------------
CREATE TABLE GeoEon (id_eon INT NOT NULL PRIMARY KEY, nazwa_eon VARCHAR(30));

CREATE TABLE GeoEra (id_era INT NOT NULL PRIMARY KEY, id_eon INT, nazwa_era VARCHAR(30), FOREIGN KEY (id_eon) REFERENCES GeoEon (id_eon)); 

CREATE TABLE GeoOkres (id_okres INT NOT NULL PRIMARY KEY, id_era INT, nazwa_okres VARCHAR(30), FOREIGN KEY (id_era) REFERENCES GeoEra (id_era)); 

CREATE TABLE GeoEpoka (id_epoka INT NOT NULL PRIMARY KEY, id_okres INT NOT NULL REFERENCES GeoOkres (id_okres), nazwa_epoka VARCHAR(30));

CREATE TABLE GeoPietro (id_pietro INT NOT NULL PRIMARY KEY, id_epoka INT NOT NULL REFERENCES GeoEpoka (id_epoka), nazwa_pietro VARCHAR(30));

----------------------------------------------------------------------------------------------
--GeoEon
INSERT INTO GeoEon (id_eon, nazwa_eon) VALUES (1, 'hadeik'),
(2, 'archaik'), (3, 'protezoik'), (4, 'fanerozoik');

--GeoEra
INSERT INTO GeoEra (id_era, id_eon, nazwa_era) VALUES (1,1,''),
(2,2,'eoarchaik'),(3,2,'paleoarchaik'),(4,2,'mezoarchaik'),(5,2,'neoarchaik'),
(6,3,'paleoprotezoik'),(7,3, 'mezoprotezoik'),(8,3,'neoprotezoik'),(9,4,'paleozoik'),
(10,4,'mezozoik'),(11,4,'kenozoik');

--GeoOkres
INSERT INTO GeoOkres (id_okres, id_era, nazwa_okres) VALUES (1,1,''),
(2,2,''),(3,3,''),(4,4,''),(5,5,''),(6,6,'sider'), (7,6,'riak'),(8,6,'orosir'),
(9,6,'stater'),(10,7,'kalim'),(11,7,'ektas'),(12,7,'sten'), (13,8,'ton'),
(14,8,'kriogen'),(15,8,'ediakar'), (16,9,'kambr'),(17,9,'ordowik'),(18,9,'sylur'),
(19,9,'dewon'), (20,9,'karbon'),(21,9,'perm'),(22,10,'trias'),(23,10,'jura'),
(24,10,'kreda'),(25,11,'paleogen'),(26,11,'neogen'),(27,11,'czwartorzed');

--GeoEpoka
INSERT INTO GeoEpoka (id_epoka, id_okres, nazwa_epoka) VALUES (1,1,''),
(2,2,''),(3,3,''),(4,4,''),(5,5,''),(6,6,''),(7,7,''),(8,8,''),(9,9,''),
(10,10,''),(11,11,''),(12,12,''),(13,13,''),(14,14,''),(15,15,''),
(16,16,'terenew'),(17,16,'oddzia³ 2'),(18,16,'miaoling'),(19,16,'furong'),
(20,17,'wczesny'), (21,17,'srodkowy'),(22,17,'pozny'), (23,18,'landower'),
(24,18,'wenlok'),(25,18,'ludlow'),(26,18,'przydol'),(27,19,'wczesny'), 
(28,19,'srodkowy'),(29,19,'pozny'),(30,20,'missisip'),(31,20,'pensylwan'),
(32,21,'cisural'),(33,21,'gwadalup'),(34,21,'loping'),(35,22,'wczesny'),
(36,22,'srodkowy'),(37,22,'pozny'),(38,23,'wczesna'), (39,23,'srodkowa'),
(40,23,'pozna'),(41,24,'wczesna'),(42,24,'pozna'),(43,25,'paleocen'),
(44,25,'eocen'),(45,25,'oligocen'),(46,26,'miocen'),(47,26,'pliocen'),
(48,27,'plejstocen'),(49,27,'holocen');

--GeoPietro
INSERT INTO GeoPietro (id_pietro, id_epoka, nazwa_pietro) VALUES (1,1,''),
(2,2,''),(3,3,''),(4,4,''),(5,5,''),(6,6,''),(7,7,''),(8,8,''),(9,9,''),
(10,10,''),(11,11,''),(12,12,''),(13,13,''),(14,14,''),(15,15,''),(16,16,'terenew'),
(17,16,'pietro 2'),(18,17,'pietro 3'), (19,17,'pietro 4'),(20,18,'wuliuan'),
(21,18,'drum'),(22,18,'guzang'), (23,19,'paib'),(24,19,'dziangszan'),(25,19,'pietro 10'),
(26,20,'tremadok'),(27,20,'flo'),(28,21,'daping'),(29,21,'darriwil'),(30,22,'sandb'),
(31,22,'kat'),(32,22,'hirnant'),(33,23,'ruddan'),(34,23,'aeron'),(35,23,'telicz'),
(36,24,'szejnwud'),(37,24,'homer'),(38,25,'gorst'),(39,25,'ludford'),(40,26,''),
(41,27, 'lochkow'), (42,27,'prag'),(43,27,'ems'),(44,28,'eifel'), (45,28,'zywet'),
(46,29,'fran'), (47,29,'famen'),(48,30,'turnej'),(49,30,'wizen'),(50,30,'serpichow'),
(51,31,'baszkir'),(52,31,'moskow'),(53,31,'kasimow'),(54,31,'gzel'),(55,32,'assel'),
(56,32,'sakmar'),(57,32,'artinsk'),(58,32,'kungur'),(59,33,'roaf'),(60,33,'word'),
(61,33,'kapitan'),(62,34,'wucziaping'),(63,34,'czangsing'),(64,35,'ind'),(65,35,'olenek'),
(66,36,'anizyk'),(67,36,'ladyn'),(68,37,'karnik'),(69,37,'noryk'),(70,37,'retyk'),
(71,38,'hettang'),(72,38,'synemur'),(73,38,'pliensbach'),(74,38,'toark'),
(75,39,'aalen'),(76,39,'bajos'),(77,39,'baton'),(78,39,'kelowej'),(79,40,'oksford'),
(80,40,'kimeryd'),(81,40,'tyton'),(82,41,'berrias'),(83,41,'walanzyn'),(84,41,'hoteryw'),
(85,41,'barrem'),(86,41,'apt'),(87,41,'alb'),(88,42,'cenoman'),(89,42,'turon'),
(90,42,'koniak'),(91,42,'santon'),(92,42,'kampan'),(93,42,'mastrycht'),(94,43,'dan'),
(95,43,'zeland'),(96,43,'tanet'),(97,44,'iprez'),(98,44,'lutet'), (99,44, 'barton'),
(100,44,'priabon'),(101,45,'rupel'),(102,45,'szat'),(103,46,'akwitan'),(104,46,'burdygal'),
(105,46,'lang'),(106,46,'serrawal'),(107,46,'torton'),(108,46,'messyn'),(109,47,'zankl'),
(110,47,'piacent'), (111,48,'gelas'),(112,48,'kalabr'),(113,48,'chiban'), 
(114,48,'pozny'),(115,49,'grenland'),(116,49,'northgrip'),(117,49,'megalaj');


--CREATE TABLE GeoTabela AS 
SELECT pp.id_pietro, pp.nazwa_pietro, ep.id_epoka,ep.nazwa_epoka,ok.id_okres,ok.nazwa_okres,er.id_era,er.nazwa_era, eo.id_eon,eo.nazwa_eon
INTO GeoTabela FROM GeoPietro pp RIGHT JOIN GeoEpoka ep ON pp.id_epoka = ep.id_epoka RIGHT JOIN GeoOkres ok ON ep.id_okres = ok.id_okres
RIGHT JOIN GeoEra er ON ok.id_era = er.id_era RIGHT JOIN GeoEon eo ON eo.id_eon = er.id_eon;

ALTER TABLE GeoTabela ALTER COLUMN id_pietro int NOT NULL; 
ALTER TABLE GeoTabela ADD PRIMARY KEY (id_pietro);

SELECT * FROM GeoTabela;


CREATE TABLE Dziesiec (cyfra INT, bit int);
INSERT INTO Dziesiec(cyfra) VALUES
(0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

CREATE TABLE Milion(liczba int,cyfra int, bit int);
INSERT INTO Milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra + 10000*a5.cyfra + 10000*a6.cyfra AS liczba ,
a1.cyfra AS cyfra, a1.bit AS bit FROM Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec a6 ;

SELECT * FROM Dziesiec;
SELECT * FROM Milion 
order by  liczba desc;


--------------------------------------------------------------------------------------------



SET STATISTICS IO ON
SET STATISTICS TIME ON

DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS
--zap1
SELECT COUNT(*) FROM Milion INNER JOIN GeoTabela ON 
((Milion.liczba%117)=(GeoTabela.id_pietro));



DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS
--zap2
SELECT COUNT(*) FROM Milion INNER JOIN GeoPietro ON ((Milion.liczba%117)=GeoPietro.id_pietro) 
JOIN GeoEpoka ep ON GeoPietro.id_epoka=ep.id_epoka JOIN GeoOkres ok ON ep.id_okres=ok.id_okres JOIN GeoEra er ON ok.id_era=er.id_era JOIN GeoEon eo ON er.id_eon=eo.id_eon;


DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS
--zap3
SELECT COUNT(*) FROM Milion WHERE Milion.liczba%117=
(SELECT id_pietro FROM GeoTabela WHERE Milion.liczba%117=(id_pietro));

DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS
--zap4
SELECT COUNT(*) FROM Milion WHERE Milion.liczba%117 IN
(SELECT pp.id_pietro FROM GeoPietro pp JOIN GeoEpoka ep ON pp.id_epoka=ep.id_epoka 
JOIN GeoOkres ok ON ep.id_okres=ok.id_okres JOIN GeoEra er  
ON ok.id_era=er.id_era JOIN GeoEon eo ON er.id_eon=eo.id_eon);


CREATE NONCLUSTERED INDEX IX_GeoTab ON GeoTabela(id_pietro);
CREATE NONCLUSTERED INDEX IX_Mil ON Milion(liczba);
CREATE NONCLUSTERED INDEX IX_GeoPie ON GeoPietro(id_pietro);
CREATE NONCLUSTERED INDEX IX_GeoEpo ON GeoEpoka(id_epoka);
CREATE NONCLUSTERED INDEX IX_GeoOkr ON GeoOkres(id_okres);
CREATE NONCLUSTERED INDEX IX_GeoEra ON GeoEra(id_era);
CREATE NONCLUSTERED INDEX IX_GeoEon ON GeoEon(id_eon);