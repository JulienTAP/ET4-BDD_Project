---
title: "Rapport de Projet - Base de Données"
subtitle: "Optimisation et Gestion de Base de Données Hôtelière"
author: "Nom de l'Étudiant"
date: "11 Décembre 2025"
institution: "ET4 - S1"
course: "Base de Données (BDD)"
professor: "Nom du Professeur"
lang: fr
documentclass: report
geometry: margin=2.5cm
fontsize: 12pt
linestretch: 1.5
toc: true
toc-depth: 3
numbersections: true
header-includes: |
  \usepackage{fancyhdr}
  \usepackage{graphicx}
  \usepackage{lastpage}
  \usepackage{xcolor}
  \definecolor{titleblue}{RGB}{0,51,102}
  \pagestyle{fancy}
  \fancyhf{}
  \fancyhead[L]{\small\textit{Rapport BDD - Projet Hôtel}}
  \fancyhead[R]{\small\textit{ET4 S1 - 2025}}
  \fancyfoot[C]{\small Page \thepage\ sur \pageref{LastPage}}
  \fancyfoot[L]{\small Nom de l'Étudiant}
  \fancyfoot[R]{\small\today}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0.4pt}
---

\newpage

# Résumé Exécutif

Ce rapport présente le travail réalisé dans le cadre du projet de Base de Données du semestre 1 de l'ET4. L'objectif principal était de concevoir, optimiser et interroger une base de données relationnelle pour un système de gestion hôtelière.

**Mots-clés :** Base de données, SQL, Optimisation, Docker, PostgreSQL, Gestion hôtelière

\newpage

# Introduction

## Contexte du Projet

[Décrire le contexte général du projet, les objectifs d'apprentissage et l'importance du sujet]

## Objectifs

Les objectifs principaux de ce projet sont :

1. **Conception de la base de données** : Modéliser un système de gestion hôtelière
2. **Implémentation** : Créer et peupler la base de données
3. **Optimisation** : Analyser et améliorer les performances des requêtes
4. **Exploitation** : Réaliser des requêtes complexes pour extraire des informations pertinentes

## Organisation du Rapport

Ce rapport est structuré comme suit :

- **Chapitre 2** : Architecture et environnement technique
- **Chapitre 3** : Conception de la base de données
- **Chapitre 4** : Exercice 1 - [Description]
- **Chapitre 5** : Exercice 2 - [Description]
- **Chapitre 6** : Conclusion et perspectives

\newpage

# Architecture et Environnement Technique

## Infrastructure Docker

### Configuration Docker Compose

[Décrire la configuration Docker utilisée, les services déployés]

```yaml
# Extrait du docker-compose.yml
# [Inclure les parties pertinentes]
```

### Scripts d'Initialisation

Le script `init-databases.sh` permet l'initialisation automatique de l'environnement :

```bash
# Description du script
```

## Schéma de la Base de Données

### Modèle Entité-Association

[Insérer le diagramme E-A ou décrire le modèle conceptuel]

### Modèle Relationnel

[Présenter le schéma relationnel avec les tables, clés primaires et étrangères]

### Fichier de Peuplement

Le fichier `fillBaseHotel.sql` contient les données initiales pour tester la base.

\newpage

# Exercice 1 : [Titre de l'Exercice]

## Objectif

[Décrire l'objectif de cet exercice]

## Analyse du Problème

[Analyser le problème posé et la démarche de résolution]

## Solutions Proposées

### Requête 1

**Description :** [Décrire ce que fait la requête]

```sql
-- Code SQL
SELECT ...
FROM ...
WHERE ...;
```

**Résultats :**

[Présenter les résultats obtenus]

**Analyse :**

[Analyser les performances, la pertinence des résultats]

### Requête 2

[Répéter la structure pour chaque requête]

## Optimisations

[Décrire les optimisations effectuées : index, restructuration, etc.]

### Plan d'Exécution

```sql
EXPLAIN ANALYZE
-- Requête optimisée
```

**Comparaison des performances :**

| Métrique | Avant | Après | Amélioration |
|----------|-------|-------|--------------|
| Temps d'exécution | X ms | Y ms | Z% |
| Coût estimé | A | B | C% |

## Difficultés Rencontrées

[Décrire les problèmes rencontrés et comment ils ont été résolus]

\newpage

# Exercice 2 : [Titre de l'Exercice]

## Objectif

[Décrire l'objectif de cet exercice]

## Analyse du Problème

[Analyser le problème posé et la démarche de résolution]

## Solutions Proposées

### Requête 1

**Description :** [Décrire ce que fait la requête]

```sql
-- Code SQL
SELECT ...
FROM ...
WHERE ...;
```

**Résultats :**

[Présenter les résultats obtenus]

**Analyse :**

[Analyser les performances, la pertinence des résultats]

## Script Complet

Le fichier `script.sql` contient l'ensemble des requêtes développées pour cet exercice.

```sql
-- Extrait du script principal
```

## Validation des Résultats

[Décrire comment les résultats ont été validés]

\newpage

# Conclusion

## Synthèse du Travail Réalisé

[Résumer les principales réalisations du projet]

## Compétences Acquises

Au cours de ce projet, les compétences suivantes ont été développées :

- **Conception** : Modélisation de bases de données relationnelles
- **Implémentation** : Création et peuplement de bases SQL
- **Optimisation** : Analyse de performances et optimisation de requêtes
- **Conteneurisation** : Utilisation de Docker pour l'environnement de développement
- **Analyse** : Interprétation de plans d'exécution et métriques de performance

## Perspectives d'Amélioration

[Proposer des améliorations possibles ou extensions du projet]

## Retour d'Expérience

[Donner un retour personnel sur le projet, les difficultés et les apprentissages]

\newpage

# Annexes

## Annexe A : Code Source Complet

### Exercice 1 - Exercice1.sql

```sql
-- Inclure le code complet
```

### Exercice 2 - Exercice2.sql

```sql
-- Inclure le code complet
```

## Annexe B : Configuration Docker

### docker-compose.yml

```yaml
-- Inclure la configuration complète
```

### init-databases.sh

```bash
-- Inclure le script d'initialisation
```

## Annexe C : Jeu de Données

### fillBaseHotel.sql

```sql
-- Inclure un extrait représentatif
```

## Annexe D : Résultats Détaillés

[Tableaux de résultats complets, captures d'écran, etc.]

\newpage

# Bibliographie

1. **Documentation PostgreSQL** - https://www.postgresql.org/docs/
2. **Docker Documentation** - https://docs.docker.com/
3. [Ajouter d'autres références pertinentes]

---

**Déclaration d'Authenticité**

Je soussigné(e) [Nom], déclare que ce rapport est le fruit de mon travail personnel. Toutes les sources utilisées ont été dûment citées.

Date : 11 Décembre 2025  
Signature : ___________________
