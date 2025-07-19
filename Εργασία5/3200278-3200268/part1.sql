/*---------4ο Ερώτημα----------*/

/*Στο ερώτημα 4 δημιουργούμε ένα πίνακα Person που περιέχει τα κοινά στοιχεια των movie_cast και movie_crew
με πρωτογενές κλειδί το id. Στην συνέχεια δημιουργούμε 2 πίνακες Actor και CrewMember οι οποίοι εχουν το person_id 
το οποίο το πέρνουν ως ξένο κλείδι απ΄το id του πίνακα Person. Στην συνέχεια θέτουμε αυτο το person_id ως πρωτογενές στον Actor αλλά και
CrewMember γιατί θα μας χρησιμέψει για τα movie_cast και movie_crew αντιστοίχως.*/
CREATE TABLE Person (
	id int PRIMARY KEY,
	name varchar(40),
	gender int
);

CREATE TABLE Actor (
	person_id int,
	FOREIGN KEY(person_id) REFERENCES Person(id)
);

ALTER TABLE Actor 
ADD PRIMARY KEY (person_id);


CREATE TABLE CrewMember (
	person_id int,
	FOREIGN KEY(person_id) REFERENCES Person(id)
);

ALTER TABLE CrewMember
ADD PRIMARY KEY (person_id);

/*---------5ο Ερώτημα----------*/

/*Ο παρακάτω κώδικας βρισκεί και εμφανίζει τα person_id τα οποία ανήκουν και στο movie_crew αλλά και στο movie_cast αντιστοίχως
τα οπόια στον κάθε πίνακα έχουν διαφορετικό gender ή όνομα.*/
SELECT DISTINCT mca.person_id
FROM Movie_Cast mca 
INNER JOIN Movie_Crew mcr
ON mca.person_id = mcr.person_id
WHERE mca.gender <> mcr.gender OR mca.name <> mcr.name
/*Το παρακάτω update ουσιαστικά διορθώνει το λαθός που βρήκαμε με τον παρακάτω κώδικα. Πιο συγκεκριμένα το person_id 1785844 ητάν 
gender = 2(αρσενικό) στο movie_cast αλλά στο movie_crew ήταν 0(unassigned). Έτσι, με τον παρακάτω κώδικα το αλλάζουμε και στο movie_crew
ώστε και 'κει να είναι 2(αρσενικό).*/
UPDATE Movie_Crew SET gender = 2
WHERE person_id = 1785844

/*---------6ο Ερώτημα----------*/

/*Ο παρακάτω κώδικας ενώνει τους movie_crew και movie_cast με τήν χρήση της Union και απ' αυτούς παίρνουμε τα person_id,name και 
gender(δηλαδή τα κοινά τους στοιχεία) και τα κάνουμε insert στον πίνακα Person.*/
INSERT INTO Person(id,name,gender)
SELECT DISTINCT person_id,name,gender
FROM Movie_Cast
UNION 
SELECT DISTINCT person_id,name,gender
FROM Movie_Crew
/*Ο παρακάτω κώδικας παίρνει τα person_id απ'τον movie_cast και τα κάνει insert στον πίνακα Actor.*/
INSERT INTO Actor(person_id)
SELECT DISTINCT mca.person_id
FROM Movie_Cast mca
/*Ο παρακάτω κώδικας παίρνει τα person_id απ'τον movie_crew και τα κάνει insert στον πίνακα CrewMember.*/
INSERT INTO CrewMember(person_id)
SELECT DISTINCT mcr.person_id
FROM Movie_Crew mcr

/*---------7ο Ερώτημα----------*/

/*O παρακάτω κώδικας αντιγράφει τον πίνακα movie_cast σε έναν movie_cast2*/
SELECT * INTO Movie_Cast2 FROM Movie_Cast
/*Επειδή όμως με την παραπάνω αντιγραφή δεν αντιγράφονται και τα κλειδιά κάνουμε το παρακάτω alter table για να βάλουμε και τα κλειδιά*/
ALTER TABLE Movie_Cast2
ADD PRIMARY KEY(person_id,movie_id,cast_id,character),
ADD FOREIGN KEY (movie_id) REFERENCES Movie(id);
/*O παρακάτω κώδικας αντιγράφει τον πίνακα movie_crew σε έναν movie_crew2*/
SELECT * INTO Movie_Crew2 FROM Movie_Crew
/*Επειδή όμως με την παραπάνω αντιγραφή δεν αντιγράφονται και τα κλειδιά κάνουμε το παρακάτω alter table για να βάλουμε και τα κλειδιά*/
ALTER TABLE Movie_Crew2
ADD PRIMARY KEY (person_id,movie_id,job),
ADD FOREIGN KEY (movie_id) REFERENCES Movie(id);
/*Ο παρακάτω κώδικας διαγράφει τα κατάλληλα γνωρίσματα απ'τον movie_crew και δημιουργεί το νέο ξένο κλειδί το οποίο χρειάζεται.Πιο
συγκεκριμένα κάνει το person_id του ξένο κλειδί το οποίο κάνει reference στο person_id του CrewMember.*/
ALTER TABLE Movie_Crew
DROP COLUMN gender,
DROP COLUMN name,
ADD FOREIGN KEY (person_id) REFERENCES CrewMember(person_id);
/*Ο παρακάτω κώδικας διαγράφει τα κατάλληλα γνωρίσματα απ'τον movie_cast και δημιουργεί το νέο ξένο κλειδί το οποίο χρειάζεται.Πιο
συγκεκριμένα κάνει το person_id του ξένο κλειδί το οποίο κάνει reference στο person_id του Actor.*/
ALTER TABLE Movie_Cast
DROP COLUMN gender,
DROP COLUMN name,
ADD FOREIGN KEY (person_id) REFERENCES Actor(person_id);