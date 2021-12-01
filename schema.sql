/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic

\c vet_clinic

CREATE TABLE animals (
  id      INT GENERATED ALWAYS AS IDENTITY,
  name    CHAR(50),
  date_of_birth    DATE,
  escape_attempts    SMALLINT,
  neutered     BOOLEAN,
  weight_kg    DECIMAL,
  PRIMARY KEY(id)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(50);

CREATE TABLE owners (
  id      INT GENERATED ALWAYS AS IDENTITY,
  full_name    CHAR(50),
  age    SMALLINT,
  PRIMARY KEY(id)
);

CREATE TABLE species (
  id      INT GENERATED ALWAYS AS IDENTITY,
  name    CHAR(50),
  PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;

ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE animals ADD COLUMN owner_id INT;