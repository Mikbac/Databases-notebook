-- --------wyzwalacz1 - uniemozliwia reklamowanie zamowienia, ktore nie zostalo zrealizowane--------

CREATE TRIGGER reklamacjaNaZamowienie ON Reklamacje
AFTER INSERT
AS
    if('zrealizowany'!=(SELECT [status] FROM Zamowienia WHERE idZamowienia = (SELECT idRealizacji FROM RealizacjeZamowien WHERE idRealizacji = (SELECT idReklamowanejRealizacji FROM inserted))))
		BEGIN
		PRINT 'nie można reklamować/zwracac/wymieniac przedmiotu z niezrealizowanego zamowienia!';
		ROLLBACK;
		END


GO


INSERT INTO Reklamacje VALUES (1, 'reklamacja', 'niezatwierdzona', 'niezrealizowana');
INSERT INTO Reklamacje VALUES (4, 'reklamacja', 'niezatwierdzona', 'niezrealizowana');


SELECT * FROM Reklamacje

DROP TRIGGER reklamacjaNaZamowienie

-- --------wyzwalacz2 - uniemozliwia usuwanie dostawcow--------

CREATE TRIGGER usuwanieDostawcow ON Dostawcy
INSTEAD OF DELETE
AS
     PRINT 'nie mozna usuwac firm/dostawcow!';
GO


DELETE FROM Dostawcy
WHERE idDostawcy = 1

SELECT * FROM Dostawcy

DROP TRIGGER usuwanieDostawcow

-- --------wyzwalacz3 - uniemozliwia usuwanie kategorii--------

CREATE TRIGGER usuwanieKategorii ON KategorieProduktow
INSTEAD OF DELETE
AS
     PRINT 'nie mozna usuwac kategorii produktww!';
GO


DELETE FROM KategorieProduktow
WHERE idKategorii = 1

SELECT * FROM KategorieProduktow

DROP TRIGGER usuwanieKategorii

-- --------wyzwalacz3 - uniemozliwia usuwanie Zamowienia--------

CREATE TRIGGER usuwanieZamowien ON Zamowienia
INSTEAD OF DELETE
AS
     PRINT 'nie mozna usuwac zamowien!';
GO


DELETE FROM Zamowienia
WHERE idZamowienia = 1

SELECT * FROM Zamowienia

DROP TRIGGER usuwanieZamowien

-- --------wyzwalacz4 - usuwanie konta uzytkownika - usuniecie danych--------

CREATE TRIGGER usuwanieUzytkownika ON Uzytkownicy
INSTEAD OF DELETE
AS

PRINT 'nie mozna usuwac uzytkownika!';

GO

DELETE FROM Uzytkownicy
WHERE idUzytkownika = 1

SELECT * FROM Uzytkownicy

DROP TRIGGER usuwanieUzytkownika
