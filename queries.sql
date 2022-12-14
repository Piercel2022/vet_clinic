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

--Who was the last animal seen by William Tatcher?
SELECT v.date as visit_date, a.name, vt.name from visits v 
JOIN animals a 
ON v.animals_id=a.id 
JOIN vets vt 
ON v.vets_id=vt.id 
WHERE vt.name='William Tatcher' 
ORDER BY visit_date 
DESC LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT COUNT(a.name) from visits v 
JOIN animals a 
ON v.animals_id=a.id 
JOIN vets vt 
ON v.vets_id=vt.id 
WHERE vt.name='Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.
SELECT species.name 
AS species_type, vt.name 
AS vet_name from specializations s 
JOIN species 
ON s.species_id=species.id FULL 
JOIN vets vt 
ON s.vet_id=vt.id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT v.date as visit_date, a.name 
AS animal_name, vt.name as vet_name from visits v 
JOIN animals a 
ON v.animals_id=a.id 
JOIN vets vt
ON v.vets_id=vt.id 
WHERE vt.name='Stephanie Mendez' 
AND v.date 
BETWEEN '2020-04-01' AND '2020-08-30';

--What animal has the most visits to vets?
SELECT a.name, COUNT(a.name) 
AS count_visits FROM visits v 
JOIN animals a ON v.animals_id=a.id 
JOIN vets vt ON v.vets_id=vt.id 
GROUP BY a.name 
HAVING COUNT(a.name) = (
    SELECT MAX(myf.count_visits) 
    FROM ( select a.name, COUNT(a.name) 
    AS count_visits from visits v 
    JOIN animals a ON v.animals_id=a.id 
    JOIN vets vt ON v.vets_id=vt.id 
    GROUP BY a.name) 
    AS myf
);

--Who was Maisy Smith's first visit?
SELECT v.date as visit_day, a.name 
AS animal_name, vt.name AS vet_name 
FROM visits v JOIN animals a 
ON v.animals_id=a.id 
JOIN vets vt 
ON v.vets_id=vt.id 
WHERE vt.name='Maisy Smith' 
ORDER BY v.date 
LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT v.date as visit_day, a.name 
AS animal_name, vt.name 
AS vet_name 
FROM visits v 
JOIN animals a 
ON v.animals_id=a.id 
JOIN vets vt
ON v.vets_id=vt.id 
ORDER BY v.date 
DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, s.species_id 
FROM vets 
LEFT JOIN specializations s 
ON s.vet_id=vets.id 
WHERE species_id IS NULL;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(species.name) 
AS count_species 
FROM vets 
LEFT JOIN specializations s 
ON s.vet_id=vets.id 
JOIN animals 
ON animals.species_id=s.species_id 
JOIN species 
ON species.id=s.species_id 
WHERE vets.name='Maisy Smith' 
GROUP BY species.name 
ORDER BY count_species 
DESC LIMIT 1;

