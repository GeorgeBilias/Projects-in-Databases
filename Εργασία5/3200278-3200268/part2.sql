/*Βρές μου τα άτομα που στην ίδια ταινία, με average rating μεγαλύτερο του 2, ανήκουν και στο crew αλλά και στο cast και εμφάνισε 
το όνομα τους, την ταινία αλλα και το average rating της. Σημείωση: κάποια άτομα μπορεί να εμφανιστούν παραπάνω από μια φορά καθώς
μπορεί οι παράμετροι να ισχύουν για πολλές ταινίες στις οποίες συμμετέχουν.
Output: 655 rows
*/
SELECT p.name, m.title,AVG(r.rating) AS rating
FROM Person p
INNER JOIN Movie_Crew mcr
ON mcr.person_id = p.id
INNER JOIN Movie_Cast mca
ON mca.person_id = p.id
INNER JOIN Movie m
ON m.id = mca.movie_id
INNER JOIN Ratings r
ON m.id = r.movie_id
WHERE mca.person_id = mcr.person_id AND 
mca.movie_id = mcr.movie_id
GROUP BY p.name,m.title
HAVING AVG(r.rating) > 2.0
/*Bρές μου τα άτομα που ανήκουν στο cast σε λιγότερες απο 20 ταινίες και εμφάνισε το όνομα τους μαζί με τον αριθμό των ταινίων στις
οποιες ανήκουν στο Cast.
Output: 68136 rows
*/
SELECT p.name,COUNT(DISTINCT m.title) AS movies
FROM Person p
INNER JOIN Movie_Cast mca
ON mca.person_id = p.id
INNER JOIN Movie m
ON m.id = mca.movie_id
WHERE mca.person_id = p.id
GROUP BY p.name
HAVING COUNT(DISTINCT m.title) < 20
ORDER BY COUNT(DISTINCT m.title) DESC
/*Βρές μου τα αρσενικά άτομα που ανήκουν στο Cast κάποιας ταινίας που ανήκει στο Star Wars Collection και εμφάνισε το όνομα τους μαζί
με τον αριθμό των ταινιών που ανήκουν στο Star Wars Collection στις οποίες συμμετέχουν.
Output: 118 rows
*/
SELECT DISTINCT p.name,COUNT(DISTINCT m.title) AS movies
FROM Person p
INNER JOIN Movie_Cast mca
ON mca.person_id = p.id
INNER JOIN Movie m
ON m.id = mca.movie_id
INNER JOIN Movie_Collection mc
ON mc.movie_id = m.id
INNER JOIN Collection c
ON c.id = mc.collection_id
WHERE p.gender = 2 AND c.name = 'Star Wars Collection'
GROUP BY p.name
ORDER BY COUNT(DISTINCT m.title) DESC