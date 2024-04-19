/* ZAD 1 */
CREATE DATABASE firma1; -- Utworzenie bazy danych o nazwie firma1
USE firma1; -- Wybranie baze danych firma1 do dalszej pracy

/* ZAD 2 */
CREATE SCHEMA ksiegowosc; -- Utworzenie schematu o nazwie ksiegowosc w bazie danych firma

/* ZAD 4
Utworzenie piec nowych pustych tablic w schemacie ksiegowosc o nazwach kolejno Pracownicy, Godziny, Pensja, Premia i Wynagrodzenie */

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

/* ZAD 5
Wypelnianie tabel dziesiecioma rekordami za pomoca polecenia INSERT INTO nazwa_tabeli (nazwy_pol) VALUES (rekord), (rekord) */


-- wypelnienie 10 rekordami tabllicy pracownicy
INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon) /* dzieki temu nawiasowi mozna dodac do tabeli wiele rekordow na raz wykorzystujac utorzony w ten sposob "wzor" */ VALUES
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
INSERT INTO ksiegowosc.pensja (id_pensji, stanowisko, kwota) VALUES (11, 'Asystent', 2000.00), 
(30, 'Dyrektor', 10000.00), (42, 'Analityk', 7000.00), (123, 'Specjalista', 4800.00),
(155, 'Asystent', 1500.00), (268, 'Sekretarz', 5900.00), (312, 'Specjalista', 5000.00),
(335, 'Analityk', 6400.00), (397, 'Dyrektor', 3700.00), (426, 'Menad¿er', 8500.00);

-- wypelnienie 10 rekordami tabllicy premia
INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota) VALUES ('A7', 'Œwi¹teczna', 700.00),
('B3', 'Uznaniowa', 1000.00), ('B9', 'Za frekwencjê', 500.00), ('C4', NULL, 100.00),
('F0', 'Regulaminowa', 300.00), ('J1', 'Kwartalna', 1500.00 ), ('K3', 'Regulaminowa', 800.00),
('M7', 'Motywacyjna', 750.00), ('R5', 'Roczna', 3000.00), ('W8', NULL, 150.00);

-- wypelnienie 10 rekordami tabllicy wynagrodzenie
INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES 
('E1004', '2022-04-02', 'L28', 'G021', 30, 'W8'), ('E1504', '2022-04-22', 'G05', 'G041', 268, NULL),
('E9012', '2022-05-31', 'P39', 'G101', 11, 'M7'), ('E9067', '2022-05-31', 'A10', 'G111', 426, NULL),
('A6721', '2022-02-03', 'A23', 'F879', 335, 'A7'), ('J9002', '2022-07-30', 'B03', 'G402', 42, 'F0'),
('E1810', '2022-11-01', 'B03', 'G850', 312, NULL), ('A0004', '2019-03-02', 'H57', 'A784', 123, 'B9'),
('C0030', '2021-06-06', 'A10', 'E887', 155, 'B3'), ('M0079', '2022-09-08', 'H62', 'G477', 397, NULL);



/* ZAD 6 */


-- a
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy; /* polecenie, ktore wypisze rekordy odpowiadajace kolumnom
podanym miedzy SELECT a FROM z tabeli pracownicy */


-- b
SELECT wyn.id_pracownika FROM  ksiegowosc.wynagrodzenie wyn -- 'wyn' - alias tabeli wynagrodzenie
JOIN ksiegowosc.pensja pen -- zlaczenie zewnetrzne drugiej tabeli, 'pen' - alias tabeli pensja
ON wyn.id_pensji = pen.id_pensji -- warunek zlaczenia
WHERE pen.kwota > 1000; -- warunek wyboru rekordow, w mojej bazie wszystkie spelniaja
-- WHERE pen.kwota > 5000; -- spelnia 5 rekordow

/*SELECT id_pracownika FROM  ksiegowosc.wynagrodzenie, ksiegowosc.pensja -- polecenie, ktore wypisze rekordy odpowiadajace kolumnie id_pracownika z tabeli wynagrodzenie,
WHERE wynagrodzenie.id_pensji = pensja.id_pensji AND kwota > 1000; /* gdzie wartosc pola w kolumnie id_pensji jest taka sama w obu tabelach
(wynagrodzenie i pensja) i kwota jest wieksza niz 1000 */

SELECT id_pracownika FROM ksiegowosc.wynagrodzenie -- polecenie, ktore wypisze rekordy odpowiadajace kolumnie id_pracownika z tabeli wynagrodzenie,
WHERE id_pensji IN (SELECT id_pensji FROM ksiegowosc.pensja WHERE kwota > 1000); /* gdzie wartosci pol z kolumny id_pensji z tabeli wynagrodzenie sa takie same
jak warosci pol z kolumny id_pensji w tabeli pensja, gdzie kwota jest wieksza niz 1000 */

SELECT id_pracownika FROM ksiegowosc.wynagrodzenie -- polecenie, ktore wypisze rekordy odpowiadajace kolumnie: id_pracownika z tabeli wynagrodzenie,
RIGHT OUTER JOIN ksiegowosc.pensja -- zwraca wszystkie rekordy z tabeli pensja,
ON pensja.id_pensji = wynagrodzenie.id_pensji -- gdzie wartosci pol z kolumny id_pensji sa takie same w obu tabelach (wynagrodzenie i pensja),
WHERE pensja.kwota > 1000; -- gdzie wartosci pol z kolumny kwota w tabeli pensja sa wieksze niz 1000*/


-- c
SELECT wyn.id_pracownika FROM ksiegowosc.wynagrodzenie wyn -- 'wyn' - alias tabeli wynagrodzenie
JOIN ksiegowosc.pensja pen -- zlaczenie zewnetrzne z druga tabela, 'pen' - alias tabeli pensja
ON wyn.id_pensji = pen.id_pensji -- warunek zlaczenia
WHERE pen.kwota > 2000 AND wyn.id_premii IS NULL; -- warunek wyboru rekordow

/*SELECT id_pracownika FROM ksiegowosc.wynagrodzenie -- polecenie, ktore wypisze rekordy odpowiadajace kolumnie id_pracownika z tabeli wynagrodzenie,
WHERE id_premii IS NULL -- gdzie pole w kolumnie id_premii w tabeli wynagrodzenie jest puste (wartosc NULL) i
AND id_pensji IN (SELECT id_pensji FROM ksiegowosc.pensja WHERE kwota > 2000); /* gdzie wartosci z kolumny id_pensji z tabeli wynagrodzenie sa takie same,
jak wartosci z kolumny id_pensji w tabeli pensja, gdzie wartosci pol z koluny kwota (z tabeli pensja) sa wieksze niz 2000 */*/


-- d
SELECT * FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%'; /* polecenie, ktore wypisze rekordy z wszystkich kolumn z tabeli pracownicy,
ktore spelniaja warunek: wartosc pola imie zaczyna sie na litere J */

-- e, nazwisko, w ktorym jest litera n oraz imie zakonczone na a
SELECT * FROM ksiegowosc.pracownicy WHERE nazwisko LIKE '%n%' AND imie LIKE '%a'; -- w mojej bazie danych nie ma rekordow spelniajacych takie warunki
SELECT * FROM ksiegowosc.pracownicy WHERE nazwisko LIKE '%l%' AND imie LIKE '%a'; -- przyklad w ktorym warunki sa spelnione dla mojej bazy danych

-- f, rekordy z imieniem, nazwiskiem i liczba_godzin, ktorych wartosci z kolumny liczba_godzin pomnozone przez 20 przekroczyla liczbe 160 w miesiacu (nadgodziny)
SELECT pra.imie, pra.nazwisko, god.liczba_godzin*20-160 AS liczba_nadgodzin FROM ksiegowosc.godziny god -- 'god' - alias tablicy godziny
JOIN ksiegowosc.pracownicy pra -- zlaczenie zewnetrzne z druga tabela, 'pra' - alias tabeli pracownicy
ON god.id_pracownika = pra.id_pracownika -- warunek zlaczenia
WHERE god.liczba_godzin*20 > 160; -- warunek wyboru rekordow

/*SELECT imie, nazwisko, liczba_godzin FROM ksiegowosc.pracownicy, ksiegowosc.godziny /* polecenie, ktore wypisze rekordy odpowiadajace kolumnom: imie i nazwisko 
z tabeli pracownicy oraz liczba_godzin z tabeli godziny, */
WHERE pracownicy.id_pracownika = godziny.id_pracownika -- gdzie wartosci pol z kolumn id_pracownika w obu tabelach sa sobie rowne
AND godziny.liczba_godzin*20 > 160; -- oraz wartosc pol z koluny liczba godzin z tabeli godziny pomnozona przez 20 (20 dni roboczych w miesiacu / 4 tygodnie po 5 dni w miesiacu) przekroczyla liczbe 160*/

-- g
SELECT pra.imie, pra.nazwisko FROM ksiegowosc.wynagrodzenie wyn -- 'wyn' - alias tabeli wynagrodzenie
JOIN ksiegowosc.pracownicy pra -- zlaczenie zewnetrzne z druga tabela, 'pra' - alias tabeli pracownicy
ON pra.id_pracownika = wyn.id_pracownika -- warunek zlaczenia
JOIN ksiegowosc.pensja pen -- zlaczenie zewnetrzne z trzecia tabela, 'pen' - alias tabeli pensja
ON pen.id_pensji = wyn.id_pensji -- warunek zlaczenia
-- WHERE pen.kwota BETWEEN 1500 AND 3000; -- w mojej bazie danych nie ma rekordow spelniajacych takie warunki
WHERE pen.kwota BETWEEN 5000 AND 10000; -- warunek wyboru rekordow (wzgledem kwoty z tabeli pensja, wartosci pomiedzy liczbami 5000 a 1000)

/*SELECT imie, nazwisko FROM ksiegowosc.pracownicy WHERE id_pracownika IN (SELECT id_pracownika FROM ksiegowosc.wynagrodzenie WHERE id_pensji 
IN (SELECT id_pensji FROM ksiegowosc.pensja WHERE kwota BETWEEN 5000 AND 10000));*/

-- h
SELECT pra.imie, pra.nazwisko FROM ksiegowosc.wynagrodzenie wyn -- 'wyn' - alias tablicy godziny
JOIN ksiegowosc.pracownicy pra -- zlaczenie zewnetrzne z druga tabela, 'pra' - alias tabeli pracownicy
ON wyn.id_pracownika = pra.id_pracownika -- warunek zlaczenia
JOIN ksiegowosc.godziny god -- zlaczenie zewnetrzne z trzecia tabela, 'god' - alias tabeli
ON wyn.id_godziny = god.id_godziny -- warunek zlaczenia
WHERE god.liczba_godzin*20 > 160 AND wyn.id_premii IS NULL; -- warunek wyboru rekordow


-- i
SELECT pra.imie, pra.nazwisko, pen.kwota FROM ksiegowosc.wynagrodzenie wyn -- 'wyn' - alias tabeli
JOIN ksiegowosc.pracownicy pra -- zlaczenie zewnetrzne z druga tabela, 'pra' - alias tabeli
ON wyn.id_pracownika = pra.id_pracownika -- warunek zlaczenia
JOIN ksiegowosc.pensja pen -- zlaczenia zewnetrzne z trzecia tabela, 'pen' - alias tabeli
ON wyn.id_pensji = pen.id_pensji -- warunek zlaczenia
ORDER BY pen.kwota ASC; -- sortowanie rosnaco wzgledem kwoty z tabeli pensja (domyslie klauzula ORDER BY sortuje rekordy rosnaco, wiec nie jest konieczne definiowania jej)
-- ORDER BY pen.kwota DESC; -- sortowanie malejaco wzgledem kwoty z tabeli pensja

-- j
SELECT pra.imie, pra.nazwisko, pen.kwota AS kwota_pensji, pre.kwota AS kwota_premii FROM ksiegowosc.wynagrodzenie wyn -- 'wyn' - alias tabeli
JOIN ksiegowosc.pracownicy pra -- zlaczenie zewnetrzne z druga tabela, 'pra' - alias tabeli
ON wyn.id_pracownika = pra.id_pracownika -- warunek zlaczenia
JOIN ksiegowosc.pensja pen -- zlaczenia zewnetrzne z trzecia tabela, 'pen' - alias tabeli
ON wyn.id_pensji = pen.id_pensji -- warunek zlaczenia
JOIN ksiegowosc.premia pre -- zlaczenia zewnetrzne z czwarta tabela, 'pre' - alias tabeli
ON wyn.id_premii = pre.id_premii -- warunek zlaczenia
ORDER BY pen.kwota DESC, pre.kwota DESC; /* sortowanie malejace rekordow najpierw wzgledem kolumny kwoty z tabeli pensja, 
a nastepnie rowniez sortowanie malejace rekordow (przed chwila posortowanych) wzgledem kolumny kwota z tabeli premii */
-- ORDER BY pre.kwota DESC, pen.kwota DESC; -- sortowanie malejace rekordow najpierw wzgledem kolumny kwoty z tabeli premia, 
 -- a nastepnie rowniez sortowanie malejace rekordow (przed chwila posortowanych) wzgledem kolumny kwota z tabeli pensja */
