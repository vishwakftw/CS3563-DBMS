drop database gp2_db;
create database gp2_db;
\connect gp2_db

create table person ( 
	PersonID char(9) primary key,
	PersonName varchar NOT NULL,
	BirthYear real CHECK (BirthYear >= 0),
	DeathYear real CHECK (DeathYear >= 0)
);

create table picture (
	PictureID char(9) primary key,
	IsMovie bool DEFAULT TRUE,
	PrimaryTitle varchar,
	ReleaseTitle varchar ,
	Adult bool DEFAULT FALSE,
	StartYear real CHECK (StartYear >= 0),
	EndYear  real CHECK (EndYear >= 0),
	Duration real CHECK(Duration >= 0),
	Budget real CHECK(Budget >= 0),
	GrossBoxOffice real CHECK(GrossBoxOffice >= 0),
	ParentPicture char(9) references picture(PictureID),
	SeasonNumber real CHECK(SeasonNumber >= 0),
	EpisodeNumber real CHECK(EpisodeNumber >= 0)
);

create table role (
	PictureID char(9) references picture(PictureID) ON DELETE CASCADE ON UPDATE CASCADE,
	PersonID char(9) references person(PersonID) ON DELETE CASCADE ON UPDATE CASCADE,
	Role varchar(15) DEFAULT 'Miscellaneous'
);

create table awards(
	AwardID varchar(25) NOT NULL,
	AwardName varchar NOT NULL, 
	AwardOrganization varchar NOT NULL, 
	PictureID char(9) references picture(PictureID) ON DELETE CASCADE ON UPDATE CASCADE, 
	PersonID char(9) references person(PersonID) ON DELETE CASCADE ON UPDATE CASCADE, 
	Winner bool DEFAULT FALSE, 
	Year int CHECK(Year >= 0)
);

create table languages ( 
	PictureID char(9) references picture(PictureID) ON DELETE CASCADE ON UPDATE CASCADE, 
	Language varchar(75) DEFAULT 'English'
);

create table production_company ( 
	PictureID char(9) references picture(PictureID) ON DELETE CASCADE ON UPDATE CASCADE,
	CompanyName varchar NOT NULL,
	CompanyID int CHECK(CompanyID >= 0)
);

create table filming_location (
	PictureID char(9) references picture(PictureID) ON DELETE CASCADE ON UPDATE CASCADE,
	CountryName varchar(75) NOT NULL
);

create table release_location (
	PictureID char(9) references picture(PictureID) ON DELETE CASCADE ON UPDATE CASCADE,
	CountryName varchar(75) NOT NULL
);

create table genres (
	PictureID char(9) references picture(PictureID) ON DELETE CASCADE ON UPDATE CASCADE,
	Genre varchar
);

create table rating (
	PictureID char(9) references picture(PictureID) ON DELETE CASCADE ON UPDATE CASCADE,
	averageRating real DEFAULT 0.0,
	numVotes int DEFAULT 0
);


COPY person FROM '/home/harsh/btech/sem-6/dbms-2/project-dataset/new-csv/person.csv' CSV delimiter ',' NULL '\N' ENCODING 'unicode' header;

COPY picture FROM '/home/harsh/btech/sem-6/dbms-2/project-dataset/new-csv/pictures.csv' CSV delimiter ',' NULL '\N' ENCODING 'unicode' header;

COPY awards FROM '/home/harsh/btech/sem-6/dbms-2/project-dataset/new-csv/awards.csv' CSV delimiter ',' NULL '\N' ENCODING 'unicode' header;

COPY languages FROM '/home/harsh/btech/sem-6/dbms-2/project-dataset/new-csv/languages.csv' CSV delimiter ',' NULL '\N' ENCODING 'unicode' header;

COPY production_company FROM '/home/harsh/btech/sem-6/dbms-2/project-dataset/new-csv/production_comp.csv' CSV delimiter ',' NULL '\N' ENCODING 'unicode' header;

COPY filming_location FROM '/home/harsh/btech/sem-6/dbms-2/project-dataset/new-csv/filming_location.csv' CSV delimiter ',' NULL '\N' ENCODING 'unicode' header;

COPY release_location FROM '/home/harsh/btech/sem-6/dbms-2/project-dataset/new-csv/release_location.csv' CSV delimiter ',' NULL '\N' ENCODING 'unicode' header;

COPY genres FROM '/home/harsh/btech/sem-6/dbms-2/project-dataset/new-csv/genre.csv' CSV delimiter ',' NULL '\N' ENCODING 'unicode' header;

COPY rating FROM '/home/harsh/btech/sem-6/dbms-2/project-dataset/new-csv/ratings.csv' CSV delimiter ',' NULL '\N' ENCODING 'unicode' header;

COPY role FROM '/home/harsh/btech/sem-6/dbms-2/project-dataset/new-csv/role.csv' CSV delimiter ',' NULL '\N' ENCODING 'unicode' header;