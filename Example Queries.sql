/*The average cost of a bus ticket offered on this site*/
	
	SELECT avg(cost), type
FROM journey j, vessel v
WHERE j.vessel_ID =v.vessel_ID
GROUP BY type
HAVING type='Bus'

/*Which company/companies is/are the most popular among the travelers this week*/

		WITH compclientcount AS( 
SELECT compname, COUNT(*) AS passcount
        			FROM vessel v, travels t
        			WHERE v.vessel_id = t.vessel_id
        			GROUP BY compname
)

SELECT compname
FROM compclientcount
WHERE passcount = (	SELECT MAX(passcount)
FROM compclientcount)


/*Most popular destination(s) for infants this week*/

		WITH infdest AS(
SELECT COUNT(*) AS countd, destination, cname
FROM infant i, travels t, station_location s
WHERE i.passport = t.passport AND t.destination = s.station_id
GROUP BY destination, cname
)
SELECT cname
FROM infdest
WHERE countd = (	SELECT max(countd)
                				FROM infdest)



/*Loyalty Program Queries*/
/*Who is the most loyal customer in the Loyalty Program? This query gives the name of the customer with longest array meaning the customer with the longest stored travel history.*/
With travelcount AS(
SELECT passport, name, surname, array_length(l.travel_history, 1) as count
FROM loyal_customers l
)
SELECT name, surname
FROM travelcount
Where  (select max(count) from travelcount) = count;


/*Who joined the program in the first year since its launch? This query searches for the date in each customer’s email to join the loyalty program and will look for those who joined in 2016?*/
SELECT name, surname
FROM loyal_customers
Where application @@ '2016'::tsquery;


/*What is the most common nationality of customers in the loyalty program?*/
With nationalityc as(
SELECT Nationality, count(nationality) as count
From loyal_customers
Group by Nationality
)
Select nationality
From nationalityc
Where (select max(count) from nationalityc) = count;
