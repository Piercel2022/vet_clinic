/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id int PRIMARY KEY NOT NULL,
    name varchar(100),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal,
    species varchar(80)
);
/* Table owners */
CREATE TABLE owners (
owners_id INT,
full_name VARCHAR(100),
age INT,
PRIMARY KEY(owners_id)
);
/* Table species */
CREATE TABLE species(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(80),
PRIMARY KEY(id)
);

-- Remove column species
ALTER TABLE animals
DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals 
ADD COLUMN IF NOT EXISTS species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species 
FOREIGN KEY (species_id) 
REFERENCES species(id);

ALTER TABLE animals ADD COLUMN IF NOT EXISTS owner_id INT;

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    age int,
    date_of_graduation date,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    vet_id int,
    species_id int,
    CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id),
    CONSTRAINT fk_vets FOREIGN KEY(vet_id) REFERENCES vets(id)
);

CREATE TABLE visits (
  id SERIAL PRIMARY KEY,
  animals_id INT,
  vets_id INT,
  date DATE,
  CONSTRAINT fk_animals FOREIGN KEY(animals_id) REFERENCES animals(id),
  CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX animals_id_index ON visits(animals_id);
CREATE INDEX vets_id_index ON visits(vets_id, animals_id, date);
CREATE INDEX email_index ON owners(email ASC);

