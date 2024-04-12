CREATE DATABASE firma;

USE firma;

CREATE SCHEMA rozliczenia;


CREATE TABLE rozliczenia.pracownicy (
id_pracownika CHAR(3) NOT NULL PRIMARY KEY,
imie VARCHAR(50) NOT NULL,
nazwisko VARCHAR(50) NOT NULL,
adres VARCHAR(150) NOT NULL,
telefon	VARCHAR(15)
);

CREATE TABLE rozliczenia.godziny(
id_godziny CHAR(4) NOT NULL PRIMARY KEY, 
data DATE NOT NULL, 
liczba_godzin INTEGER NOT NULL, 
id_pracownika CHAR(3) NOT NULL
);

CREATE TABLE rozliczenia.pensje(
id_pensji INTEGER NOT NULL PRIMARY KEY, 
stanowisko VARCHAR(50) NOT NULL, 
kwota DECIMAL(10,2) NOT NULL,
id_premii CHAR(2)
);

CREATE TABLE rozliczenia.premie(
id_premii CHAR(2) NOT NULL PRIMARY KEY, 
rodzaj VARCHAR(50), 
kwota DECIMAL(10,2) NOT NULL
);


ALTER TABLE rozliczenia.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);


INSERT INTO rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon) VALUES ('A10', 'Aleksander', 'Sroka', 'plac Szczepañski 5, 31-011 Kraków', '888 777 999'),
('A12', 'Daniel', 'Kustra', 'ul. Œwiêtokrzyska 12, 30-015 Kraków', '108 553 232'), ('A23', 'Mateusz', 'Ziemba', 'ul. Juliusza Lea 114, 30-133 Kraków', '999 776 555'),
('B03', 'Magdalena', 'Skop', 'ul. Centralna 53, 31-586 Kraków', '333 222 999'), ('G05', 'Stanis³aw', 'Lis', 'ul. Ujastek 7, 31-752 Kraków', '654 354 568'),
('H62', 'Jadwiga', 'Grzebieñ', 'ul. Zakopiañska 9, 30-418 Kraków', '934 665 742'), ('H57', 'Karol', 'Czapik', 'al. Zygmunta Krasiñskiego 18/3, 30-101 Kraków', '320 312 498'),
('L28', 'Mi³osz', 'He³dak', 'ul. Floriañska 3, 31-019 Kraków', '865 234 987'), ('P14', 'Krystyna', 'Bularz', 'ul. Œw. Anny 9, 31-008 Kraków', '438 621 964'),
('P39', 'Lucyna', 'Kurlit', 'ul. W¹wozowa 34, 31-752 Kraków', '875 765 425');

INSERT INTO rozliczenia.godziny (id_godziny, data, liczba_godzin , id_pracownika) VALUES ('G021', '2022-03-30', 6, 'L28'),
('G041', '2022-04-21', 5, 'G05'), ('G101', '2022-05-29', 7, 'P39'), ('G111', '2022-05-29', 6, 'A10'), 
('F879', '2022-01-09', 8, 'A23'), ('G402', '2022-07-09', 6, 'B03'), ('G477', '2022-08-30', 4, 'H62'),
('E887', '2021-05-16', 6, 'A10'), ('G850', '2022-10-22', 8, 'P14'), ('A784', '2019-02-17', 5, 'H57');

INSERT INTO rozliczenia.pensje (id_pensji, stanowisko, kwota, id_premii) VALUES (11, 'Asystent', 3700.00, NULL), 
(30, 'Dyrektor', 10000.00, NULL), (42, 'Analityk', 7000.00, 'J1'), (123, 'Specjalista', 4800.00, 'A7'),
(155, 'Asystent', 3750.00, 'A7'), (268, 'Sekretarz', 5900.00, 'B3'), (312, 'Specjalista', 5000.00, 'B9'),
(335, 'Analityk', 6400.00, NULL), (397, 'Dyrektor', 3700.00, NULL), (426, 'Menad¿er', 8500.00, 'J1');

INSERT INTO rozliczenia.premie (id_premii, rodzaj, kwota) VALUES ('A7', 'Œwi¹teczna', 700.00),
('B3', 'Uznaniowa', 1000.00), ('B9', 'Za frekwencjê', 500.00), ('C4', NULL, 100.00),
('F0', 'Regulaminowa', 300.00), ('J1', 'Kwartalna', 1500.00 ), ('K3', 'Regulaminowa', 800.00),
('M7', 'Motywacyjna', 750.00), ('R5', 'Roczna', 3000.00), ('W8', NULL, 150.00);


SELECT nazwisko, adres FROM rozliczenia.pracownicy;


SELECT id_godziny, data, liczba_godzin , id_pracownika,	DATEPART(dw, data) AS dzien_tygodnia, DATEPART(mm, data) FROM rozliczenia.godziny;


EXECUTE sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';

--ALTER TABLE rozliczenia.pensje RENAME COLUMN kwota TO kwota_brutto;

ALTER TABLE rozliczenia.pensje ADD kwota_netto DECIMAL(10,2);

UPDATE rozliczenia.pensje
SET kwota_netto = ROUND((kwota_brutto/1.23), 2);


SELECT kwota_netto, kwota_brutto from rozliczenia.pensje;


COMMIT;

