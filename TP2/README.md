# 📌 TP2 : Exploration et Manipulation des Bases de Données NoSQL

Ce dossier contient tout le travail relatif au deuxième TP du cours de Bases de Données Avancées.

## 🎯 Objectifs
- Mise en œuvre et interrogation de bases de données NoSQL.
- Manipulation de données avec MongoDB, Redis, Cassandra et Neo4j.
- Comparaison des modèles de données (Document, Clé-Valeur, Colonnes, Graphe).
- **Mission Groupe 6** : Gestion des ressources pédagogiques avec MongoDB (Gestion de documents hétérogènes, recherche par type/UE/auteur et agrégations).

## 📂 Structure du dossier
- `scripts/` : Contient les requêtes NoSQL (Mongo queries, Cypher, etc.).
- `data/` : Fichiers de données et imports pour le TP.
- `documents/` : Réponses aux questions et captures d'écran des résultats.

## 🚀 Guide de lancement rapide
1. **Lancer l'infrastructure** :
   ```bash
   cd ../db-environment
   docker compose up -d
   ```
2. **Utilisation** :
   Se connecter aux différentes instances via DBeaver ou les interfaces web (ex: Neo4j sur le port 7474).
