CREATE TYPE customer AS (
Passport char(15),
Name char(50),
Surname char(50),
Dob date,
Nationality char(50)
);

ALTER TABLE passenger OF customer;

CREATE TYPE trip AS (
Travel_no integer,
Destination char(3),
Origin char(3),
vessel_ID char(4),
Day char(10),
Cost integer,
Duration real
);

ALTER TABLE journey OF trip;

CREATE TABLE loyal_customers (
Points integer,
Travel_history trip[],
Application tsvector
) INHERITS (passenger);

