-- SELECT basics

-- 1. Show the population of Germany
SELECT
  population
FROM
  world
WHERE
  name = 'Germany';

-- 2. Show the name and per capita gdp for each country where the area is
-- over 5_000_000 km ** 2
SELECT
  name, gdp / population
FROM
  world
WHERE
  area > 5000000;

-- 3. Find small, rich countries
SELECT
  name, continent
FROM
  world
WHERE
  area < 2000 AND gdp > 5000000000;

-- 4. Show the name and the population for 'Denmark', 'Finland', 'Norway',
-- 'Sweden'
SELECT
  name, population
FROM
  world
WHERE
  name IN ("Denmark", "Finland", "Norway", "Sweden");

-- 5. Show each country that begins with G
SELECT
  name
FROM
  world
WHERE
  name LIKE "G%";

-- 6. Show the area in 1000 square km. Show area / 1000 instead of area.
SELECT
  name, area / 1000
FROM
  world
WHERE
  area BETWEEN 200000 AND 250000;

-- SELECT from world

-- 2. Show the name for the countries that have a population of at least 200
-- million. (200 million is 200000000, there are eight zeros)
SELECT
  name
FROM
  world
WHERE
  population > 199999999;

-- 3. Give the name and the per capita GDP for those coutnries with a
-- population of at least 200 million
SELECT
  name, gdp / population
FROM
  world
WHERE
  population > 199999999;

-- 4. Show the name and population in millions for the countries of 'South
-- America'
SELECT
  name, population / 1000000
FROM
  world
WHERE
  continent = "South America";

-- 5. Show the name and population for 'France', 'Germany', and 'Italy'
SELECT
  name, population
FROM
  world
WHERE
  name IN ("France", "Germany", "Italy");

-- 6. Identify the countries which have names including the word 'United'
SELECT
  name
FROM
  world
WHERE
  name LIKE "%United%";

-- SELECT from Nobel

-- 1. Display Nobel prizes for 1950
SELECT
  yr, subject, winner
FROM
  nobel
WHERE
  yr = 1950;

-- 2. Show who won the 1962 prize for Literature
SELECT
  winner
FROM
  nobel
WHERE
  yr = 1962 AND subject = "Literature";

-- 3. Show the year and subject that won 'Albert Einstein' his prize
SELECT
  yr, subject
FROM
  nobel
WHERE
  winner = "Albert Einstein";

-- 4. Give the name of the 'Peace' winners since the year 2000, including 2000
SELECT
  winner
FROM
  nobel
WHERE
  yr > 1999 AND subject = "Peace";

-- 5. Show all details (yr, subject, winner) of the Literature prize winners
-- for 1980 to 1989 inclusive
SELECT
  *
FROM
  nobel
WHERE
  subject = "Literature" AND yr BETWEEN 1980 AND 1989;

-- 6. Show all details of the presidential winners: ('Theodore Roosevelt',
-- 'Woodrow Wilson', 'Jed Bartlet', 'Jimmy Carter')
SELECT
  *
FROM
  nobel
WHERE
  winner IN ('Theodore Roosevelt',
             'Woodrow Wilson',
             'Jed Bartlet',
             'Jimmy Carter');

-- 7. Show the winners with first name John
SELECT
  winner
FROM
  nobel
WHERE
  winner LIKE "John%";
  
-- 8. In which years was the Physics prize awarded but no Chemistry prize
SELECT
  DISTINCT yr
FROM (
  SELECT 
    yr
  FROM 
    nobel
  WHERE 
    subject = "Physics"
) phys_yrs
WHERE
  yr NOT IN (
    SELECT
      yr
    FROM
      nobel
    WHERE
      subject = "Chemistry"
  ); 

-- SELECT within SELECT

-- 1. List each country name where the population is larger than 'Russia'
SELECT
  name
FROM
  world
WHERE
  population > (
    SELECT
      population
    FROM
      world
    WHERE
      name = "Russia"
  );

-- 2. Show the countries in Europe with a per capita GDP greater than 'United
-- Kingdom'
SELECT
  name
FROM
  world
WHERE
  continent = "Europe"
  AND gdp / population > (
    SELECT
      gdp / population
    FROM
      world
    WHERE
      name = "United Kingdom"
  );

-- 3. List the name and continent of countries in the continents containing
-- 'Belize', 'Belgium'
SELECT
  name, continent
FROM
  world
WHERE
  continent IN (
    SELECT
      continent
    FROM
      world
    WHERE
      name IN ("Belize", "Belgium")
  );

-- 4. Which country has a population that is more than Canada but less than
-- Poland? Show the name and the population
SELECT
  name, population
FROM
  world
WHERE
  population > (
    SELECT
      population
    FROM
      world
    WHERE
      name = "Canada"
  ) AND population < (
    SELECT
      population
    FROM
      world
    WHERE
      name = "Poland"
  );

-- 5. Which countries have GDP greater than every country in Europe?
SELECT
  name
FROM
  world
WHERE
  gdp > ALL (
    SELECT
      gdp
    FROM
      world
    WHERE
      continent = "Europe"
      AND gdp IS NOT NULL
  );

-- 6. Find the largest country (by area) in each continent, show the continent,
-- the name and the area
SELECT
  continent, name, area
FROM
  world x
WHERE
  area >= All (
    SELECT
      area
    FROM
      world y
    WHERE
      y.continent = x.continent
      AND area > 0
  );

-- 7. Find each country that belongs to a continent where all populations are 
-- less than 25000000. Show name, continent and population
SELECT
  name, continent, population
FROM
  world
WHERE
  continent NOT IN (
    SELECT
      continent
    FROM
      world
    WHERE
      population > 25000000
  );

-- SUM and COUNT

-- 1. Show the total population of the world
SELECT
  SUM(population)
FROM
  world;

-- 2. List all the continents - just once each
SELECT
  DISTINCT continent
FROM
  world;

-- 3. Give the total GDP of Africa
SELECT
  SUM(gdp)
FROM
  world
WHERE
  continent = "Africa";

-- 4. How many countries have an area of at least 1000000
SELECT
  COUNT(name)
FROM
  world
WHERE
  area >= 1000000;

-- 5. What is the total population of ('France','Germany','Spain')
SELECT
  SUM(population)
FROM
  world
WHERE
  name IN ('France','Germany','Spain');

-- 6. For each continent show the continent and number of countries
SELECT
  continent, COUNT(name)
FROM
  world
GROUP BY
  continent;

-- 7. For each continent show the continent and number of countries with
-- populations of at least 10 million
SELECT
  continent, COUNT(name)
FROM
  world
WHERE
  population >= 10000000
GROUP BY
  continent;

-- 8. List the continents with total populations of at least 100 million
SELECT
  continent
FROM
  world
GROUP BY
  continent
HAVING
  SUM(population) > 100000000;

-- JOIN operation

-- 4. Show the team1, team2 and player for every goal scored by a player called
-- Mario
SELECT
  team1, team2, player
FROM
  game
JOIN
  goal ON id = matchid
WHERE
  player LIKE "Mario%";

-- 5. Show player, teamid, coach, and gtime for all goals scored in the first
-- 10 minutes
SELECT
  player, teamid, coach, gtime
FROM
  goal
JOIN
  eteam ON teamid = id
WHERE
  gtime <= 10;

-- 6. List the the dates of the matches and the name of the team in which
-- 'Fernando Santos' was the team1 coach
SELECT
  mdate, teamname
FROM
  game
JOIN
  eteam ON game.team1 = eteam.id
WHERE
  coach = "Fernando Santos";

-- 7. List the player for every goal scored in a game where the stadium was
-- 'National Stadium, Warsaw'
SELECT
  player
FROM
  goal
JOIN
  game ON matchid = id
WHERE
  stadium = "National Stadium, Warsaw";

-- 8. Show names of all players who scored a goal against Germany
SELECT
  DISTINCT player
FROM
  goal
JOIN
  game ON matchid = id
WHERE
  (team1 = "GER" OR team2 = "GER")
  AND teamid != "GER";

-- 9. Show teamname and the total number of goals scored
SELECT
  teamname, COUNT(teamid)
FROM
  goal
JOIN
  eteam ON id = teamid
GROUP BY
  teamname;

-- 10. Show the stadium and the number of goals scored in each stadium
SELECT
  stadium, COUNT(matchid)
FROM
  game
JOIN
  goal ON id = matchid
GROUP BY
  stadium;

-- 11. For every match involving 'POL', show the matchid, date and the number
-- of goals scored
SELECT
  matchid, mdate, COUNT(matchid)
FROM
  game
JOIN
  goal ON id = matchid
WHERE
  team1 = "POL" OR team2 = "POL"
GROUP BY
  matchid;

-- 12. For every match where 'GER' scored, show matchid, match date and the
-- number of goals scored by 'GER'
SELECT
  matchid, mdate, COUNT(matchid)
FROM
  game
JOIN
  goal ON id = matchid
WHERE
  teamid = "GER"
GROUP BY
  matchid;

-- More JOIN operations

-- 1. List the films where the yr is 1962 [Show id, title]
SELECT
  id, title
FROM
  movie
WHERE
  yr = 1962;

-- 2. Give the year of 'Citizen Kane'
SELECT
  yr
FROM
  movie
WHERE
  title = "Citizen Kane";

-- 3. List all of the Star Trek movies, include the id, title and yr (all of
-- these movies include the words Star Trek in the title). Order results by
-- year.
SELECT
  id, title, yr
FROM
  movie
WHERE
  title LIKE "%Star Trek%"
ORDER BY
  yr;

-- 4. What are the titles of the films with id 11768, 11955, 21191
SELECT
  title
FROM
  movie
WHERE
  id IN (11768, 11955, 21191);

-- 5. What id number does the actor 'Glenn Close' have?
SELECT
  id
FROM
  actor
WHERE
  name = "Glenn Close";

-- 6. What is the id of the film 'Casablanca'?
SELECT
  id
FROM
  movie
WHERE
  title = "Casablanca";

-- 7. Obtain the cast list for 'Casablanca'. Use the id value that you obtained
-- in the previous question
SELECT
  name
FROM
  actor
JOIN
  casting ON id = actorid
WHERE
  movieid = 11768;

-- 8. Obtain the cast list for the film 'Alien'
SELECT
  name
FROM
  actor
JOIN
  casting ON id = actorid
WHERE
  movieid = (
    SELECT
      id
    FROM
      movie
    WHERE
      title = "Alien"
  );

-- 9. List the films in which 'Harrison Ford' has appeared
SELECT
  title
FROM
  movie
JOIN
  casting ON id = movieid
WHERE
  actorid = (
    SELECT
      id
    FROM
      actor
    WHERE
      name = "Harrison Ford"
  );

-- 10. List the films where 'Harrison Ford' has appeared - but not in the star
-- role. [Note: the ord field of casting gives the position of the actor. If
-- ord=1 then this actor is in the starring role]
SELECT
  title
FROM
  movie
JOIN
  casting ON id = movieid
WHERE
  actorid = (
    SELECT
      id
    FROM
      actor
    WHERE
      name = "Harrison Ford"
  )
  AND ord != 1;

-- 11. List the films together with the leading star for all 1962 films
SELECT
  title, name
FROM
  movie
JOIN
  casting ON movie.id = movieid
JOIN
  actor ON actorid = actor.id
WHERE
  ord = 1
  AND yr = 1962;

-- 12. Which were the busiest years for 'John Travolta', show the year and the
-- number of movies he made each year for any year in which he made more than 2
-- movies
SELECT
  yr, COUNT(movieid)
FROM
  movie
JOIN
  casting ON movie.id = movieid
JOIN
  actor ON actor.id = actorid
WHERE
  name = "John Travolta"
GROUP BY
  yr
HAVING
  COUNT(movieid) > 2;

-- 13. List the film title and the leading actor for all of the films 'Julie
-- Andrews' played in
SELECT
  title, name
FROM
  movie
JOIN
  casting ON movie.id = movieid
JOIN
  actor ON actor.id = actorid
WHERE
  ord = 1
  AND movieid IN (
    SELECT
      movieid
    FROM
      movie
    JOIN
      casting ON movie.id = movieid
    JOIN
      actor ON actor.id = actorid
    WHERE
      name = "Julie Andrews"
  );

-- 14. Obtain a list in alphabetical order of actors who've had at least 30
-- starring roles
SELECT
  name
FROM
  actor
JOIN
  casting ON id = actorid
WHERE
  ord = 1
GROUP BY
  name
HAVING
  COUNT(actorid) >= 30

-- 15. List the 1978 films by order of cast list size
SELECT
  title, COUNT(movieid)
FROM
  movie
JOIN
  casting ON id = movieid
WHERE
  yr = 1978
GROUP BY
  movieid
ORDER BY
  COUNT(movieid) DESC

-- 16. List all the people who have worked with 'Art Garfunkel'
SELECT
  DISTINCT name
FROM
  actor
JOIN
  casting ON id = actorid
WHERE
  movieid IN (
    SELECT
      movieid
    FROM
      casting
    WHERE
      actorid = (
        SELECT
          id
        FROM
          actor
        WHERE
          name = "Art Garfunkel"
      )
  ) AND name != "Art Garfunkel";

-- Using NULL

-- 1. List the teachers who have NULL for their department
SELECT
  name
FROM
  teacher
WHERE
  dept IS NULL;

-- 3. Use a different JOIN so that all teachers are listed, even those with
-- NULL for their department
SELECT
  teacher.name, dept.name
FROM
  teacher
LEFT JOIN
  dept ON teacher.dept = dept.id;

-- 4. Use a different JOIN so that all departments are listed
SELECT
  teacher.name, dept.name
FROM
  teacher
RIGHT JOIN
  dept ON teacher.dept = dept.id;

-- 5. Use COALESCE to print the mobile number. Use the number '07986 444 2266'
-- there is no number given. Show teacher name and mobile number or '07986 444
-- 2266'
SELECT
  name, COALESCE(mobile, '07986 444 2266') mobile
FROM
  teacher;

-- 6. Use the COALESCE function and a LEFT JOIN to print the name and
-- department name. Use the string 'None' where there is no department
SELECT
  teacher.name, COALESCE(dept.name, "None") name
FROM
  teacher
LEFT JOIN
  dept ON teacher.dept = dept.id;

-- 7. Use COUNT to show the number of teachers and the number of mobile phones
SELECT
  COUNT(name), COUNT(mobile)
FROM
  teacher;

-- 8. Use COUNT and GROUP BY dept.name to show each department and the number
-- of staff. Use a RIGHT JOIN to ensure that the Engineering department is
-- listed
SELECT
  dept.name, COUNT(teacher.dept)
FROM
  teacher
RIGHT JOIN
  dept ON dept.id = teacher.dept
GROUP BY
  dept.name;

-- 9. Use CASE to show the name of each teacher followed by 'Sci' if the the
-- teacher is in dept 1 or 2 and 'Art' otherwise
SELECT
  name, CASE
    WHEN dept BETWEEN 1 AND 2 THEN "Sci"
    ELSE "Art"
    END dept
FROM
  teacher;

-- 10. Use CASE to show the name of each teacher followed by 'Sci' if the the
-- teacher is in dept 1 or 2 show 'Art' if the dept is 3 and 'None' otherwise
SELECT
  name, CASE
    WHEN dept BETWEEN 1 AND 2 THEN "Sci"
    WHEN dept = 3 THEN "Art"
    ELSE "None"
    END dept
FROM
  teacher;

-- Self JOIN

--1. How many stops are in the database
SELECT
  COUNT(name)
FROM
  stops;

-- 2. Find the id value for the stop 'Craiglockhart'
SELECT
  id
FROM
  stops
WHERE
  name = "Craiglockhart";

-- 3. Give the id and the name for the stops on the '4' 'LRT' service
SELECT
  id, name
FROM
  stops
JOIN
  route ON id = stop
WHERE
  company = "LRT" AND num = 4;

-- 4. The query shown gives the number of routes that visit either London Road
-- (149) or Craiglockhart (53). Run the query and notice the two services that
-- link these stops have a count of 2. Add a HAVING clause to restrict the
-- output to these two routes
SELECT
  company, num, COUNT(*)
FROM
  route
WHERE
  stop = 149 OR stop = 53
GROUP BY
  company, num
HAVING
  COUNT(*) > 1;

-- 5. Execute the self join shown and observe that b.stop gives all the places
-- you can get to from Craiglockhart, without changing routes. Change the query
-- so that it shows the services from Craiglockhart to London Road
SELECT
  a.company, a.num, a.stop, b.stop
FROM
  route a
JOIN
  route b ON a.company = b.company AND a.num = b.num
WHERE
  a.stop = 53 AND b.stop = 149;

-- 6. The query shown is similar to the previous one, however by joining two
-- copies of the stops table we can refer to stops by name rather than by
-- number. Change the query so that the services between 'Craiglockhart' and
-- 'London Road' are shown
SELECT
  a.company, a.num, stopa.name, stopb.name
FROM
  route a
JOIN
  route b ON a.company = b.company AND a.num = b.num
JOIN
  stops stopa ON a.stop = stopa.id
JOIN
  stops stopb ON b.stop = stopb.id
WHERE
  stopa.name = "Craiglockhart"
  AND stopb.name = "London Road";

-- 7. Give a list of all the services which connect stops 115 and 137
-- ('Haymarket' and 'Leith')
SELECT
  DISTINCT a.company, a.num
FROM
  route a
JOIN
  route b ON a.num = b.num
  AND a.company = b.company
WHERE
  a.stop = 115
  AND b.stop = 137;

-- 8. Give a list of the services which connect the stops 'Craiglockhart' and
-- 'Tollcross'
SELECT
  a.company, a.num
FROM
  route a
JOIN
  route b ON a.num = b.num
  AND a.company = b.company
WHERE
  a.stop = (
    SELECT
      id
    FROM
      stops
    WHERE
      name = "Craiglockhart"
  ) AND b.stop = (
    SELECT
      id
    FROM
      stops
    WHERE
      name = "Tollcross"
  );

-- 9. Give a distinct list of the stops which may be reached from
-- 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself. Include
-- the company and bus no. of the relevant services
SELECT
  DISTINCT a.stop, a.company, a.num
FROM
  stops s
JOIN
  route a ON id = stop
JOIN
  route b ON a.company = b.company
  AND a.num = b.num
WHERE
  b.stop = (
    SELECT
      id
    FROM
      stops
    WHERE
      name = "Craiglockhart"
  );


-- 10. Find the routes involving two buses that can go from Craiglockhart to
-- Sighthill. Show the bus no. and company for the first bus, the name of the
-- stop for the transfer, and the bus no. and company for the second bus










