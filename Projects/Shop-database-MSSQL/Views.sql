-- --------widok1 - co kto zamowil--------

CREATE VIEW ZamowieniaUzytkownikow(imie, nazwisko, nazwa)
AS
(
SELECT imie, nazwisko, nazwa
FROM Uzytkownicy
	LEFT OUTER JOIN Zamowienia z1 on idZamawiajacego=idUzytkownika
	LEFT OUTER JOIN RealizacjeZamowien z2 on z1.idZamowienia=z2.idZamowienia
	INNER JOIN Produkty p1 on p1.idProduktu=z2.idProduktu
);


SELECT *
FROM   ZamowieniaUzytkownikow;

DROP VIEW ZamowieniaUzytkownikow


-- --------widok2 - ile w jakiej firmie zamowiono--------

CREATE VIEW ZamowieniaFirm(nazwa, ilosc)
AS
(
SELECT d1.nazwa, COUNT(d1.nazwa) AS 'ilosc'
FROM Uzytkownicy
	LEFT OUTER JOIN Zamowienia z1 on idZamawiajacego=idUzytkownika
	LEFT OUTER JOIN RealizacjeZamowien z2 on z1.idZamowienia=z2.idZamowienia
	INNER JOIN Produkty p1 on p1.idProduktu=z2.idProduktu
	LEFT OUTER JOIN Dostawcy d1 on d1.idDostawcy=p1.idDostawcy
	GROUP BY d1.nazwa
);


SELECT *
FROM   ZamowieniaFirm;

DROP VIEW ZamowieniaFirm

-- --------widok3 - ile zamowiono danych produktow--------

CREATE VIEW ZamowieniaTowarow(nazwa, ilosc)
AS
(
SELECT p1.nazwa, SUM(z2.ilosc) AS 'ilosc'
FROM Uzytkownicy
	LEFT OUTER JOIN Zamowienia z1 on idZamawiajacego=idUzytkownika
	LEFT OUTER JOIN RealizacjeZamowien z2 on z1.idZamowienia=z2.idZamowienia
	INNER JOIN Produkty p1 on p1.idProduktu=z2.idProduktu
	GROUP BY p1.nazwa
);


SELECT *
FROM   ZamowieniaTowarow;

DROP VIEW ZamowieniaTowarow
