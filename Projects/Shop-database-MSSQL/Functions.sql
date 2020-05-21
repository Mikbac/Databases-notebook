-- --------funkcja1 - zwracanie informacji ile w sklepie wydal dany uzytkownik, idUzytkownika--------
create function zyskiZUzytkownika
        (@idUzytkownika INT)
        returns MONEY
as
begin

	DECLARE @wynik MONEY

	SET @wynik = (SELECT SUM(cena)
	FROM Uzytkownicy
	LEFT OUTER JOIN Zamowienia a3 ON a3.idZamawiajacego=idUzytkownika
	LEFT OUTER JOIN RealizacjeZamowien a2 ON a2.idRealizacji=a3.idZamowienia
	LEFT OUTER JOIN Produkty a1 ON a1.idProduktu=a2.idProduktu
	WHERE idUzytkownika=@idUzytkownika)

	RETURN @wynik

end


SELECT dbo.zyskiZUzytkownika(1) 'uzytkownik wydal'


DROP FUNCTION zyskiZUzytkownika


-- --------funkcja2 - zwraca kupcow towaru o podanym id--------

create function kupcyProduktu
        (@idProduktu INT)
        returns table
as
        return SELECT  idUzytkownika, imie, nazwisko FROM Uzytkownicy
		LEFT OUTER JOIN Zamowienia a3 ON a3.idZamawiajacego=idUzytkownika
	LEFT OUTER JOIN RealizacjeZamowien a2 ON a2.idRealizacji=a3.idZamowienia
	LEFT OUTER JOIN Produkty a1 ON a1.idProduktu=a2.idProduktu
	WHERE a2.idProduktu = @idProduktu


SELECT * FROM dbo.kupcyProduktu(12)


DROP FUNCTION kupcyProduktu

