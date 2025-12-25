
-- PARTIE 1 --

/* Question 1 */

CREATE TABLE CLIENT
(
CLI_ID INTEGER ,
TIT_CODE VARCHAR (10) ,
CLI_NOM VARCHAR (30) ,
CLI_PRENOM VARCHAR (30) ,
CLI_ENSEIGNE VARCHAR (50)
);

CREATE TABLE OCCUPATION
(
CHB_ID INTEGER ,
JOUR VARCHAR (10) ,
CLI_ID INTEGER ,
NB_PERS INTEGER ,
RESERVE INTEGER
);

/* Question 2

Peuplement de la base 'hotels' avec fillBaseHotel.sql

*/

/* Question 3 */

--a

SELECT CLI_NOM, CLI_PRENOM
FROM client
WHERE CLI_ID =5;

--b

SELECT JOUR
FROM OCCUPATION
WHERE CLI_ID = 5;

--c

SELECT CHB_ID
FROM OCCUPATION
WHERE JOUR = '1999-01-22';

--d

SELECT CLI_NOM, CLI_PRENOM
FROM CLIENT, OCCUPATION
WHERE CLIENT.CLI_ID = OCCUPATION.CLI_ID
AND OCCUPATION.JOUR = '1999-01-22';

/* Question 4 */

--a

EXPLAIN SELECT CLI_NOM, CLI_PRENOM
FROM client
WHERE CLI_ID =5;

--b

EXPLAIN SELECT JOUR
FROM OCCUPATION
WHERE CLI_ID = 5;

--c

EXPLAIN SELECT CHB_ID
FROM OCCUPATION
WHERE JOUR = '1999-01-22';

--d

EXPLAIN SELECT CLI_NOM, CLI_PRENOM
FROM CLIENT, OCCUPATION
WHERE CLIENT.CLI_ID = OCCUPATION.CLI_ID
AND OCCUPATION.JOUR = '1999-01-22';

-- PARTIE 2 --

/* Questions 1 */

-- Index unique sur CLI_ID de CLIENT (clé primaire)
CREATE UNIQUE INDEX idx_client_cli_id ON CLIENT(CLI_ID);

-- Index non-unique sur CLI_ID de OCCUPATION (clé étrangère)
CREATE INDEX idx_occupation_cli_id ON OCCUPATION(CLI_ID);

-- Index non-unique sur JOUR de OCCUPATION
CREATE INDEX idx_occupation_jour ON OCCUPATION(JOUR);

/* Question 2 */

--a

EXPLAIN SELECT CLI_NOM, CLI_PRENOM
FROM client
WHERE CLI_ID =5;

--b

EXPLAIN SELECT JOUR
FROM OCCUPATION
WHERE CLI_ID = 5;

--c

EXPLAIN SELECT CHB_ID
FROM OCCUPATION
WHERE JOUR = '1999-01-22';

--d

EXPLAIN SELECT CLI_NOM, CLI_PRENOM
FROM CLIENT, OCCUPATION
WHERE CLIENT.CLI_ID = OCCUPATION.CLI_ID
AND OCCUPATION.JOUR = '1999-01-22';

-- Partie 3 --

analyse CLIENT , OCCUPATION;

analyse verbose CLIENT , OCCUPATION;

INFO:  analyzing "public.client"
INFO:  "client": scanned 1 of 1 pages, containing 100 live rows and 0 dead rows; 100 rows in sample, 100 estimated total rows
INFO:  finished analyzing table "hotels.public.client"
avg read rate: 15.625 MB/s, avg write rate: 0.000 MB/s
buffer usage: 42 hits, 2 reads, 0 dirtied
WAL usage: 9 records, 0 full page images, 1332 bytes, 0 buffers full
system usage: CPU: user: 0.00 s, system: 0.00 s, elapsed: 0.00 s
INFO:  analyzing "public.occupation"
INFO:  "occupation": scanned 134 of 134 pages, containing 18182 live rows and 0 dead rows; 18182 rows in sample, 18182 estimated total rows
INFO:  finished analyzing table "hotels.public.occupation"
avg read rate: 0.000 MB/s, avg write rate: 0.000 MB/s
buffer usage: 170 hits, 0 reads, 0 dirtied
WAL usage: 7 records, 0 full page images, 500 bytes, 0 buffers full
system usage: CPU: user: 0.02 s, system: 0.00 s, elapsed: 0.02 s
ANALYZE
