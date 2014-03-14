-- During

CREATE TABLE events (                                   
event_id SERIAL PRIMARY KEY,
title text,
starts timestamp,
ends timestamp,
venue_id integer,
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id) MATCH FULL
);

INSERT INTO events (title, starts, ends, venue_id)                                   
VALUES ('LARP Club', '2012-02-15 17:30:00', '2012-02-15 19:30:00', 2);

INSERT INTO events (title, starts, ends, venue_id)
VALUES ('April Fools Day', '2012-04-11 00:00:00', '2012-04-01 23:59:00' 2);

INSERT INTO events (title, starts, ends)
VALUES ('Christmas Day', '2012-12-25 00:00:00', '2012-12-25 23:59:00') RETURNING event_id;

-- Do:

-- 1. Select all the tables we created (and only those) from pg_class.
-- first, run
SELECT * FROM pg_class WHERE relname = 'venues';
-- get relnamespace (the 2nd column)
-- we can do select relnamespace from pg_class where relname = 'venues';
-- then run
SELECT * FROM pg_class WHERE relnamespace = <the number you got in previous query>
-- \dt is also possible to list all tables

-- 2. Write a query that finds the country name of the LARP Club event.
SELECT * 
FROM countries c 
JOIN venues v ON v.country_code=c.country_code
JOIN events e ON e.venue_id = v.venue_id
WHERE e.title='LARP Club';

-- less columns
SELECT c.country_name 
FROM countries c 
JOIN venues v ON v.country_code=c.country_code
JOIN events e ON e.venue_id = v.venue_id
WHERE e.title='LARP Club';

-- 3. Alter the venues table to contain a boolean column called active, with the default value of TRUE.

ALTER TABLE venues ADD COLUMN active boolean DEFAULT true;

-- verify (and then delete it)
INSERT INTO venues (name, postal_code, country_code) VALUES ('test1', '97205', 'us');
INSERT INTO venues (name, postal_code, country_code, active) VALUES ('test2', '97205', 'us', false);

SELECT * FROM venues;

DELETE FROM venues WHERE name = 'test1';
DELETE FROM venues WHERE name = 'test2';


