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