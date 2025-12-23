#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE exo1;
    CREATE DATABASE exo2;
    CREATE DATABASE exo3;
EOSQL
