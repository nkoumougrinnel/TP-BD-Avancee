# 📌 TP3 : Analyse de Données et Statistiques avec RStudio

Ce dossier contient tout le travail relatif au troisième TP du cours de Bases de Données Avancées.

## 🎯 Objectifs
- Exploitation des données extraites des bases de données.
- Analyse statistique et visualisation de données avec le langage R.
- Utilisation de bibliothèques spécialisées (Tidyverse, FactoMineR, etc.).
- **Mission Groupe 8** : Aide à la décision (Synthèse des quatre analyses communes, recommandations opérationnelles argumentées et analyse des limites des données).

## 📂 Structure du dossier
- `data/` : Contient le jeu de données (`.csv`) utilisé pour l'analyse.
- `scripts/` : Historique des commandes R exécutées (`.Rhistory`).
- `images/` : Graphiques générés durant l'analyse (ACP, cercle des corrélations, etc.).
- `guide.md` : Guide détaillé et pédagogique documentant chaque étape du TP pour un débutant.
- `enonce.md` : L'énoncé officiel du TP.

## 🚀 Guide de lancement rapide
1. **Lancer l'infrastructure** :
   ```bash
   cd ../db-environment
   docker compose up -d rstudio
   ```
2. **Accès** :
   Ouvrez votre navigateur sur `http://localhost:8787` (Utilisateur: `rstudio`, Mot de passe: `password`).
3. **Configuration** :
   Les packages nécessaires sont pré-installés dans l'image.
