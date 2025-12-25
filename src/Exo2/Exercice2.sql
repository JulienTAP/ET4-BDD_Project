-- Partie 1 --

--Les Questions 1 à 5 ne présentent pas de questions mais seulement le peuplement de la base suivant :

drop schema if exists optimisation cascade;
create schema optimisation;
set search_path to optimisation ;
--drop table if exists clients cascade;
create unlogged table clients(
NumC integer primary key ,
NomC varchar (35),
AdresseC text
);
--drop table if exists produits cascade;
create unlogged table produits(
NumP integer primary key ,
NomP varchar (35),
descriptif text
);
--drop table if exists commandes cascade;
create unlogged table commandes(
DateCom date ,
NumC integer ,
Commentaire text ,
primary key(DateCom ,NumC)
);
--drop table if exists livraisons ;
create unlogged table livraisons(
DateLiv date ,
DateCom date ,
NumC Integer ,
Prestataire varchar ,
primary key(DateLiv ,DateCom ,NumC)
);
--drop table if exists Concerne;
create unlogged table concerne(
NumP integer ,
DateCom date ,
NumC integer ,
Quantite integer ,
primary key (NumP ,DateCom ,NumC)
);

drop procedure if exists rempli_tables;
create procedure rempli_tables(nbtuples integer)
as $$
declare
k integer;
un_numP integer;
compt integer;
une_date date;
curs_com cursor for select DateCom , numc
from optimisation.commandes;
begin
INSERT INTO optimisation.clients (numc , nomc , adressec)
SELECT g, 'nomc_ '||(( random () * nbtuples * 4 / 5):: integer)::varchar , md5(g::text)
||md5 ((2*g)::text)||md5 ((3*g)::text)
FROM generate_series (0,nbtuples -1) as g;
INSERT INTO optimisation.produits (nump , nomp , descriptif)
SELECT g, 'nomp_ '||(( random () * nbtuples * 4 / 5):: integer)::varchar , md5(g::text)
||md5 ((2*g)::text)||md5 ((3*g)::text)
FROM generate_series (0,nbtuples -1) as g;
for g in 1..4*( nbtuples -1) loop
une_date = CURRENT_TIMESTAMP - (( random () * 3650):: integer ||'day')::
interval;
un_nump =( random ()*(nbtuples -1)):: integer;
insert into optimisation.commandes (DateCom , numc , commentaire)
select une_date , un_nump , md5(g::text)||md5 ((2*g)::text)||md5 ((3*
g)::text) on conflict do nothing;
end loop;
for t in curs_com
loop
k=( random () *6):: integer;
for i in 1..k loop
un_numP = (random ()*(nbtuples -1)):: integer;
insert into optimisation.concerne (NumP ,datecom ,numc ,
quantite)
values (un_nump ,t.Datecom ,t.numc ,( random ()*100):: integer)
on conflict do nothing;
if i>3 then
une_date = t.datecom +(( random () * 30):: integer ||'
days'):: interval;
insert into optimisation.livraisons (DateLiv ,
DateCom , numC , prestataire)
values(une_date ,t.datecom ,t.numc ,'prest '||(( random
() *20):: integer):: varchar) on conflict do
nothing;
end if;end loop;
end loop;
end;
$$language plpgsql;

do $$
begin
call rempli_tables (500);
end
$$;

alter table optimisation.commandes add CONSTRAINT fk_commande_client foreign key (numc)
references optimisation.clients(NumC) on delete cascade not valid;
alter table optimisation.livraisons add constraint fk_livraison_commande foreign key (
DateCom ,NumC) references optimisation.commandes(DateCom ,NumC) on delete cascade not
valid;
alter table optimisation.concerne add constraint fk_concerne_commande foreign key (DateCom
,NumC) references optimisation.commandes(DateCom ,NumC) on delete cascade not valid;
alter table optimisation.concerne add constraint fk_concerne_produit foreign key (NumP)
references optimisation.produits(NumP) not valid;

analyse optimisation.clients , optimisation.commandes , optimisation.produits , optimisation.
concerne ,optimisation.livraisons;

analyse verbose optimisation.clients , optimisation.commandes , optimisation.produits ,
optimisation.concerne ,optimisation.livraisons;

/* Question 6 */

/*
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
*/

-- Partie 2 --

/* Question 1 */

SELECT *
FROM produits;

EXPLAIN (analyse,buffers)
SELECT *
FROM produits;

/* Question 2 */

SELECT nump, nomp
FROM produits;

EXPLAIN (analyse,buffers)
SELECT nump, nomp
FROM produits;

/* Question 3 */

SELECT DISTINCT nump, nomp
FROM produits;

EXPLAIN (analyse,buffers)
SELECT DISTINCT nump, nomp
FROM produits;

/* Question 4 */

SELECT DISTINCT nump, nomp
FROM produits
ORDER BY nomp;

EXPLAIN (analyse,buffers)
SELECT DISTINCT nump, nomp
FROM produits
ORDER BY nomp;

/* Question 5 */

SELECT *
FROM produits
WHERE nomp = 'nomp_ 327'; -- Je ne sais pas pourquoi tout mes nomp on un espace avant leur numéro

EXPLAIN (analyse,buffers)
SELECT *
FROM produits
WHERE nomp = 'nomp_ 327';

/* Question 6 */

SELECT numc, COUNT(*) AS nombre
FROM commandes
GROUP BY numc;

EXPLAIN (analyse,buffers)
SELECT numc, COUNT(*) AS nombre
FROM commandes
GROUP BY numc;

/* Question 7 */

SELECT cl.nomc AS "Nom du client", co.datecom as "Date de la commande"
FROM commandes AS co
JOIN clients AS cl ON co.numc = cl.numc;

EXPLAIN (analyse,buffers)
SELECT cl.nomc AS "Nom du client", co.datecom as "Date de la commande"
FROM commandes AS co
JOIN clients AS cl ON co.numc = cl.numc;

/* Question 8 */

explain -- Attention , pas de mot cl ́e "analyse" ici car la requ^ete ne termine pas !
select distinct nomc , nomp
from optimisation.clients ,optimisation.concerne , optimisation.produits , optimisation.commandes ,
optimisation.livraisons
where optimisation.clients.numc = optimisation.commandes.numc
and optimisation.commandes.datecom = optimisation.concerne.datecom
and optimisation.commandes.numc=optimisation.concerne.numc
and optimisation.produits.nump=optimisation.concerne.nump;

-- Partie 3 --

/* Question 2 */

--Requête1

Select *
from optimisation.commandes
where numC='116'
and datecom='2025-09-01';

EXPLAIN (analyse,buffers)
Select *
from optimisation.commandes
where numC='116'
and datecom='2025-09-01';

--Requête2

Select *
from optimisation.commandes
where datecom='2025-09-01';

EXPLAIN (analyse,buffers)
Select *
from optimisation.commandes
where datecom='2025-09-01';

--Requête3

Select *
from optimisation.commandes
where numC='116';

EXPLAIN (analyse,buffers)
Select *
from optimisation.commandes
where numC='116';

/* Question 3 */

Select nomp
from optimisation.produits p
join optimisation.concerne co using(nump)
join optimisation.clients c using(numc)
where nomc='nomc_ 7';

EXPLAIN (analyse,buffers)
Select nomp
from optimisation.produits p
join optimisation.concerne co using(nump)
join optimisation.clients c using(numc)
where nomc='nomc_ 7';

--Index 

CREATE INDEX idx_clients_nomc ON optimisation.clients(nomc);
CREATE INDEX idx_concerne_numc ON optimisation.concerne(numc);
analyse optimisation.clients , optimisation.commandes , optimisation.produits , optimisation.
concerne ,optimisation.livraisons;

EXPLAIN (analyse,buffers)
Select nomp
from optimisation.produits p
join optimisation.concerne co using(nump)
join optimisation.clients c using(numc)
where nomc='nomc_ 7';

--Supression index

DROP INDEX IF EXISTS idx_clients_nomc;
DROP INDEX IF EXISTS idx_concerne_numc;

/* Question 4 */

EXPLAIN (analyse,buffers)
Select numc
from optimisation.clients
where numc not in
(select numc from optimisation.livraisons);

EXPLAIN (analyse,buffers)
Select numc
from optimisation.clients
except
select numc
from optimisation.livraisons;

EXPLAIN (analyse,buffers)
Select numc
from optimisation.clients
where not exists
(select numc from optimisation.livraisons
where optimisation.livraisons.numc=optimisation.clients.numc);

/* Question 5 */

EXPLAIN (analyse,buffers)
Select upper(nomc), adressec
From clients
Where upper(nomc)='NOMC_ 7';

CREATE INDEX idx_clients_upper_nomc ON optimisation.clients(upper(nomc));

analyse optimisation.clients;

EXPLAIN (analyse,buffers)
Select upper(nomc), adressec
From clients
Where upper(nomc)='NOMC_ 7';

/* Question 6 */

EXPLAIN (analyse,buffers)
SELECT COUNT (*)
FROM commandes
WHERE EXTRACT(YEAR FROM datecom) = 2017;

EXPLAIN (analyse,buffers)
SELECT COUNT (*)
FROM commandes
WHERE datecom >= '2017-01-01' AND datecom < '2018-01-01';

