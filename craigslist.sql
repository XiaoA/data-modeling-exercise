-- from the terminal run:
-- psql < craigslist.sql

DROP DATABASE IF EXISTS craigslist;

CREATE DATABASE craigslist;

\c craigslist

CREATE TABLE regions (
  id SERIAL PRIMARY KEY,
  location_city TEXT NOT NULL,
  location_state VARCHAR(2) NOT NULL,
  location_zip VARCHAR(5) NOT NULL
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(30) UNIQUE NOT NULL,
  region_id INTEGER REFERENCES regions(id) ON DELETE CASCADE
);

CREATE TABLE pictures (
  id SERIAL PRIMARY KEY,
  picture_url TEXT,
  user_id INTEGER references users(id) on delete cascade
);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  category_name TEXT NOT NULL
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  picture_id INTEGER REFERENCES pictures(id) ON DELETE CASCADE,
  category_id INTEGER REFERENCES categories(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);


INSERT INTO regions
(location_city, location_state, location_zip)
  VALUES
  ('Seattle', 'WA', '98103'),
  ('Shoreline', 'WA', '98133');

INSERT INTO users
(id, email, region_id)
  VALUES
  (1, 'sherlock@example.com', 1),
  (2, 'batman@example.com', 2);
  
INSERT INTO pictures
(picture_url, user_id)
  VALUES
  ('https://www.fillmurray.com/200/300', 1),
  ('https://www.fillmurray.com/g/200/300', 2);

INSERT INTO categories
(category_name)
  VALUES
  ('jobs'),
  ('for sale');
  
INSERT INTO posts
(title, body, author_id, picture_id, category_id)
  VALUES
  ('My first post',
  'Donec at pede. Phasellus lacus. Mauris ac felis vel velit tristique imperdiet. Nullam eu ante vel est convallis dignissim. Nunc porta vulputate tellus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 1, 1, 1),
  ('My second post', 'Phasellus lacus. Donec neque quam, dignissim in, mollis nec, sagittis eu, wisi. Aliquam feugiat tellus ut neque.', 2, 2, 2); 




