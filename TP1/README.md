# 📌 TP1 : Administration, Sécurité et Recherche Sémantique PostgreSQL

Ce dossier contient tout le travail relatif au premier TP du cours de Bases de Données Avancées.

## 🎯 Objectifs
- Mise en œuvre de la sécurité (Rôles, Utilisateurs, Privilèges).
- Gestion des transactions et de la concurrence.
- Implémentation de la recherche sémantique avec `pgvector`.
- **Mission Groupe 4** : Gestion de la concurrence sur les stocks (Verrouillage `SELECT ... FOR UPDATE`, Niveaux d'isolation).

## 📂 Structure du dossier
- `scripts/` : Contient les fichiers `.sql` pour la création et les requêtes.
- `data/` : Jeu de données initial pour le TP.
- `documents/` : Réponses aux questions et captures d'écran des résultats.

## 🚀 Guide de lancement rapide
1. **Lancer l'infrastructure** :
   ```bash
   cd ../db-environment
   docker compose up -d postgres
   ```
2. **Initialiser la base** :
   Exécuter les scripts dans `data/` puis `scripts/creation.sql`.
3. **Exécuter les tests** :
   Lancer les requêtes dans `scripts/requetes.sql`.
