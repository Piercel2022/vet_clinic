/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * from animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name from animals WHERE date_of_birth BETWEEN '2016-04-12' AND '2019-02-12';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name from animals WHERE neutered=true AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg.
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * from animals WHERE neutered=true;

-- Find all animals not named Gabumon.
SELECT * from animals WHERE NOT name='Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg).
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals 
SET species = 'digimon'
WHERE name LIKE '%mon'; 
UPDATE animals 
SET species = 'pokemon'
WHERE species is NULL; 
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;


BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_by_date;
UPDATE animals
SET weight_kg = -1 * weight_kg;
ROLLBACK TO delete_by_date;
UPDATE animals
SET weight_kg = -1 * weight_kg
WHERE weight_kg < 0;
SELECT * from animals;
COMMIT;

-- Update and Querry for the animal Table

-- How many animals are there?
SELECT COUNT(name) from animals;

-- How many animals have never tried to escape?
SELECT COUNT(name) from animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) from animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT name, escape_attempts from animals
WHERE escape_attempts = (select MAX(escape_attempts) from animals);

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg), MIN(weight_kg) from animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals 
WHERE date_of_birth >= '1990-01-01' AND date_of_birth < '2000-01-01'
GROUP BY species;

-- What animals belong to Melody Pond?
SELECT name,
full_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name as animals,
species.name as species
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT name AS Animals,
full_name AS Owners
FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT COUNT(animals.name) AS Animals_count,
species.name AS Specie
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT owners.full_name,
animals.name AS name_of_animals,
species.name AS name_of_species
FROM animals
JOIN owners ON owners.id = animals.owner_id
JOIN species ON species.id = animals.species_id
WHERE owners.full_name = 'Jennifer Orwell'
AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT name,
escape_attempts,
full_name
FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester'
AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name,
COUNT(animals.owner_id) AS Owns
FROM owners
JOIN animals ON animals.owner_id = owners.id
GROUP BY full_name
ORDER BY Owns DESC;