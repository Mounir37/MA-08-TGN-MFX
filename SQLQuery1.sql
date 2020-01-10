use master
go

IF db_id('SiteJeuxBD_TGN_MFX') IS NOT NULL
BEGIN
	drop database SiteJeuxBD_TGN_MFX
END

CREATE DATABASE SiteJeuxBD_TGN_MFX
	ON PRIMARY
	( NAME = 'SiteJeuxBD_TGN_MFX', FILENAME = 'C:\TGN_MFX\SiteJeuxBD_TGN_MFX.mdf', SIZE = 20480KB , MAXSIZE = 51200KB, FILEGROWTH = 1024KB )
	LOG ON
	( NAME = 'SIteJeuxBD_TGN_MFX_log', FILENAME = 'C:\TGN_MFX\SiteJeuxBD_TGN_MFX.ldf', SIZE = 10240KB , MAXSIZE = 20480KB , FILEGROWTH = 1024KB)
go

use SiteJeuxBD_TGN_MFX
go

create table accessories (
	accessoriesID int NOT NULL PRIMARY KEY,
	type varchar(50),
	price float,
	name varchar(50)
)

create table customers (
	customersID int NOT NULL PRIMARY KEY,
	lastname varchar(45),
	firstname varchar(45),
	nickname varchar(30),
	mail varchar(80),
	phoneNumber int
)

create table developments (
	developmentsID int NOT NULL PRIMARY KEY,
	cost int,
	duration datetime
)

create table developers (
	developersID int NOT NULL PRIMARY KEY,
	name varchar(45),
	creation date,
	totalGames int
)

create table types_providers (
	types_providersID int NOT NULL PRIMARY KEY,
	name varchar(45)
)

create table platforms (
	platformsID int NOT NULL PRIMARY KEY,
	name varchar(45),
	type varchar(45)
)

create table reductions (
	reductionsID int NOT NULL PRIMARY KEY,
	name varchar(45),
	pourcentage float,
	deadline date,
	customers_id int FOREIGN KEY REFERENCES customers(customersID)
)

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
	price float,
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
