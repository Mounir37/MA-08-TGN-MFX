--Author : Thomas Grossmann / Mounir Fiaux
--Database : SiteJeux_BD_TGN_MFX
--Date : 15.01.2020

use master
go

--If the database exists it drops it and create the new one--
IF db_id('SiteJeuxBD_TGN_MFX') IS NOT NULL
BEGIN
	drop database SiteJeuxBD_TGN_MFX
END

--Creation of the database
CREATE DATABASE SiteJeuxBD_TGN_MFX
	ON PRIMARY
	--Properties of the database's file
	( NAME = 'SiteJeuxBD_TGN_MFX', FILENAME = 'C:\TGN_MFX\SiteJeuxBD_TGN_MFX.mdf', SIZE = 20480KB , MAXSIZE = 51200KB, FILEGROWTH = 1024KB )
	--Properties of the database's logs file
	LOG ON
	( NAME = 'SIteJeuxBD_TGN_MFX_log', FILENAME = 'C:\TGN_MFX\SiteJeuxBD_TGN_MFX.ldf', SIZE = 10240KB , MAXSIZE = 20480KB , FILEGROWTH = 1024KB)
go

use SiteJeuxBD_TGN_MFX
go

--Creation of the table accessories with type, price, name
create table accessories (
	accessoriesID int NOT NULL PRIMARY KEY,
	type varchar(50),
	price float CHECK(price>=0),
	name varchar(50)
)

--Creation of the table customers with lastname, firstname, nickname, mail, phoneNumber
create table customers (
	customersID int NOT NULL PRIMARY KEY,
	lastname varchar(45),
	firstname varchar(45),
	nickname varchar(30),
	mail varchar(80),
	phoneNumber int
)

--Creation of the table develpments with cost, duration
create table developments (
	developmentsID int NOT NULL PRIMARY KEY,
	cost int,
	duration datetime
)

----Creation of the table types_providers with name
create table types_providers (
	types_providersID int NOT NULL PRIMARY KEY,
	name varchar(45)
)

--Creation of the table platforms with name, type
create table platforms (
	platformsID int NOT NULL PRIMARY KEY,
	name varchar(45),
	type varchar(45)
)

--Creation of the table reductions with name, pourcentage, deadline, foreign key to customersID
create table reductions (
	reductionsID int NOT NULL PRIMARY KEY,
	name varchar(45),
	pourcentage float,
	deadline date,
	customers_id int FOREIGN KEY REFERENCES customers(customersID)
)

--Creation of the table payments with type, foreign key to 
create table payments (
	paymentsID int NOT NULL PRIMARY KEY,
	type varchar(45),
	customers_id int FOREIGN KEY REFERENCES customers(customersID)
)

create table orders (
	ordersID int NOT NULL PRIMARY KEY,
	number int,
	description varchar(100),
	address varchar(45),
	customers_id int FOREIGN KEY REFERENCES customers(customersID)
)

create table games (
	gamesID int NOT NULL PRIMARY KEY,
	name varchar(45),
	price float CHECK(price>=0),
	releaseDate date,
	developments_id int FOREIGN KEY REFERENCES developments(developmentsID)
)

create table accessories_has_customers (
	accessories_id int FOREIGN KEY REFERENCES accessories(accessoriesID),
	customers_id int FOREIGN KEY REFERENCES customers(customersID)
)

create table customers_has_games (
	customers_id int FOREIGN KEY REFERENCES customers(customersID),
	games_id int FOREIGN KEY REFERENCES games(gamesID)
)

create table providers (
	providersID int NOT NULL PRIMARY KEY,
	name varchar(45),
	creationDate date,
	nbGames int,
	types_providers_id int FOREIGN KEY REFERENCES types_providers(types_providersID)
)

create table providers_has_games (
	providers_id int FOREIGN KEY REFERENCES providers(providersID),
	games_id int FOREIGN KEY REFERENCES games(gamesID)
)
