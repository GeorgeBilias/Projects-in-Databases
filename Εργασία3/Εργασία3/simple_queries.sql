/* 
"Βρές μου τους τίτλους των 50 ταινίων που ανηκουν σε καποιο collection με μεγαλύτερο budget και 
εμφάνισε τες μαζί με το budget και την production company τους"

Output: 50 rows
*/

SELECT m.title,m.budget,c.name as collection
FROM Movie m
INNER JOIN Movie_Collection mc
	ON mc.movie_id = m.id
INNER JOIN Collection c
	ON mc.collection_id = c.id
ORDER BY m.budget DESC, m.title
LIMIT 50

/* 
"Βρές μου τους τίτλους των 30 adventure ταινίων με μεγαλύτερο popularity και εμφάνισε τες μαζί με το 
popularity τους"

Output: 30 rows
*/

SELECT m.title,m.popularity
FROM Movie m
INNER JOIN Movie_Genres mg
	ON mg.movie_id = m.id
INNER JOIN Genre g
	ON mg.genre_id = g.id
WHERE 
	g.name = 'Adventure'	
ORDER BY m.popularity DESC, m.title
LIMIT 30

/*
"Βρες για καθε genre την ταινια με το μεγαλυτερο revenue και εμφανισε τη μαζι με το genre και το revenue της"

Output: 9 rows
*/

SELECT g.name AS genre, m.title, m.revenue
FROM Genre g
INNER JOIN Movie_Genres mg
    ON g.id = mg.genre_id
INNER JOIN Movie m
    ON mg.movie_id = m.id
WHERE m.revenue = (SELECT MAX(sub_m.revenue)
	FROM Movie sub_m
        LEFT OUTER JOIN Movie_Genres sub_mg
             ON sub_mg.movie_id = sub_m.id
    WHERE
         sub_mg.genre_id = g.id
    )
ORDER BY m.revenue DESC

/*
"Βρες τις ταινιες που εχουν γινει produce απτους Warner Bros. και εμφανισε τες μαζι με τον αριθμο 
των writer τους"

Output: 594 rows
*/

SELECT m.title,COUNT(mc.person_id) AS writers
FROM Movie m 
INNER JOIN Movie_Productioncompanies mpc
	ON mpc.movie_id = m.id
INNER JOIN Productioncompany pc
	ON mpc.pc_id = pc.id
FULL OUTER JOIN Movie_Crew mc
	ON 	mc.movie_id = m.id AND
	mc.department = 'Writing'
WHERE pc.name = 'Warner Bros.'
GROUP BY m.title
ORDER BY writers DESC,m.title

/*
"Βρες για καθε collection (που εχει τουλαχιστον μια ταινια) την ταινια που βγηκε πρωτη και εμφανισε 
τη μαζι με το collection της και το release date της"

Output: 735 rows
*/

SELECT c.name AS collection, m.title, m.release_date
FROM Collection c
INNER JOIN Movie_Collection mc
    ON c.id = mc.collection_id
INNER JOIN Movie m
    ON mc.movie_id = m.id
WHERE m.release_date = (SELECT MIN(sub_m.release_date)
	FROM Movie sub_m
        LEFT OUTER JOIN Movie_Collection sub_mc
             ON sub_mc.movie_id = sub_m.id
    WHERE
         sub_mc.collection_id = c.id
    )
ORDER BY m.release_date

/*
"Βρες ολες τις ταινιες που εχουν φτιαχτει απ'την Lucasfilms και εχουν homepage και εμφανισε το ονομα
τους μαζι με το homepage τους"

Output: 9 rows
*/

SELECT DISTINCT m.title,m.homepage
FROM Movie m
INNER JOIN Movie_Productioncompanies mpc
	ON mpc.movie_id = m.id
INNER JOIN Productioncompany pc
	ON pc.id = mpc.pc_id
WHERE m.homepage IS NOT NULL AND 
pc.name = 'Lucasfilm'

/*
"Βρές μου τους τίτλους των ταινίων με τουλαχιστον ενα rating στίς οποίες παίζει ο Johnny Depp και 
εμφάνισε τες μαζί με το average rating τους"

Output: 19 rows
*/

SELECT m.title,avg(r.rating) as rating
FROM Movie m
INNER JOIN Movie_Cast mc
	ON mc.movie_id = m.id
FULL OUTER JOIN Ratings r
	ON r.movie_id = m.id
WHERE 
	mc.name = 'Johnny Depp' AND 
	rating IS NOT NULL
GROUP BY m.title
ORDER BY rating

/*
"Βρες τις production companies που εχουν βοηθησει στο production απο 100 εως 1000 ταινιες και εμφανισε τες 
μαζι με τον αριθμο των ταινιων στις οποιες εχουν συμβαλλει"

Output: 14 rows
*/
SELECT pc.name,COUNT(pc.name) as movies
FROM Productioncompany pc
INNER JOIN Movie_ProductionCompanies mpc
	ON pc.id = mpc.pc_id
INNER JOIN Movie m
	ON m.id = mpc.movie_id
GROUP BY pc.name
HAVING COUNT(pc.name) BETWEEN 100 AND 1000
ORDER BY COUNT(pc.name) DESC

/*
"Βρες για καθε ταινια που ειναι ειδους Crime ή Family τον αριθμο των keywords οπου εμπεριεχουν μεσα τους 
την λεξη dog και εμφανισε το ονομα τους μαζι με τον αριθμο αυτων των keywords τους εαν ειναι 2 ή παραπανω"

Output: 9 rows
*/

SELECT DISTINCT m.title,COUNT(DISTINCT k.name) AS dogwords
FROM Movie m
INNER JOIN Movie_Genres mg
	ON mg.movie_id = m.id
INNER JOIN Genre g
	ON g.id = mg.genre_id
INNER JOIN Movie_Keywords mk
	ON mk.movie_id = m.id
INNER JOIN Keyword k
	ON k.id = mk.keyword_id
WHERE k.name LIKE '%dog%' AND (
g.name = 'Family' OR g.name = 'Crime')
GROUP BY m.title
HAVING COUNT(DISTINCT k.name) >= 2
ORDER BY dogwords DESC

/*
"Βρες για καθε collection την ταινια που με μεγαλυτερο runtime και εμφανισε τη μαζι με το collection της
 και το runtime της"

Output: 761 rows
*/

SELECT c.name AS collection, m.title, m.runtime
FROM Collection c
INNER JOIN Movie_Collection mc
    ON c.id = mc.collection_id
INNER JOIN Movie m
    ON mc.movie_id = m.id
WHERE m.runtime = (SELECT MAX(sub_m.runtime)
	FROM Movie sub_m
        LEFT OUTER JOIN Movie_Collection sub_mc
             ON sub_mc.movie_id = sub_m.id
    WHERE
         sub_mc.collection_id = c.id
    )
ORDER BY m.runtime DESC

/*
"Βρες για καθε genre την γαλλικη ταινια με το μεγαλυτερο popularity και εμφανισε τον τιτλο της μαζι με 
το genre της και το popularity της."

Output: 9 rows
*/

SELECT g.name AS genre, m.title, m.popularity
FROM Genre g
INNER JOIN Movie_Genres mg
    ON g.id = mg.genre_id
INNER JOIN Movie m
    ON mg.movie_id = m.id
WHERE m.popularity = (SELECT MAX(sub_m.popularity)
	FROM Movie sub_m
        INNER JOIN Movie_Genres sub_mg
             ON sub_mg.movie_id = sub_m.id
    WHERE
         sub_mg.genre_id = g.id AND
		 sub_m.original_language = 'fr'
    )
ORDER BY m.popularity DESC

/*
"Βρες για ολα τα collection την action ή Adventure ταινια με το μικροτερο budget και εμφανισε το 
collection μαζι με τον τιτλο της ταινιας και το budget της"

Output: 394 rows
*/

SELECT DISTINCT c.name as collection, m.title, m.budget
FROM Collection c
INNER JOIN Movie_Collection mc
    ON c.id = mc.collection_id
INNER JOIN Movie m
    ON mc.movie_id = m.id
INNER JOIN Movie_Genres mg
	ON mg.movie_id = m.id
INNER JOIN Genre g
	ON g.id = mg.genre_id
WHERE m.budget = (SELECT MIN(sub_m.budget)
	FROM Movie sub_m
        LEFT OUTER JOIN Movie_Collection sub_mc
             ON sub_mc.movie_id = sub_m.id	 
    WHERE
         sub_mc.collection_id = c.id
         AND (g.name = 'Action' OR g.name = 'Adventure')
    ) 
ORDER BY m.budget DESC