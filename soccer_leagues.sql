-- from the terminal run:
-- psql < soccer_leagues.sql

DROP DATABASE IF EXISTS soccer_leagues;

CREATE DATABASE soccer_leagues;

\c soccer_leagues

CREATE TABLE coaches (
  id SERIAL PRIMARY KEY,
  c_first TEXT NOT NULL,
  c_last TEXT NOT NULL,
  c_phone VARCHAR(10) NOT NULL,
  c_email VARCHAR(50)
);

CREATE TABLE teams (
  id SERIAL PRIMARY KEY,
  team_name TEXT UNIQUE NOT NULL,
  team_mascot TEXT UNIQUE NOT NULL,
  home_field TEXT NOT NULL,
  head_coach integer REFERENCES coaches(id) ON DELETE CASCADE,
  wins integer NOT NULL,                       
  losses integer NOT NULL,
  team_website VARCHAR(30) NOT NULL,
  team_phone VARCHAR(10) NOT NULL,
  team_email VARCHAR(50)
);

CREATE TABLE players (
  id SERIAL PRIMARY KEY,
  p_first TEXT NOT NULL,
  p_last TEXT NOT NULL,
  team_id integer REFERENCES teams(id) ON DELETE CASCADE,
  p_phone VARCHAR(10) NOT NULL,
  p_email VARCHAR(50)
);

CREATE TABLE officials (
  id SERIAL PRIMARY KEY,
  ref_first TEXT NOT NULL,
  ref_last TEXT NOT NULL,
  ref_phone VARCHAR(10) NOT NULL,
  ref_email VARCHAR(50)
);

CREATE TABLE seasons (
  id SERIAL PRIMARY KEY,
  season_name TEXT UNIQUE NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL
);

CREATE TABLE matches (
  id SERIAL PRIMARY KEY,
  home_team integer REFERENCES teams(id) ON DELETE CASCADE,
  visiting_team integer REFERENCES teams(id) ON DELETE CASCADE,
  match_date DATE NOT NULL,
  match_time TIME NOT NULL,
  season_id integer REFERENCES seasons(id) ON DELETE CASCADE,
  win_team integer REFERENCES teams(id) ON DELETE CASCADE,
  lose_team integer REFERENCES teams(id) ON DELETE CASCADE,
  referee_id integer REFERENCES officials(id) ON DELETE CASCADE,
  asst_ref_1 integer REFERENCES officials(id) ON DELETE CASCADE,
  asst_ref_2 integer REFERENCES officials(id) ON DELETE CASCADE
);

CREATE TABLE goals (
  id SERIAL PRIMARY KEY,
  player_id integer REFERENCES players(id) ON DELETE CASCADE,
  match_id integer REFERENCES matches(id) ON DELETE CASCADE
);

INSERT INTO coaches
(c_first, c_last, c_phone, c_email)
  VALUES
  ('Joe', 'Smith', '2065550043', 'joe@example.com'),
  ('Bill', 'Williams', '2065551121', 'bill@example.com'),
  ('Brad', 'Davis', '2065550043', 'joe@example.com'),
  ('Charlie', 'Wilks', '2065551121', 'bill@example.com'),
  ('Sharon', 'Lewis', '2065550043', 'joe@example.com'),
  ('Natalie', 'Brown', '2065551121', 'bill@example.com');


INSERT INTO teams
(home_field, team_name, team_mascot, head_coach, wins, losses, team_website, team_phone, team_email)
  VALUES
  ('A Stadium', 'Birds', 'Bird Brain', 1, 5, 5, 'http://bird-team.com', '2065551234', 'bird-team@example.com'),
  ('B Stadium', 'Dogs', 'Dog Breath', 2, 7, 3, 'http://dog-team.com', '2065556129', 'dog-team@example.com'),
  ('C Stadium', 'Chickens', 'Chicken Liddel', 3, 1, 9, 'http://chicken-team.com', '2065551121', 'chicken-team@example.com'),
  ('D Stadium', 'Dragons', 'Dragon Sphere', 4, 10, 0, 'http://dragon-team.com', '2065555129', 'dragon-team@example.com'),
  ('E Stadium', 'Elephants', 'Trunky', 5, 6, 4, 'http://elephant-team.com', '2065556129', 'elephant-team@example.com');
  

INSERT INTO players
(p_first, p_last, team_id, p_phone, p_email)
  VALUES
  ('Eric', 'Smith', 1, '2065550043', 'joe@example.com'),
  ('Matt', 'Williams', 2, '2065551121', 'bill@example.com'),
  ('Craig', 'Smith', 1, '2065550043', 'joe@example.com'),
  ('Bill', 'Will', 2, '2065551121', 'bill@example.com'),
  ('Alonzo', 'Sun', 1, '2065550043', 'joe@example.com'),
  ('Burt', 'Viams', 2, '2065551121', 'bill@example.com'),
  ('Ryan', 'Smed', 1, '2065550043', 'joe@example.com'),
  ('Colt', 'Steeler', 2, '2065551121', 'bill@example.com');

INSERT INTO officials
(ref_first, ref_last, ref_phone, ref_email)
  VALUES
  ('Joe', 'Vern', '2065550043', 'joe@example.com'),
  ('Alex', 'Williams', '2065551121', 'bill@example.com'),
  ('Mary', 'Smith', '2065550043', 'joe@example.com'),
  ('Kathy', 'Wallace', '2065551121', 'bill@example.com'),
  ('Cecil', 'Turner', '2065550043', 'joe@example.com'),
  ('Art', 'Bams', '2065551121', 'bill@example.com'),
  ('John', 'Gerr', '2065550043', 'joe@example.com'),
  ('Max', 'Headroom', '2065551121', 'bill@example.com');

INSERT INTO seasons
(season_name, start_date, end_date)
  VALUES
  ('2019 - 2020', '2019-09-01', '2020-02-29');

INSERT INTO matches
(home_team, visiting_team, match_date, match_time, season_id, win_team, lose_team, referee_id, asst_ref_1, asst_ref_2)
  VALUES
  (1, 2, '2019-09-05', '19:30', 1, 1, 2, 1, 2, 3),
  (3, 5, '2019-09-06', '19:30', 1, 3, 5, 1, 2, 3),
  (2, 4, '2019-09-07', '19:30', 1, 4, 2, 1, 2, 3),
  (1, 5, '2019-09-08', '19:30', 1, 5, 1, 1, 2, 3),
  (2, 3, '2019-09-13', '19:30', 1, 2, 3, 1, 2, 3),
  (4, 5, '2019-09-14', '19:30', 1, 5, 4, 1, 2, 3);

INSERT INTO goals
(player_id, match_id)
  VALUES
  (1, 1),
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (3, 4),
  (1, 2),
  (1, 4);
