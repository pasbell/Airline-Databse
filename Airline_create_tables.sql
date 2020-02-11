CREATE TABLE country(
cname char(50) PRIMARY KEY,
region char(20)
);


CREATE TABLE passenger(
Passport char(15) PRIMARY KEY,
Name char(50),
Surname char(50),
Dob date,
Nationality char(50),
CHECK (dob < CURRENT_DATE - 1095),
CHECK (passport LIKE '______%')
);

CREATE TABLE infant(
Ppassport char(15),
Passport char(15),
Nationality char(50),
Name char(50),
Surname char(50),
Dob date,
PRIMARY KEY (ppassport, passport),
CHECK (dob >= CURRENT_DATE -1095),
CHECK (passport LIKE '______%') 
);

CREATE TABLE luggage(
Luggage_id integer,
Passport char(15),
weight numeric,
Checked boolean,
PRIMARY KEY (luggage_id, passport)
);

CREATE TABLE station_location(
station_ID char(3) PRIMARY KEY,
cname char(50) REFERENCES country(cname) ON DELETE CASCADE
);

CREATE TABLE company (
compname char(20) PRIMARY KEY,
services char(20)
);


CREATE TABLE vessel(
vessel_ID char(4) PRIMARY KEY, 
type char(10) NOT NULL,
capacity integer NOT NULL check (capacity>10),
compname char(20) references company (compname) ON DELETE CASCADE
);

CREATE TABLE journey(
travel_no integer UNIQUE, 
destination char(3) REFERENCES station_location (station_ID), 
origin char(3) REFERENCES station_location (station_ID),
vessel_ID char(4) REFERENCES vessel (vessel_ID),
day char(10),
cost integer CHECK (cost>0),
duration real CHECK (duration>0),
PRIMARY KEY (destination, origin, vessel_ID),
CHECK (destination <> origin)
);

CREATE TABLE travels(
Travel_no integer REFERENCES journey(travel_no),
Passport char(15) REFERENCES passenger(passport),
Class char(20),
PRIMARY KEY (travel_no, passport)
);


CREATE TABLE meals(
Mealid integer,
travel_no integer, 
passport char(15),
class char(10),
restrictions char(2),
Kidsmeal boolean,
PRIMARY KEY(mealid, travel_no, passport),
FOREIGN KEY(travel_no, passport) REFERENCES travels (travel_no, passport) ON DELETE CASCADE
);


CREATE TABLE employees(
Eid char(5) PRIMARY KEY,
Name char(50),
Surname char(50),
Dob date,
Job char(50),
Department char(50),
compname char(20) NOT NULL,
FOREIGN KEY(compname) REFERENCES company (compname)
);


CREATE TABLE journey_crew(
Eid char(5) REFERENCES employees (eid),
travel_no integer REFERENCES journey(travel_no), 
Primary Key (eid, travel_no)
);

CREATE TABLE travel_agent(
agent_ID integer PRIMARY KEY,
Name char(50),
Surname char(50),
Agency char(50),
Phone bigint,
Email char(50),
CHECK (email LIKE '%@%')
);

CREATE TABLE booking(
agent_id integer REFERENCES travel_agent (agent_id),
travel_no integer, 
passport char(15),
PRIMARY KEY (agent_id, travel_no, passport),
FOREIGN KEY(travel_no, passport) REFERENCES travels (travel_no, passport) ON DELETE CASCADE
);




