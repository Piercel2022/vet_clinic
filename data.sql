/* Populate database with sample data. */
/* animals table */
INSERT INTO animals  VALUES (1,'Argumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals  VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8.00);
INSERT INTO animals  VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals  VALUES (4, 'Devimon', '2017-05-12', 5, true, 11.00);
INSERT INTO animals  VALUES (5, 'Charmander', '2020-02-08', 0, false, -11.00);
INSERT INTO animals  VALUES (6, 'Plantmon', '2021-11-15', 2, true, -5.7);
INSERT INTO animals  VALUES (7, 'Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO animals  VALUES (8, 'Angemon', '2005-06-12', 1, true, -45.00);
INSERT INTO animals  VALUES (9, 'Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals  VALUES (10, 'Blossom', '1998-10-13', 3, true, 17.00);
INSERT INTO animals  VALUES (11, 'Ditto', '2022-05-14', 4, true, 22.00);

--insert data to owners table
INSERT INTO owners (full_name, age)
VALUES('Sam Smith', 34);
INSERT INTO owners (full_name, age)
VALUES('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age)
VALUES('Bob', 45);
INSERT INTO owners (full_name, age)
VALUES('Melody Pond', 77);
INSERT INTO owners (full_name, age)
VALUES('Dean Winchester', 14);
INSERT INTO owners (full_name, age)
VALUES('Jodie Whittaker', 38);

--insert data to species table
INSERT INTO species (name)
VALUES('Pokemon');
INSERT INTO species (name)
VALUES('Digimon');

-- Modify your inserted animals so it includes the species_id value:
--  If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
BEGIN;
UPDATE animals
SET species_id = 'pokemon';
UPDATE animals
SET species_id = 'digimon' WHERE name LIKE '%mon';
COMMIT;

BEGIN;
UPDATE animals
SET species_id = (
SELECT id
FROM species
WHERE name = 'Digimon'
)
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = (
SELECT id
FROM species
WHERE name = 'Pokemon'
)
WHERE name NOT LIKE '%mon';

COMMIT;
-- Sam Smith owns Agumon.
UPDATE animals
SET owner_id = (
SELECT id
FROM owners
WHERE full_name = 'Sam Smith'
)
WHERE name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.
BEGIN;
UPDATE animals
SET owner_id = (
SELECT id
FROM owners
WHERE full_name = 'Jennifer Orwell'
)
WHERE name = 'Gabumon' OR name = 'Pikachu';
COMMIT

-- Bob owns Devimon and Plantmon.
BEGIN;
UPDATE animals
SET owner_id = (
SELECT id
FROM owners
WHERE full_name = 'Bob'
)
WHERE name = 'Devimon' OR name = 'Plantmon';
SELECT * FROM animals;
COMMIT

-- Melody Pond owns Charmander, Squirtle, and Blossom.
BEGIN;
UPDATE animals
SET owner_id = (
SELECT id
FROM owners
WHERE full_name = 'Melody Pond'
)
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
SELECT * FROM animals;
COMMIT

-- Dean Winchester owns Angemon and Boarmon.
BEGIN;
UPDATE animals
SET owner_id = (
SELECT id
FROM owners
WHERE full_name = 'Dean Winchester'
)
WHERE name = 'Angemon' OR name = 'Boarmon';
SELECT * FROM animals;
COMMIT;

INSERT INTO vets(name,age,date_of_graduation) VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id)
VALUES (1, 1),
  (3, 1),
  (3, 2),
  (4, 2);
  
INSERT INTO visits
  (animal_id, vet_id, date_of_visit)
VALUES
	( (SELECT id from animals where name = 'Agumon'), (SELECT id from vets where name = 'William Tatcher'), '2020-05-24' ),
	( (SELECT id from animals where name = 'Agumon'), (SELECT id from vets where name = 'Stephanie Mendez'), '2020-07-22' ),
	( (SELECT id from animals where name = 'Gabumon'), (SELECT id from vets where name = 'Jack Harkness'), '2021-02-02' ),
	( (SELECT id from animals where name = 'Pikachu'), (SELECT id from vets where name = 'Maisy Smith'), '2020-01-05' ),
	( (SELECT id from animals where name = 'Pikachu'), (SELECT id from vets where name = 'Maisy Smith'), '2020-04-08' ),
	( (SELECT id from animals where name = 'Pikachu'), (SELECT id from vets where name = 'Maisy Smith'), '2020-05-14' ),
	( (SELECT id from animals where name = 'Devimon'), (SELECT id from vets where name = 'Stephanie Mendez'), '2021-05-04' ),
	( (SELECT id from animals where name = 'Charmander'), (SELECT id from vets where name = 'Jack Harkness'), '2021-02-24' ),
	( (SELECT id from animals where name = 'Plantmon'), (SELECT id from vets where name = 'Maisy Smith'), '2019-12-21' ),
	( (SELECT id from animals where name = 'Plantmon'), (SELECT id from vets where name = 'William Tatcher'), '2020-08-10' ),
	( (SELECT id from animals where name = 'Plantmon'), (SELECT id from vets where name = 'Maisy Smith'), '2021-Apr-07' ),
	( (SELECT id from animals where name = 'Squirtle'), (SELECT id from vets where name = 'Stephanie Mendez'), '2019-09-29' ),
	( (SELECT id from animals where name = 'Angemon'), (SELECT id from vets where name = 'Jack Harkness'), '2020-10-03' ),
	( (SELECT id from animals where name = 'Angemon'), (SELECT id from vets where name = 'Jack Harkness'), '2020-11-04' ),
	( (SELECT id from animals where name = 'Boarmon'), (SELECT id from vets where name = 'Maisy Smith'), '2019-01-24' ),
	( (SELECT id from animals where name = 'Boarmon'), (SELECT id from vets where name = 'Maisy Smith'), '2019-05-15' ),
	( (SELECT id from animals where name = 'Boarmon'), (SELECT id from vets where name = 'Maisy Smith'), '2020-02-27' ),
	( (SELECT id from animals where name = 'Boarmon'), (SELECT id from vets where name = 'Maisy Smith'), '2020-08-03' ),
	( (SELECT id from animals where name = 'Blossom'), (SELECT id from vets where name = 'Stephanie Mendez'), '2020-05-24' ),
	( (SELECT id from animals where name = 'Blossom'), (SELECT id from vets where name = 'William Tatcher'), '2021-01-11' );

  COMMIT;