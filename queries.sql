/*Queries that provide answers to the questions from all projects.*/


SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;



BEGIN;
UPDATE animals SET spec
Vet clinic database: create animals table- make changes
Project changes
Solo
0.5
COMPLETED
ies = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species is NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-1-1'::date;
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(name) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY animals.neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY animals.species;

SELECT species, AVG(escape_attempts) FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000 GROUP BY species;

-- Vet clinic database: query multiple tables

SELECT name, full_name FROM animals INNER JOIN owners 
    ON owners.id = owner_id
    AND full_name = 'Melody Pond';


SELECT animals.name FROM animals INNER JOIN species 
    ON species.id = species_id
    AND species.name = 'Pokemon';


SELECT full_name, animals.name FROM animals RIGHT JOIN owners 
    ON owners.id = owner_id;


SELECT species.name, COUNT(*) FROM animals FULL OUTER JOIN species 
    ON species.id = animals.species_id 
    GROUP BY species.id;

SELECT animals.name FROM animals
    INNER JOIN owners ON owners.id = animals.owner_id
    INNER JOIN species ON species.id = animals.species_id
    WHERE owners.full_name = 'Jennifer Orwell'
    AND species.name = 'Digimon';

SELECT animals.name FROM animals
    INNER JOIN owners ON owners.id = animals.owner_id
    WHERE owners.full_name = 'Dean Winchester'
    AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.owner_id) FROM animals 
    FULL OUTER JOIN owners 
    ON animals.owner_id = owners.id
    GROUP BY owners.id;


-- Vet clinic database: add "join table" for visits

SELECT animals.name, visits.date_of_visit FROM animals 
    INNER JOIN visits ON visits.animal_id = animals.id 
    INNER JOIN vets ON vets.id = visits.vet_id 
    WHERE vets.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;

SELECT COUNT(DISTINCT animals.name) FROM animals 
    INNER JOIN visits ON visits.animal_id = animals.id 
    INNER JOIN vets ON vets.id = visits.vet_id 
    WHERE vets.name = 'Stephanie Mendez';

SELECT name, specie_id FROM vets 
    FULL OUTER JOIN specializations ON  specializations.vet_id = vets.id;

SELECT animals.name, visits.date_of_visit FROM animals 
    INNER JOIN visits ON visits.animal_id = animals.id 
    INNER JOIN vets ON vets.id = visits.vet_id 
    WHERE vets.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-4-1'::date AND '2020-8-30'::date;

SELECT name, COUNT(*) FROM animals
    INNER JOIN visits ON visits.animal_id = animals.id
    GROUP BY animals.name
    ORDER BY COUNT(*) DESC LIMIT 1;

SELECT animals.name as animal_name, vets.name as vet_name, visits.date_of_visit FROM animals 
    INNER JOIN visits ON visits.animal_id = animals.id 
    INNER JOIN vets ON vets.id = visits.vet_id ORDER BY date_of_visit DESC LIMIT 1;

SELECT COUNT(visits.animal_id) FROM visits
    INNER JOIN vets ON vets.id = visits.vet_id
    INNER JOIN animals ON animals.id = visits.animal_id
    INNER JOIN specializations ON specializations.vet_id = vets.id
    WHERE specializations.specie_id != animals.species_id;


SELECT species.name, COUNT(visits.animal_id) FROM visits
    INNER JOIN vets ON vets.id = visits.vet_id
    INNER JOIN animals ON animals.id = visits.animal_id
    INNER JOIN species ON species.id = animals.species_id
    WHERE vets.name = 'Maisy Smith'
    GROUP BY species.name
    ORDER BY count DESC LIMIT 1;