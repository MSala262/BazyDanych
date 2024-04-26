
CREATE DATABASE firma2; -- Utworzenie bazy danych o nazwie firma2
USE firma2; -- Wybranie baze danych firma2 do dalszej pracy

CREATE SCHEMA ksiegowosc; -- Utworzenie schematu o nazwie ksiegowosc w bazie danych firma

--Utworzenie piec nowych pustych tablic w schemacie ksiegowosc o nazwach kolejno Pracownicy, Godziny, Pensja, Premia i Wynagrodzenie

-- utworzenie tabeli pracownicy
CREATE TABLE ksiegowosc.pracownicy (
id_pracownika CHAR(3) NOT NULL PRIMARY KEY, /* pole od_pracownika jest kluczem glownym tej tabeli,
musi skladac sie z trzech znakow i nie moze byc ono puste */
imie VARCHAR(50) NOT NULL, /* to pole moze sie skladac maksymalnie z piedziesieciu znakow
i nie moze byc ono puste */
nazwisko VARCHAR(50) NOT NULL, -- tak jak wyzej
adres VARCHAR(150) NOT NULL, /* to pole moze sie skladac maksymalnie ze stu piedziesieciu znakow
i nie moze byc ono puste */
telefon	VARCHAR(15) -- to pole moze sie skladac maksymalnie z pietnastu znakow
);

-- utworzenie tabeli godziny
CREATE TABLE ksiegowosc.godziny (
	id_godziny CHAR(4) NOT NULL PRIMARY KEY, /* pole id_godziny jest kluczem glownym tej tabeli, 
musi skladac sie z czterech znakow i nie moze byc ono puste */
	data DATE NOT NULL, /* to pole zapisywanane jest w formacie daty kalendarzowej (rok-miesiac-dzien)
i nie moze byc ono puste */
	liczba_godzin INTEGER NOT NULL, /* to pole zapisanywane jest jako liczba calkowita
 i nie moze byc ono puste */
	id_pracownika CHAR(3) NOT NULL, -- to pole musi skladac sie z trzech znakow i nie moze byc ono puste
	FOREIGN KEY (id_pracownika) -- klucz obcy w tabeli
		REFERENCES ksiegowosc.pracownicy (id_pracownika) -- relacja tej tabeli z tabela pracownicy
		/* ON DELETE CASCADE -- mechanizm s³u¿¹cy do automatycznego usuwania powi¹zanych rekordów z tabeli nadrzêdnej
		ON UPDATE CASCADE -- mechanizm s³u¿¹cy do automatycznego aktualizowania powi¹zanych rekordów z tabeli nadrzêdnej */
);

-- utworzenie tabeli pensja
CREATE TABLE ksiegowosc.pensja (
	id_pensji INTEGER NOT NULL PRIMARY KEY, /* pole id_pensji jest kluczem glownym tej tabeli, 
zapisywane jako liczba calkowita i nie moze byc ono puste */
	stanowisko VARCHAR(50) NOT NULL, /* to pole moze sie skladac maksymalnie z piedziesieciu znakow
i nie moze byc ono puste */
	kwota DECIMAL(10,2) NOT NULL /* to pole jest zapisywane jako liczb przecinkowa, ktorej czesc calkowita moze
skladac sie maksymalnie z dziesieciu cyfr, a czesc dziesietna moze skladac sie maksymalnie z dwoch cyfr */
);

-- utworzenie tabeli premia
CREATE TABLE ksiegowosc.premia (
	id_premii CHAR(2) NOT NULL PRIMARY KEY, /* pole id_godziny jest kluczem glownym tej tabeli, 
musi skladac sie z dwoch znakow i nie moze byc ono puste */
	rodzaj VARCHAR(50), -- to pole moze sie skladac maksymalnie z piedziesieciu znakow
	kwota DECIMAL(10,2) NOT NULL
);

-- utworzenie tabeli wynagrodzenie
CREATE TABLE ksiegowosc.wynagrodzenie (
	id_wynagrodzenia CHAR(5) NOT NULL, 
	data DATE NOT NULL, 
	id_pracownika CHAR(3) NOT NULL,
	id_godziny CHAR(4) NOT NULL,
	id_pensji INTEGER NOT NULL,
	id_premii CHAR(2),
	FOREIGN KEY (id_pracownika)
		REFERENCES ksiegowosc.pracownicy (id_pracownika)
		/* ON DELETE CASCADE
		-- ON UPDATE CASCADE */,
	FOREIGN KEY (id_godziny)
		REFERENCES ksiegowosc.godziny (id_godziny)
		/* ON DELETE CASCADE
		ON UPDATE CASCADE */,
	FOREIGN KEY (id_pensji)
		REFERENCES ksiegowosc.pensja (id_pensji)
		/* ON DELETE CASCADE
		ON UPDATE CASCADE */,
	FOREIGN KEY (id_premii)
		REFERENCES ksiegowosc.premia (id_premii)
		/* ON DELETE CASCADE
		ON UPDATE CASCADE */
);

-- wypelnienie 10 rekordami tabllicy pracownicy
INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon) /* dzieki temu nawiasowi 
mozna dodac do tabeli wiele rekordow na raz wykorzystujac utorzony w ten sposob "wzor" */ VALUES
('A10' /* id_pracownika */, 'Aleksander' /* imie */, 'Sroka' /* nazwisko */, 'plac Szczepañski 5, 31-011 Kraków' /* adres */, '888 777 999' /* telefon*/), 
('A12' /* id_pracownika */, 'Daniel' /* imie */, 'Kustra' /* nazwisko */, 'ul. Œwiêtokrzyska 12, 30-015 Kraków' /* adres */, '108 553 232' /* telefon*/), -- tak samo reszta
('A23', 'Mateusz', 'Ziemba', 'ul. Juliusza Lea 114, 30-133 Kraków', '999 776 555'), ('B03', 'Magdalena', 'Skop', 'ul. Centralna 53, 31-586 Kraków', '333 222 999'),
('G05', 'Stanis³aw', 'Lis', 'ul. Ujastek 7, 31-752 Kraków', '654 354 568'), ('H62', 'Jadwiga', 'Grzebieñ', 'ul. Zakopiañska 9, 30-418 Kraków', '934 665 742'), 
('H57', 'Karol', 'Czapik', 'al. Zygmunta Krasiñskiego 18/3, 30-101 Kraków', '320 312 498'), ('L28', 'Mi³osz', 'He³dak', 'ul. Floriañska 3, 31-019 Kraków', '865 234 987'), 
('P14', 'Krystyna', 'Bularz', 'ul. Œw. Anny 9, 31-008 Kraków', '438 621 964'), ('P39', 'Lucyna', 'Kurlit', 'ul. W¹wozowa 34, 31-752 Kraków', '875 765 425');

-- wypelnienie 10 rekordami tabllicy godziny
INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin , id_pracownika) VALUES ('G021', '2022-03-30', 8, 'L28'),
('G041', '2022-04-21', 8, 'G05'), ('G101', '2022-05-29', 9, 'P39'), ('G111', '2022-05-29', 9, 'A10'), 
('F879', '2022-01-09', 10, 'A23'), ('G402', '2022-07-09', 9, 'B03'), ('G477', '2022-08-30', 8, 'H62'),
('E887', '2021-05-16', 8, 'A10'), ('G850', '2022-10-22', 10, 'P14'), ('A784', '2019-02-17', 8, 'H57');

-- wypelnienie 10 rekordami tabllicy pensja
INSERT INTO ksiegowosc.pensja (id_pensji, stanowisko, kwota) VALUES (11, 'Asystent', 2000), 
(30, 'Dyrektor', 10000), (42, 'Analityk', 7000), (123, 'Specjalista', 4800),
(155, 'Asystent', 1500), (268, 'Sekretarz', 5900), (312, 'Specjalista', 5000),
(335, 'Analityk', 6400), (397, 'Dyrektor', 3700), (426, 'Menad¿er', 8500);

-- wypelnienie 10 rekordami tabllicy premia
INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota) VALUES ('A7', 'Œwi¹teczna', 700),
('B3', 'Uznaniowa', 1000), ('B9', 'Za frekwencjê', 500), ('C4', NULL, 100),
('F0', 'Regulaminowa', 300), ('J1', 'Kwartalna', 1500 ), ('K3', 'Regulaminowa', 800),
('M7', 'Motywacyjna', 750), ('R5', 'Roczna', 3000), ('W8', NULL, 150);

-- wypelnienie 10 rekordami tabllicy wynagrodzenie
INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES 
('E1004', '2022-04-02', 'L28', 'G021', 30, 'W8'), ('E1504', '2022-04-22', 'G05', 'G041', 268, NULL),
('E9012', '2022-05-31', 'P39', 'G101', 11, 'M7'), ('E9067', '2022-05-31', 'A10', 'G111', 426, NULL),
('A6721', '2022-02-03', 'A23', 'F879', 335, 'A7'), ('J9002', '2022-07-30', 'B03', 'G402', 42, 'F0'),
('E1810', '2022-11-01', 'B03', 'G850', 312, NULL), ('A0004', '2019-03-02', 'H57', 'A784', 123, 'B9'),
('C0030', '2021-06-06', 'A10', 'E887', 155, 'B3'), ('M0079', '2022-09-08', 'H62', 'G477', 397, NULL);


-- a
ALTER TABLE ksiegowosc.pracownicy ADD nr_telefonu_PLN VARCHAR(20);

UPDATE ksiegowosc.pracownicy 
SET nr_telefonu_PLN = '(+48) ' + telefon;

/*UPDATE ksiegowosc.pracownicy 
SET nr_telefonu_PLN = CONCAT('(+48) ', telefon);*/

SELECT * FROM ksiegowosc.pracownicy;
-- b
ALTER TABLE ksiegowosc.pracownicy ADD nr_telefonu VARCHAR(20);

UPDATE ksiegowosc.pracownicy 
SET nr_telefonu = SUBSTRING(telefon, 1, 3)+'-'+SUBSTRING(telefon, 5, 3)+'-'+SUBSTRING(telefon, 9, 3);

/*UPDATE ksiegowosc.pracownicy 
SET nr_telefonu = CONCAT(SUBSTRING(telefon, 1, 3), '-', SUBSTRING(telefon, 5, 3), '-', SUBSTRING(telefon, 9, 3));*/

SELECT * FROM ksiegowosc.pracownicy;
-- c
SELECT id_pracownika, UPPER(imie) AS imie,
       UPPER(nazwisko) AS nazwisko,
	   UPPER(adres) AS adres, telefon
FROM ksiegowosc.pracownicy
WHERE LEN(nazwisko) = (SELECT MAX(LEN(nazwisko)) FROM ksiegowosc.pracownicy);

/*SELECT id_pracownika, UPPER(imie) AS imie,
       UPPER(nazwisko) AS nazwisko,
	   UPPER(adres) AS adres, telefon
FROM ksiegowosc.pracownicy
ORDER BY CHAR_LENGTH(nazwisko) DESC
LIMIT 1;*/

SELECT id_pracownika, UPPER(imie) AS imie,
       UPPER(nazwisko) AS nazwisko,
	   UPPER(adres) AS adres, telefon
FROM ksiegowosc.pracownicy
ORDER BY LEN(nazwisko) DESC;
-- d
SELECT pra.imie, HASHBYTES('MD5', pra.imie) AS imie_md5,
	pra.nazwisko, HASHBYTES('MD5', pra.nazwisko) AS nazwisko_md5,
	pra.telefon, HASHBYTES('MD5', pra.telefon) AS telefon_md5,
	pen.kwota, HASHBYTES('MD5', CAST(pen.kwota AS VARCHAR)) AS pensja_md5
FROM ksiegowosc.pracownicy pra
LEFT JOIN ksiegowosc.wynagrodzenie wyn ON pra.id_pracownika = wyn.id_pracownika
LEFT JOIN ksiegowosc.pensja pen ON pen.id_pensji = wyn.id_pensji;

-- e (f)
SELECT pra.id_pracownika, pra.imie, pra.nazwisko, pra.adres, pra.telefon, pen.kwota AS pensja, pre.kwota AS premia FROM ksiegowosc.pracownicy pra
LEFT JOIN ksiegowosc.wynagrodzenie wyn
ON wyn.id_pracownika=pra.id_pracownika
LEFT JOIN ksiegowosc.pensja pen
ON wyn.id_pensji=pen.id_pensji
LEFT JOIN ksiegowosc.premia pre
ON wyn.id_premii=pre.id_premii;

-- f (g)
-- Wzór: Pracownik Jan Nowak, w dniu 7.08.2017 otrzyma³ pensjê ca³kowit¹ na kwotê 7540 z³, gdzie wynagrodzenie zasadnicze wynosi³o: 5000 z³, premia: 2000 z³, nadgodziny: 540 godzin
SELECT 'Pracownik '+pra.imie+' '+pra.nazwisko+', w dniu '+CONVERT(VARCHAR, DATEPART(day,wyn.data))
		+'.'+(CASE WHEN DATEPART(month,wyn.data) < 10 
			THEN '0'+ CONVERT(VARCHAR, DATEPART(month,wyn.data))
			ELSE CONVERT(VARCHAR, DATEPART(month,wyn.data))
			END)+'.'+CONVERT(VARCHAR, DATEPART(year,wyn.data))
		+' otrzyma³ pensjê ca³kowit¹ na kwotê '+CONVERT(VARCHAR,(pen.kwota+COALESCE(pre.kwota,0)))+' z³, gdzie wynagrodzenie zasadnicze wynosi³o: '
		+CONVERT(VARCHAR,pen.kwota)+' z³, premia: '+CONVERT(VARCHAR,COALESCE(pre.kwota,0))+' z³, nadgodziny: '+CONVERT(VARCHAR,(CASE WHEN god.liczba_godzin*20 > 160 
												/*THEN (god.liczba_godzin*20 - 160) 
												ELSE 0 
												END))*/
												THEN (god.liczba_godzin*20 - 160)*12
												ELSE 0 
												END)) +' z³' AS Raport
		--+ ' godzin' AS Raport -- brak kolumny o przeliczniku na nadgodziny
FROM ksiegowosc.pracownicy pra
JOIN ksiegowosc.wynagrodzenie wyn
ON wyn.id_pracownika=pra.id_pracownika
JOIN ksiegowosc.pensja pen
ON wyn.id_pensji=pen.id_pensji
LEFT JOIN ksiegowosc.premia pre
ON wyn.id_premii=pre.id_premii
LEFT JOIN ksiegowosc.godziny god
ON wyn.id_godziny=god.id_godziny
GROUP BY pra.imie, pra.nazwisko, wyn.data, pen.kwota, pre.kwota, god.liczba_godzin;
