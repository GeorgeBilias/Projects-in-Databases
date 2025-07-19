/*Αφού μια ταινία δεν μπορεί να είναι σε παραπάνω απο ένα collection για πρώτογενες κλειδί επαρκεί
το movie_id*/
ALTER TABLE Movie_Collection
ADD PRIMARY KEY (movie_id);