--drop DATABASE Sklep
--GO

--CREATE DATABASE Sklep
--GO

--USE Sklep
--GO

SET LANGUAGE polski
GO

-------- USUÑ TABELE
IF OBJECT_ID('Reklamacje', 'U') IS NOT NULL
    DROP TABLE Reklamacje;

IF OBJECT_ID('RealizacjeZamowien', 'U') IS NOT NULL
    DROP TABLE RealizacjeZamowien;

IF OBJECT_ID('Zamowienia', 'U') IS NOT NULL
    DROP TABLE Zamowienia;

IF OBJECT_ID('Uzytkownicy', 'U') IS NOT NULL
    DROP TABLE Uzytkownicy;

IF OBJECT_ID('Produkty', 'U') IS NOT NULL
    DROP TABLE Produkty;

IF OBJECT_ID('Dostawcy', 'U') IS NOT NULL
    DROP TABLE Dostawcy;

IF OBJECT_ID('KategorieProduktow', 'U') IS NOT NULL
    DROP TABLE KategorieProduktow;

--------- CREATE - UTWÓRZ TABELE I POWI¥ZANIA

CREATE TABLE Uzytkownicy
(
    idUzytkownika   INT IDENTITY (1,1) NOT NULL PRIMARY KEY, -- sprawdzic, czy od 1 co 1
    imie            VARCHAR(30)        NOT NULL,
    nazwisko        VARCHAR(30)        NOT NULL,
    adres           VARCHAR(30)        NOT NULL,
    haslo           VARCHAR(30)        NOT NULL,
    email           VARCHAR(30)        NOT NULL UNIQUE,
    numerTelefonu   VARCHAR(9)         NOT NULL,
    dataRejestracji DATETIME           NOT NULL,
    CHECK (haslo != imie)
);

CREATE TABLE KategorieProduktow
(
    idKategorii             INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    nazwa                   VARCHAR(30)        NOT NULL,
    czasNaRealizacjeWDniach INT                NOT NULL
);

CREATE TABLE Dostawcy
(
    idDostawcy              INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    nazwa                   VARCHAR(30)        NOT NULL,
    dlugoscGwarancjiWLatach INT                NOT NULL,
    adresSerwisu            VARCHAR(30)        NOT NULL,
    nrTelefonu              VARCHAR(9)         NOT NULL
);

CREATE TABLE Produkty
(
    idProduktu  INT IDENTITY (1,1)                                  NOT NULL PRIMARY KEY,
    idKategorii INT REFERENCES KategorieProduktow (idKategorii) NOT NULL,
    idDostawcy  INT REFERENCES Dostawcy (idDostawcy) NOT            NULL,
    cena        MONEY                                               NOT NULL,
    nazwa       VARCHAR(30)                                         NOT NULL,
    ilosc       INT                                                 NOT NULL
);

CREATE TABLE Zamowienia
(
    idZamowienia            INT IDENTITY (1,1)                             NOT NULL PRIMARY KEY,
    idZamawiajacego         INT REFERENCES Uzytkownicy (idUzytkownika) NOT NULL,
    dataPrzyjeciaZamowienia DATETIME                                       NOT NULL,
    [status]                VARCHAR(30)                                    NOT NULL CHECK ([status] IN ('w realizacji', 'zrealizowany', 'anulowane'))
);

CREATE TABLE RealizacjeZamowien
(
    idRealizacji INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    idZamowienia INT                NOT NULL REFERENCES Zamowienia (idZamowienia),
    idProduktu   INT                NOT NULL REFERENCES Produkty (idProduktu),
    ilosc        INT                NOT NULL,
    [stan]       VARCHAR(30)        NOT NULL CHECK ([stan] IN ('przygotowywany', 'gotowy', 'anulowane'))
);

CREATE TABLE Reklamacje
(
    idReklamacji                 INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    idReklamowanejRealizacji     INT                NOT NULL REFERENCES RealizacjeZamowien (idRealizacji),
    [rodzajReklamacji]           VARCHAR(30)        NOT NULL CHECK ([rodzajReklamacji] IN ('reklamacja', 'zwrot', 'wymiana')),
    [statusReklamacji]           VARCHAR(30)        NOT NULL CHECK ([statusReklamacji] IN ('zatwierdzona', 'niezatwierdzona')),
    [stanRealizowaniaReklamacji] VARCHAR(30)        NOT NULL CHECK ([stanRealizowaniaReklamacji] IN ('zrealizowana', 'niezrealizowana'))
);


