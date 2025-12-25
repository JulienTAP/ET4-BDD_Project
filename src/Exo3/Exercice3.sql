-- Partie 1 --

--Creation du shéma de la base : 

CREATE TABLE Artiste (
ID_artiste VARCHAR(4),
Nom VARCHAR(32),
Adresse VARCHAR(32)
);

CREATE TABLE Film (
ID_film VARCHAR(4),
Titre VARCHAR(32),
Annee VARCHAR(4),
ID_realisateur VARCHAR(4)
);

CREATE TABLE Joue (
ID_artiste VARCHAR(4),
ID_film VARCHAR(4)
);

/* Question 1 */

SELECT Artiste.Nom, Film.Titre
FROM Artiste
JOIN Joue ON Artiste.ID_artiste = Joue.ID_artiste
JOIN Film ON Joue.ID_film = Film.ID_film;

/* Question 2 */

-- π_{Nom, Titre} (Artiste ⋈{Artiste.ID_artiste = Joue.ID_artiste} Joue ⋈{Joue.ID_film = Film.ID_film} Film)

/* Question 3 */

-- Pas de code, voir Rapport pour les réponses aux questions.

