-- from the terminal run:
-- psql < outer_space_refactored.sql

DROP DATABASE IF EXISTS outer_space_refactored;

CREATE DATABASE outer_space_refactored;

\c outer_space_refactored

CREATE TABLE galaxies
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TYPE celestial_type  AS ENUM ('star', 'planet', 'moon');

CREATE TABLE celestial_bodies
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  type celestial_type 
);

CREATE TABLE orbits
(
  id SERIAL PRIMARY KEY,
  bodies_id integer REFERENCES celestial_bodies(id) ON DELETE CASCADE,
  orbits_around integer REFERENCES celestial_bodies(id) ON DELETE CASCADE,
  orbital_period_in_years FLOAT NOT NULL
);

INSERT INTO galaxies
  (name)
VALUES
  ('Milky Way'),
  ('Andromeda');  

INSERT INTO celestial_bodies
  (name, type)
VALUES
  ('Earth', 'planet'),
  ('The Sun', 'star'),
  ('Proxima Centauri b', 'planet'),
  ('Proxima Centauri', 'star');

INSERT INTO orbits
  (bodies_id, orbits_around, orbital_period_in_years)
VALUES
  (1, 2, 1),
  (3, 4, 0.03);
