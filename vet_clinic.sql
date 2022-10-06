CREATE TABLE "animals"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "date_of_birth" DATE NOT NULL,
    "escape_attempts" INTEGER NOT NULL,
    "neutered" BOOLEAN NOT NULL,
    "weight_kg" DECIMAL(8, 2) NOT NULL,
    "species_id" INTEGER NOT NULL,
    "owners_id" INTEGER NOT NULL
);
CREATE INDEX "animals_id_index" ON
    "animals"("id");
ALTER TABLE
    "animals" ADD PRIMARY KEY("id");
CREATE TABLE "species"(
    "species_id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL
);
CREATE INDEX "species_species_id_index" ON
    "species"("species_id");
ALTER TABLE
    "species" ADD PRIMARY KEY("species_id");
CREATE TABLE "owners"(
    "owners_id" INTEGER NOT NULL,
    "full_name" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL,
    "email" VARCHAR(255) NOT NULL
);
CREATE INDEX "owners_owners_id_index" ON
    "owners"("owners_id");
ALTER TABLE
    "owners" ADD PRIMARY KEY("owners_id");
CREATE TABLE "specializations"(
    "vet_id" INTEGER NOT NULL,
    "species_id" INTEGER NOT NULL
);
CREATE TABLE "vets"(
    "vet_id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL,
    "date_of_graduation" DATE NOT NULL
);
CREATE INDEX "vets_vet_id_index" ON
    "vets"("vet_id");
ALTER TABLE
    "vets" ADD PRIMARY KEY("vet_id");
CREATE TABLE "visits"(
    "id" INTEGER NOT NULL,
    "animals_id" INTEGER NOT NULL,
    "vet_id" INTEGER NOT NULL,
    "date" DATE NOT NULL
);
CREATE INDEX "visits_animals_id_vet_id_id_index" ON
    "visits"("animals_id", "vet_id", "id");
ALTER TABLE
    "visits" ADD PRIMARY KEY("id");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_animals_id_foreign" FOREIGN KEY("animals_id") REFERENCES "animals"("id");
ALTER TABLE
    "animals" ADD CONSTRAINT "animals_species_id_foreign" FOREIGN KEY("species_id") REFERENCES "species"("species_id");
ALTER TABLE
    "animals" ADD CONSTRAINT "animals_owners_id_foreign" FOREIGN KEY("owners_id") REFERENCES "owners"("owners_id");
ALTER TABLE
    "specializations" ADD CONSTRAINT "specializations_species_id_foreign" FOREIGN KEY("species_id") REFERENCES "species"("species_id");
ALTER TABLE
    "specializations" ADD CONSTRAINT "specializations_vet_id_foreign" FOREIGN KEY("vet_id") REFERENCES "vets"("vet_id");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_vet_id_foreign" FOREIGN KEY("vet_id") REFERENCES "vets"("vet_id");