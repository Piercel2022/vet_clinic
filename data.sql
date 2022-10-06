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
INSERT INTO owners VALUES(1,'Sam Smith', 34);
INSERT INTO owners VALUES(2,'Jennifer Orwell', 19);
INSERT INTO owners VALUES(3, 'Bob', 45);
INSERT INTO owners VALUES(4, 'Melody Pond', 77);
INSERT INTO owners VALUES(5, 'Dean Winchester', 14);
INSERT INTO owners VALUES(6, 'Jodie Whittaker', 38);

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

INSERT INTO visits (animals_id,vets_id,date) VALUES (1, 1, '2020-05-24'),(1, 3, '2020-07-22'),(2, 4, '2021-02-02'),(3, 2, '2020-01-05');
INSERT INTO visits (animals_id,vets_id,date) VALUES (3, 2, '2020-03-08'),(3, 2, '2020-05-14'),(4, 2, '2021-05-04'),(5, 4, '2021-02-24');
INSERT INTO visits (animals_id,vets_id,date) VALUES (6, 2, '2019-12-21'),(6, 1, '2020-08-10'),(6, 2, '2021-04-07'),(7, 3, '2019-09-29');
INSERT INTO visits (animals_id,vets_id,date) VALUES (8, 4, '2020-10-03'),(8, 4, '2020-11-04'),(9, 2, '2019-01-24'),(9, 2, '2019-05-15');
INSERT INTO visits (animals_id,vets_id,date) VALUES (9, 2, '2020-02-27'),(9, 2, '2020-08-03'),(10, 3, '2020-05-24'),(10, 1, '2021-01-11');


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';