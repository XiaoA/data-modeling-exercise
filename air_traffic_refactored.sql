-- from the terminal run:
-- psql < air_traffic_refactored.sql

DROP DATABASE IF EXISTS air_traffic_refactored;

CREATE DATABASE air_traffic_refactored;

\c air_traffic_refactored

CREATE TABLE passengers
 (
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  seat TEXT NOT NULL  
);

CREATE TABLE airlines
(
  id SERIAL PRIMARY KEY,
  company TEXT NOT NULL
);

CREATE TABLE arrivals
(
  id SERIAL PRIMARY KEY,  
  to_city TEXT NOT NULL,
  to_country TEXT NOT NULL,
  arrival_time TIMESTAMP NOT NULL
);

CREATE TABLE departures
(
  id SERIAL PRIMARY KEY,
  from_city TEXT NOT NULL,
  from_country TEXT NOT NULL,
  departure_time TIMESTAMP NOT NULL
);

CREATE TABLE flights
(
  id SERIAL PRIMARY KEY,
  airline integer REFERENCES airlines(id) ON DELETE CASCADE,
  flight_arrival integer REFERENCES arrivals(id) ON DELETE CASCADE,
  flight_departure integer REFERENCES departures(id) ON DELETE CASCADE
);

INSERT INTO passengers
  (first_name, last_name, seat)
VALUES
  ('Jennifer', 'Finch', '43B'),
  ('Thadeus', 'Gathercoal', '111A'),
  ('Sonja', 'Pauley', '23C'),
  ('Jennifer', 'Finch', '67A'),
  ('Waneta', 'Skeleton', '44B'),
  ('Thadeus', 'Gathercoal', '29A'),
  ('Berkie', 'Wycliff', '84C'),
  ('Alvin', 'Leathes', '77D'),
  ('Berkie', 'Wycliff', '88B'),
  ('Cory', 'Squibbes', '99A');

INSERT INTO airlines
  (company)
VALUES
  ('United'),
  ('Delta'),
  ('American Airlines');

INSERT INTO departures
  (from_city, from_country, departure_time)
VALUES
  ('Seattle', 'USA', '2018-04-08 09:00:00'),
  ('Seattle', 'USA', '2018-12-19 12:45:00'),
  ('Seattle', 'USA', '2018-01-02 07:00:00'),
  ('Seattle', 'USA', '2018-04-15 16:50:00'),
  ('Seattle', 'USA', '2018-08-01 18:30:00'),
  ('Seattle', 'USA', '2018-10-31 01:15:00'),
  ('Seattle', 'USA', '2019-02-06 06:00:00'),
  ('Seattle', 'USA', '2018-12-22 14:42:00');

INSERT INTO arrivals
  (to_city, to_country, arrival_time)
VALUES
  ('Seattle', 'USA', '2018-04-08 09:00:00'),
  ('Seattle', 'USA', '2018-12-19 12:45:00'),
  ('Seattle', 'USA', '2018-01-02 07:00:00'),
  ('Seattle', 'USA', '2018-04-15 16:50:00'),
  ('Seattle', 'USA', '2018-08-01 18:30:00'),
  ('Seattle', 'USA', '2018-10-31 01:15:00'),
  ('Seattle', 'USA', '2019-02-06 06:00:00'),
  ('Seattle', 'USA', '2018-12-22 14:42:00');

INSERT INTO flights
  (airline, flight_arrival, flight_departure)
VALUES
  (1, 1, 1),
  (3, 2, 2),  
  (1, 2, 3);
