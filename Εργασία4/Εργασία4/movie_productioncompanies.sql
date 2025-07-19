/*Αφού μια ταινία μπορεί να ανήκει σε παραπανώ από 1 production company και σε κάθε production company 
μπορούν να ανήκουν πολλές ταινιες για την δημιουργία πρωτογενούς κλειδιού απαιτείται ο συνδιασμός των 
pc_id και movie_id ώστε οτι δημιουργείται να είναι σίγουρα μοναδικό*/
ALTER TABLE Movie_Productioncompanies
ADD PRIMARY KEY (movie_id,pc_id);