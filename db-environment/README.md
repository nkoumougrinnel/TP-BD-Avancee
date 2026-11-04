# 🚀 Guide d'Utilisation des Bases de Données du Projet

Ce guide est destiné à tous les membres de l'équipe. Si vous n'avez jamais utilisé Docker ou si les bases de données sont nouvelles pour vous, ne paniquez pas ! Tout est déjà configuré.

## 🛠️ Répertoire des Bases de Données

### 🐘 PostgreSQL (Relationnelle - SQL)
*   **C'est quoi ?** La base de données "classique". Elle organise les données dans des tableaux (colonnes et lignes) avec des liens stricts entre eux.
*   **Idéal pour :** Les données structurées, la comptabilité, les inventaires.
*   **Accès :**
    *   **Port :** `5432`
    *   **Utilisateur :** `user`
    *   **Mot de passe :** `password`
    *   **Base de données :** `mydatabase`
    *   **Outil recommandé :** DBeaver ou pgAdmin.

### 🍃 MongoDB (Document - NoSQL)
*   **C'est quoi ?** Au lieu de tableaux, elle stocke les données dans des documents qui ressemblent à du JSON (des fichiers `{ "clé": "valeur" }`). C'est très flexible.
*   **Idéal pour :** Les catalogues de produits, les profils utilisateurs, les données qui changent souvent de forme.
*   **Accès :**
    *   **Port :** `27017`
    *   **URI de connexion :** `mongodb://[IP_SERVEUR]:27017`
    *   **Outil recommandé :** MongoDB Compass ou DBeaver.

### ⚡ Redis (Clé-Valeur - NoSQL)
*   **C'est quoi ?** Une base de données ultra-rapide qui stocke tout en mémoire vive (RAM). Elle fonctionne comme un dictionnaire géant.
*   **Idéal pour :** Le cache (stocker temporairement une info pour ne pas recalculer), les sessions de connexion, les compteurs en temps réel.
*   **Accès :**
    *   **Port :** `6379`
    *   **Outil recommandé :** RedisInsight ou DBeaver.

### 📦 Cassandra (Colonnes - NoSQL)
*   **C'est quoi ?** Conçue pour gérer des quantités massives de données sur plusieurs serveurs sans jamais s'arrêter.
*   **Idéal pour :** Les logs, l'historique de messages, les données de capteurs (IoT).
*   **Accès :**
    *   **Port :** `9042`
    *   **Outil recommandé :** DBeaver.

### 🕸️ Neo4j (Graphe - NoSQL)
*   **C'est quoi ?** Elle ne stocke pas des lignes, mais des **Noeuds** (cercles) et des **Relations** (flèches). Elle est faite pour analyser les liens.
*   **Idéal pour :** Les réseaux sociaux (amis d'amis), les systèmes de recommandation, la détection de fraudes.
*   **Accès :**
    *   **Interface Web :** `http://[IP_SERVEUR]:7474`
    *   **Utilisateur :** `neo4j` / **Mot de passe :** `password`

### 📊 RStudio (Analyse de Données)
*   **C'est quoi ?** Ce n'est pas une base de données, mais un environnement pour le langage **R**. On l'utilise pour analyser les données extraites des bases ci-dessus.
*   **Accès :**
    *   **Interface Web :** `http://[IP_SERVEUR]:8787`
    *   **Utilisateur :** `rstudio` / **Mot de passe :** `password`

---

## ❓ Questions Fréquentes (FAQ)

**1. C'est quoi Docker ?**
Imaginez que Docker est une "boîte" magique. À l'intérieur de la boîte, on a mis la base de données et tout ce dont elle a besoin pour marcher. On n'a pas besoin de l'installer sur notre PC, on lance juste la boîte.

**2. Quel logiciel utiliser pour tout voir ?**
Nous recommandons **DBeaver**. C'est le seul logiciel capable de se connecter à presque toutes ces bases de données dans une seule interface.
