CREATE DATABASE Netflix; 
use Netflix; 

create table movies (
	idMovies int auto_increment not null primary key, 
    title varchar(45) not null, 
    genre varchar(45) not null, 
    image varchar(1000) not null, 
    category varchar(45) not null, 
    movieYear int
);

create table Users (
	idUsers int auto_increment not null primary key, 
    users varchar(45) not null, 
    passwordUsers varchar(45) not null, 
    nameUsers varchar(45) not null, 
    email varchar(45) not null,
    plan_details varchar(45) not null
);

create table Actors (
	idActors int auto_increment not null primary key, 
    nameActors varchar(45) not null,
    lastName varchar(45) not null,
    country varchar(45) not null,
    birthday date
);