
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

                      QUERY PLAN                       
-------------------------------------------------------
 Seq Scan on client  (cost=0.00..2.25 rows=1 width=15)
   Filter: (cli_id = 5)
(2 rows)

-- Insert tree and explainations  --

--b

EXPLAIN SELECT JOUR
FROM OCCUPATION
WHERE CLI_ID = 5;

                          QUERY PLAN                           
---------------------------------------------------------------
 Seq Scan on occupation  (cost=0.00..361.27 rows=166 width=11)
   Filter: (cli_id = 5)
(2 rows)

-- Insert tree and explainations  --

--c

EXPLAIN SELECT CHB_ID
FROM OCCUPATION
WHERE JOUR = '1999-01-22';

                         QUERY PLAN                          
-------------------------------------------------------------
 Seq Scan on occupation  (cost=0.00..361.27 rows=11 width=4)
   Filter: ((jour)::text = '1999-01-22'::text)
(2 rows)

-- Insert tree and explainations  --

--d

EXPLAIN SELECT CLI_NOM, CLI_PRENOM
FROM CLIENT, OCCUPATION
WHERE CLIENT.CLI_ID = OCCUPATION.CLI_ID
AND OCCUPATION.JOUR = '1999-01-22';

                             QUERY PLAN                              
---------------------------------------------------------------------
 Hash Join  (cost=3.25..364.68 rows=11 width=15)
   Hash Cond: (occupation.cli_id = client.cli_id)
   ->  Seq Scan on occupation  (cost=0.00..361.27 rows=11 width=4)
         Filter: ((jour)::text = '1999-01-22'::text)
   ->  Hash  (cost=2.00..2.00 rows=100 width=19)
         ->  Seq Scan on client  (cost=0.00..2.00 rows=100 width=19)
(6 rows)

-- Insert tree and explainations  --

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

                      QUERY PLAN                       
-------------------------------------------------------
 Seq Scan on client  (cost=0.00..2.25 rows=1 width=15)
   Filter: (cli_id = 5)
(2 rows)

-- Insert tree and explainations  --

--b

EXPLAIN SELECT JOUR
FROM OCCUPATION
WHERE CLI_ID = 5;

                                      QUERY PLAN                                      
--------------------------------------------------------------------------------------
 Bitmap Heap Scan on occupation  (cost=5.57..148.74 rows=166 width=11)
   Recheck Cond: (cli_id = 5)
   ->  Bitmap Index Scan on idx_occupation_cli_id  (cost=0.00..5.53 rows=166 width=0)
         Index Cond: (cli_id = 5)
(4 rows)

-- Insert tree and explainations  --

--c

EXPLAIN SELECT CHB_ID
FROM OCCUPATION
WHERE JOUR = '1999-01-22';

                                       QUERY PLAN                                       
----------------------------------------------------------------------------------------
 Index Scan using idx_occupation_jour on occupation  (cost=0.29..25.44 rows=11 width=4)
   Index Cond: ((jour)::text = '1999-01-22'::text)
(2 rows)

-- Insert tree and explainations  --

--d

EXPLAIN SELECT CLI_NOM, CLI_PRENOM
FROM CLIENT, OCCUPATION
WHERE CLIENT.CLI_ID = OCCUPATION.CLI_ID
AND OCCUPATION.JOUR = '1999-01-22';

                                          QUERY PLAN                                          
----------------------------------------------------------------------------------------------
 Hash Join  (cost=3.54..28.72 rows=11 width=15)
   Hash Cond: (occupation.cli_id = client.cli_id)
   ->  Index Scan using idx_occupation_jour on occupation  (cost=0.29..25.44 rows=11 width=4)
         Index Cond: ((jour)::text = '1999-01-22'::text)
   ->  Hash  (cost=2.00..2.00 rows=100 width=19)
         ->  Seq Scan on client  (cost=0.00..2.00 rows=100 width=19)
(6 rows)

-- Insert tree and explainations  --

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

-- Insert explainations --