-- Partie 1 --

/* Question 6 */

INFO:  analyzing "optimisation.clients"
INFO:  "clients": scanned 9 of 9 pages, containing 500 live rows and 0 dead rows; 500 rows in sample, 500 estimated total rows
INFO:  finished analyzing table "hotels.optimisation.clients"
avg read rate: 0.000 MB/s, avg write rate: 1.953 MB/s
buffer usage: 58 hits, 0 reads, 1 dirtied
WAL usage: 24 records, 0 full page images, 11635 bytes, 0 buffers full
system usage: CPU: user: 0.00 s, system: 0.00 s, elapsed: 0.00 s
INFO:  analyzing "optimisation.commandes"
INFO:  "commandes": scanned 35 of 35 pages, containing 1996 live rows and 0 dead rows; 1996 rows in sample, 1996 estimated total rows
INFO:  finished analyzing table "hotels.optimisation.commandes"
avg read rate: 0.000 MB/s, avg write rate: 5.208 MB/s
buffer usage: 91 hits, 0 reads, 2 dirtied
WAL usage: 24 records, 0 full page images, 11645 bytes, 0 buffers full
system usage: CPU: user: 0.00 s, system: 0.00 s, elapsed: 0.00 s
INFO:  analyzing "optimisation.produits"
INFO:  "produits": scanned 9 of 9 pages, containing 500 live rows and 0 dead rows; 500 rows in sample, 500 estimated total rows
INFO:  finished analyzing table "hotels.optimisation.produits"
avg read rate: 0.000 MB/s, avg write rate: 3.906 MB/s
buffer usage: 58 hits, 0 reads, 1 dirtied
WAL usage: 24 records, 0 full page images, 11643 bytes, 0 buffers full
system usage: CPU: user: 0.00 s, system: 0.00 s, elapsed: 0.00 s
INFO:  analyzing "optimisation.concerne"
INFO:  "concerne": scanned 33 of 33 pages, containing 5991 live rows and 0 dead rows; 5991 rows in sample, 5991 estimated total rows
INFO:  finished analyzing table "hotels.optimisation.concerne"
avg read rate: 0.000 MB/s, avg write rate: 1.953 MB/s
buffer usage: 85 hits, 0 reads, 1 dirtied
WAL usage: 12 records, 0 full page images, 5892 bytes, 0 buffers full
system usage: CPU: user: 0.00 s, system: 0.00 s, elapsed: 0.00 s
INFO:  analyzing "optimisation.livraisons"
INFO:  "livraisons": scanned 10 of 10 pages, containing 1497 live rows and 0 dead rows; 1497 rows in sample, 1497 estimated total rows
INFO:  finished analyzing table "hotels.optimisation.livraisons"
avg read rate: 0.000 MB/s, avg write rate: 0.000 MB/s
buffer usage: 41 hits, 0 reads, 0 dirtied
WAL usage: 5 records, 0 full page images, 366 bytes, 0 buffers full
system usage: CPU: user: 0.00 s, system: 0.00 s, elapsed: 0.00 s
ANALYZE

-- Partie 2 --

/* Question 1 */

SELECT *
FROM produits;

EXPLAIN (analyse,buffers)
SELECT *
FROM produits;

                                                 QUERY PLAN                                                 
------------------------------------------------------------------------------------------------------------
 Seq Scan on produits  (cost=0.00..14.00 rows=500 width=110) (actual time=0.020..0.095 rows=500.00 loops=1)
   Buffers: shared hit=9
 Planning Time: 0.078 ms
 Execution Time: 0.154 ms
(4 rows)

-- Insert explainations --

/* Question 2 */

SELECT nump, nomp
FROM produits;

EXPLAIN (analyse,buffers)
SELECT nump, nomp
FROM produits;

                                                QUERY PLAN                                                 
-----------------------------------------------------------------------------------------------------------
 Seq Scan on produits  (cost=0.00..14.00 rows=500 width=13) (actual time=0.020..0.069 rows=500.00 loops=1)
   Buffers: shared hit=9
 Planning Time: 0.085 ms
 Execution Time: 0.102 ms
(4 rows)

-- Insert explainations --

/* Question 3 */

SELECT DISTINCT nump, nomp
FROM produits;

EXPLAIN (analyse,buffers)
SELECT DISTINCT nump, nomp
FROM produits;

                                                   QUERY PLAN                                                    
-----------------------------------------------------------------------------------------------------------------
 HashAggregate  (cost=16.50..21.50 rows=500 width=13) (actual time=0.328..0.372 rows=500.00 loops=1)
   Group Key: nump, nomp
   Batches: 1  Memory Usage: 57kB
   Buffers: shared hit=9
   ->  Seq Scan on produits  (cost=0.00..14.00 rows=500 width=13) (actual time=0.014..0.121 rows=500.00 loops=1)
         Buffers: shared hit=9
 Planning:
   Buffers: shared hit=15
 Planning Time: 0.172 ms
 Execution Time: 0.432 ms
(10 rows)

-- Insert explainations --

/* Question 4 */

SELECT DISTINCT nump, nomp
FROM produits
ORDER BY nomp;

EXPLAIN (analyse,buffers)
SELECT DISTINCT nump, nomp
FROM produits
ORDER BY nomp;

                                                      QUERY PLAN                                                       
-----------------------------------------------------------------------------------------------------------------------
 Unique  (cost=36.41..40.16 rows=500 width=13) (actual time=0.975..1.050 rows=500.00 loops=1)
   Buffers: shared hit=9
   ->  Sort  (cost=36.41..37.66 rows=500 width=13) (actual time=0.974..0.992 rows=500.00 loops=1)
         Sort Key: nomp, nump
         Sort Method: quicksort  Memory: 40kB
         Buffers: shared hit=9
         ->  Seq Scan on produits  (cost=0.00..14.00 rows=500 width=13) (actual time=0.027..0.140 rows=500.00 loops=1)
               Buffers: shared hit=9
 Planning Time: 0.211 ms
 Execution Time: 1.103 ms
(10 rows)

-- Insert explainations --

/* Question 5 */

SELECT *
FROM produits
WHERE nomp = 'nomp_ 327'; -- Je ne sais pas pourquoi tout mes nomp on un espace avant leur numéro

EXPLAIN (analyse,buffers)
SELECT *
FROM produits
WHERE nomp = 'nomp_ 327';

                                               QUERY PLAN                                               
--------------------------------------------------------------------------------------------------------
 Seq Scan on produits  (cost=0.00..15.25 rows=1 width=110) (actual time=0.062..0.091 rows=2.00 loops=1)
   Filter: ((nomp)::text = 'nomp_ 327'::text)
   Rows Removed by Filter: 498
   Buffers: shared hit=9
 Planning Time: 0.087 ms
 Execution Time: 0.109 ms
(6 rows)

-- Insert explainations --

/* Question 6 */

SELECT numc, COUNT(*) AS nombre
FROM commandes
GROUP BY numc;

EXPLAIN (analyse,buffers)
SELECT numc, COUNT(*) AS nombre
FROM commandes
GROUP BY numc;

                                                    QUERY PLAN                                                     
-------------------------------------------------------------------------------------------------------------------
 HashAggregate  (cost=64.94..69.86 rows=492 width=12) (actual time=0.451..0.497 rows=492.00 loops=1)
   Group Key: numc
   Batches: 1  Memory Usage: 73kB
   Buffers: shared hit=35
   ->  Seq Scan on commandes  (cost=0.00..54.96 rows=1996 width=4) (actual time=0.021..0.147 rows=1996.00 loops=1)
         Buffers: shared hit=35
 Planning Time: 0.132 ms
 Execution Time: 0.555 ms
(8 rows)

-- Insert explainations --

/* Question 7 */

SELECT cl.nomc AS "Nom du client", co.datecom as "Date de la commande"
FROM commandes AS co
JOIN clients AS cl ON co.numc = cl.numc;

EXPLAIN (analyse,buffers)
SELECT cl.nomc AS "Nom du client", co.datecom as "Date de la commande"
FROM commandes AS co
JOIN clients AS cl ON co.numc = cl.numc;

                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Hash Join  (cost=20.25..80.49 rows=1996 width=13) (actual time=0.269..1.762 rows=1996.00 loops=1)
   Hash Cond: (co.numc = cl.numc)
   Buffers: shared hit=44
   ->  Seq Scan on commandes co  (cost=0.00..54.96 rows=1996 width=8) (actual time=0.012..0.353 rows=1996.00 loops=1)
         Buffers: shared hit=35
   ->  Hash  (cost=14.00..14.00 rows=500 width=13) (actual time=0.229..0.231 rows=500.00 loops=1)
         Buckets: 1024  Batches: 1  Memory Usage: 32kB
         Buffers: shared hit=9
         ->  Seq Scan on clients cl  (cost=0.00..14.00 rows=500 width=13) (actual time=0.012..0.108 rows=500.00 loops=1)
               Buffers: shared hit=9
 Planning:
   Buffers: shared hit=6
 Planning Time: 0.345 ms
 Execution Time: 2.062 ms
(14 rows)

-- Insert explainations --

/* Question 8 */

explain -- Attention , pas de mot cl ́e "analyse" ici car la requ^ete ne termine pas !
select distinct nomc , nomp
from optimisation.clients ,optimisation.concerne , optimisation.produits , optimisation.commandes ,
optimisation.livraisons
where optimisation.clients.numc = optimisation.commandes.numc
and optimisation.commandes.datecom = optimisation.concerne.datecom
and optimisation.commandes.numc=optimisation.concerne.numc
and optimisation.produits.nump=optimisation.concerne.nump;

                                                QUERY PLAN                                                 
-----------------------------------------------------------------------------------------------------------
 HashAggregate  (cost=98217.11..99026.51 rows=80940 width=18)
   Group Key: clients.nomc, produits.nomp
   ->  Merge Join  (cost=541.30..53374.48 rows=8968527 width=18)
         Merge Cond: ((commandes.datecom = concerne.datecom) AND (commandes.numc = clients.numc))
         ->  Nested Loop  (cost=0.28..37453.08 rows=2988012 width=8)
               ->  Index Only Scan using commandes_pkey on commandes  (cost=0.28..74.22 rows=1996 width=8)
               ->  Materialize  (cost=0.00..32.45 rows=1497 width=0)
                     ->  Seq Scan on livraisons  (cost=0.00..24.97 rows=1497 width=0)
         ->  Sort  (cost=541.02..556.00 rows=5991 width=30)
               Sort Key: concerne.datecom, clients.numc
               ->  Hash Join  (cost=40.50..165.13 rows=5991 width=30)
                     Hash Cond: (concerne.nump = produits.nump)
                     ->  Hash Join  (cost=20.25..129.02 rows=5991 width=25)
                           Hash Cond: (concerne.numc = clients.numc)
                           ->  Seq Scan on concerne  (cost=0.00..92.91 rows=5991 width=12)
                           ->  Hash  (cost=14.00..14.00 rows=500 width=13)
                                 ->  Seq Scan on clients  (cost=0.00..14.00 rows=500 width=13)
                     ->  Hash  (cost=14.00..14.00 rows=500 width=13)
                           ->  Seq Scan on produits  (cost=0.00..14.00 rows=500 width=13)
(19 rows)

-- Partie 3 --

/* Question 2 */

--Requête1

--a

Select *
from optimisation.commandes
where numC='354'
and datecom='2025-09-02';

--b
--Nous n'avons pas encore definit d'index.

--c

--Requête2

--a

--b
--Nous n'avons pas encore definit d'index.

--c

--Requête3

--a

--b
--Nous n'avons pas encore definit d'index.

--c



