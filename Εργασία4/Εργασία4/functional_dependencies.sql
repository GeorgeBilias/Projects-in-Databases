/*Στους παρακάτω κώδικες ουσιαστικα για κάθε ξεχωριστό person_id μετράμε τα διαφορετίκα είδη ονομάτων
και γενών(COUNT(DISTINCT)) και σε όποιο person_id βρίσκει παραπάνω απο 1 είδος σε τουλάχιστον ένα απ΄ αυτά
τα 2 (>1 OR >1) το εμφανίζει (SELECT mc.person_id)*/

SELECT mc.person_id
FROM Movie_Cast mc
GROUP BY mc.person_id
HAVING COUNT(DISTINCT mc.gender)>1 OR
COUNT(DISTINCT mc.name)>1

SELECT mc.person_id
FROM Movie_Crew mc
GROUP BY mc.person_id
HAVING COUNT(DISTINCT mc.gender)>1 OR
COUNT(DISTINCT mc.name)>1 