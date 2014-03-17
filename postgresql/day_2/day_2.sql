INSERT INTO countries (country_code , country_name) 
VALUES ('il','Israel');

INSERT INTO cities (name, postal_code, country_code) 
VALUES ('Kiryat Tivon',36000,'il');

insert into venues (name, street_address, type, postal_code, country_code) 
values ('My Place', 'Hatzivoni 5', 'private', 36000, 'il');

INSERT INTO events (title, starts, ends, venue_id)                                                                                    
VALUES ('Wedding', '2012-02-26 21:00', '2012-02-26 23:00', (
 SELECT venue_id
  FROM venues
  WHERE name = 'Voodoo Donuts'
 )
);

INSERT INTO events (title, starts, ends, venue_id)                                                                                    
VALUES ('Dinner with Mom', '2012-02-26 18:00', '2012-02-26 20:30', (
 SELECT venue_id
  FROM venues
  WHERE name = 'My Place'
 )
);

INSERT INTO events (title, starts, ends)                                                                                              
VALUES ('Valentine''s Day', '2012-02-14 00:00', '2012-02-14 23:59'
);

