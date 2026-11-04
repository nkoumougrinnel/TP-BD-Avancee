# Transcription Intégrale du Document TP : Administration PostgreSQL



### 1. CONTEXTE GENERAL

Une entreprise dispose d'une plateforme informatique permettant de gerer ses clients, ses produits, ses commandes, ses paiements et ses livraisons. La base de donnees est administree sous PostgreSQL. Plusieurs utilisateurs interviennent sur la plateforme selon leurs responsabilites professionnelles : gestion commerciale, gestion des stocks, comptabilite, logistique et supervision. L'administrateur de bases de donnees (DBA) est charge de garantir la securite des acces, la coherence des donnees, la fiabilite des transactions et le bon fonctionnement des operations concurrentes. L'entreprise souhaite egalement integrer une fonctionnalite de recherche intelligente permettant de retrouver des produits a partir de leur signification, et non uniquement a partir de mots- cles exacts. Cette fonctionnalite reposera sur la recherche semantique avec l'extension PostgreSQL pgvector.

Vous etes recrutés comme assistants administrateurs de bases de donnees. Votre mission consiste a mettre en œuvre, tester et documenter les mecanismes necessaires au fonctionnement fiable de cette plateforme.

#### Objectif general

Mettre en pratique les fonctionnalites avancees de PostgreSQL en matiere d'administration, de securite, de gestion des transactions, de concurrence, d'interrogation des donnees et de recherche semantique.

#### Competences visées

A l'issue de ce TP, chaque etudiant doit etre capable de :

1. Creer des roles et des utilisateurs PostgreSQL et leur attribuer des privileges adaptes.
2. Ecrire et controler des transactions SQL.
3. Concevoir et utiliser des declencheurs.
4. Manipuler les verrous et expliquer les niveaux d'isolation.
5. Construire des requetes utilisant des jointures et des sous-requetes.
6. Activer et utiliser l'extension pgvector pour effectuer une recherche par similarite vectorielle.
7. Expliquer la difference entre un modele d'embeddings, le stockage des vecteurs et leur exploitation dans PostgreSQL.

### II. PARTIE COMMUNE A TOUS LES GROUPES

Les huit groupes doivent realiser cette partie avant de commencer leur mission specialisee. Tous les groupes utilisent le meme schema relationnel et le meme jeu de donnees. Seules les operations propres a leur module different.

#### 1 : Creation de la base de donnees





### 1.1. Table clients

Create table client les informations relatives aux clients de l'entreprise.

```sql
CREATE TABLE clients ( id_client SERIAL PRIMARY KEY, nom VARCHAR(100) NOT NULL, ville VARCHAR(100), email VARCHAR(150) UNIQUE );
```

### 2.2. Table utilisateurs

Cette table représente les utilisateurs fonctionnels de la plateforme. Elle ne correspond pas aux comptes de connexion PostgreSQL.

```sql
CREATE TABLE utilisateurs ( id_utilisateur SERIAL PRIMARY KEY, nom VARCHAR(100) NOT NULL, fonction VARCHAR(50) NOT NULL, actif BOOLEAN DEFAULT TRUE );
```

### 2.3. Table produits

Cette table contient les produits commercialises par l'entreprise.

```sql
CREATE TABLE produits ( id_produit SERIAL PRIMARY KEY, libelle VARCHAR(100) NOT NULL, prix NUMERIC(12,2) NOT NULL CHECK (prix >= 0), stock INTEGER NOT NULL CHECK (stock >= 0) );
```

### 2.4. Table commandes

Cette table enregistre les commandes des clients.

```sql
CREATE TABLE commandes ( id_commande SERIAL PRIMARY KEY, id_client INTEGER NOT NULL REFERENCES clients(id_client), id_utilisateur INTEGER REFERENCES utilisateurs(id_utilisateur), date_commande TIMESTAMP DEFAULT CURRENT_TIMESTAMP, statut VARCHAR(20) NOT NULL DEFAULT 'EN_ATTENTE' CHECK ( statut IN ( 'EN_ATTENTE',
```










```sql
INSERT INTO clients (nom, ville, email) VALUES ('Alice', 'Yaounde', 'alice@example.com'), ('Boris', 'Douala', 'boris@example.com'), ('Carine', 'Bafoussam', 'carine@example.com'), ('David', 'Garoua', 'david@example.com'), ('Estelle', 'Yaounde', 'estelle@example.com');

INSERT INTO utilisateurs (nom, fonction) VALUES ('Paul', 'Commercial'), ('Marie', 'Responsible stock'), ('Jean', 'Comptable'), ('Sarah', 'Logisticien');

INSERT INTO produits (libelle, prix, stock) VALUES ('Ordinateur', 350000, 10), ('Imprimante', 85000, 15), ('Clavier', 12000, 30), ('Souris', 8000, 40), ('Routeur', 45000, 12);

INSERT INTO commandes (id_client, id_utilisateur, statut, montant_total) VALUES (1, 1, 'EN_ATTENTE', 374000), (2, 1, 'VALIDEE', 85000), (3, 2, 'EN_ATTENTE', 97000), (4, 3, 'VALIDEE', 366000), (5, 1, 'ANNULEE', 12000);

INSERT INTO lignes_commande (id_commande, id_produit, quantite, prix_unitaire) VALUES (1, 3, 2, 12000), (1, 4, 1, 8000), (1, 1, 1, 350000), (2, 2, 1, 85000), (3, 2, 1, 85000), (3, 4, 1, 8000), (3, 3, 1, 12000), (4, 1, 1, 350000), (4, 4, 2, 8000), (5, 3, 1, 12000);

INSERT INTO paiements (id_commande, montant, statut) VALUES (1, 200000, 'CONFIRME'), (2, 85000, 'CONFIRME'), (3, 50000, 'EN_ATTENTE'), (4, 366000, 'CONFIRME'), (5, 12000, 'REJETE');
```

### 4 : Administration des utilisateurs et des privileges

L'administrateur doit controler les acces a la base selon les responsabilites professionnelles.

#### Travail demandé

1. Créer les rôles PostgreSQL suivants :
   - role_commercial;
   - role_stock;
   - role_comptabilite;
   - role_logistique;
   - role_supervision.





2. Crer les comptes PostgreSQL suivants :
   - user_commercial;
   - user_stock;
   - user_compatible;
   - user_logistique;
   - user_superviseur.

3. Associer chaque compte au role correspondant.

4. Accorder les privileges necessaires a chaque fonction.

5. Tester au moins deux operations autorisees et une operation interdite.

6. Expliquer la difference entre un role PostgreSQL, un compte de connexion et un utilisateur fonctionnel enregistre dans la table utilisateurs.

7. Montrer comment retirer un privilege avec REVOKE.

Les comptes doivent respecter le principe du moindre privilege. Aucun compte fonctionnel ne doit recevoir le privilege SUPERUSER. La création des comptes et l'attribution des privileges doivent être effectuées avec un compte administrateur disposant des droits nécessaires.

### III. PARTIE COMMUNE : RECHERCHE SÉMANTIQUE AVEC PGVECTOR

Cette partie est obligatoire pour les huit groupes.

### 5 : Activation de l'extension pgector

L'entreprise souhaite rechercher des produits selon leur similarité semantique.

#### Travail demandé

1. Verifier que l'extension pgector est installe sur le serveur PostgreSQL.

2. Activer l'extension dans la base entreprise_tp.

3. Ajouter une colonne permettant de stocker les embeddings des produits.

4. Initialiser les vecteurs de démonstration.

5. Executer une recherche par similarité vectorielle.

6. Expliquer le rôle de l'extension et les limites de la démonstration.

#### 5.1. Activation de l'extension

```sql
CREATE EXTENSION IF NOT EXISTS vector;
```

#### 5.2. Ajout de la colonne vectorielle

```sql
ALTER TABLE produits ADD COLUMN embedding VECTOR(3);
```

Dans ce TP, chaque produit est représenté par un vecteur de trois dimensions.

#### 5.3. Initialisation des embeddings de démonstration

```sql
UPDATE produits SET embedding = CASE id_produit
  WHEN 1 THEN '0.90, 0.10, 0.10'::vector
  WHEN 2 THEN '0.80, 0.20, 0.10'::vector
  WHEN 3 THEN '0.10, 0.90, 0.10'::vector
  WHEN 4 THEN '0.10, 0.80, 0.20'::vector
  WHEN 5 THEN '0.70, 0.20, 0.20'::vector
END;
```





#### 5.4. Recherche des produits les plus proches

Exécuter la requête suivante :

```sql
SELECT id_produit, libelle, prix, stock, embedding <=> '[0.85, 0.15, 0.10]'::vector AS distance_cosinus
FROM produits
WHERE embedding IS NOT NULL
ORDER BY embedding <=> '[0.85, 0.15, 0.10]'::vector
LIMIT 3;
```

#### Questions

1. Quel est le rôle de pqvector ?
2. Quelle est la fonction de la colonne embedding ?
3. Que représente le vecteur fourni dans la requête ?
4. Que signifie l'opérateur `<=>` ?
5. Pourquoi les résultats sont-ils classés selon la distance calculée ?
6. Quelle est la différence entre une recherche par mots-cles avec LIKE et une recherche vectorielle ?
7. Pourquoi les vecteurs de trois dimensions utilisés ici ne suffisent pas à démontrer une véritable compréhension sémantique du langage naturel ?
8. Quel est le rôle du modèle d'intelligence artificielle dans la production des embeddings ?

### IV. MISSIONS SPECIALISÉES DES HUIT GROUPES

Chaque groupe réalise le module qui lui est attribué. Les missions s'appuient toutes sur la même base de données et sur la partie commune précédente.

#### GROUPE 1 : Gestion transactionnelle des commandes

##### Contexte

Un commercial enregistre une commande comportant plusieurs produits. La commande ne doit être validée que si toutes les opérations nécessaires sont exécutées correctement.

##### Travail demandé

1. Écrire une transaction permettant d'enregistrer une commande et ses lignes.
2. Vérifier la disponibilité des produits avant la validation.
3. Calculer le montant total à partir des lignes de commande.
4. Mettre à jour les stocks concernés.

5. Utiliser COMBAT si toutes les opérations réussissent et HOLDBACK en cas d'échec.
6. Écrire une requête avec jointures affichant les commandes, les clients, les produits et les quantités.
7. Écrire une sous-requête identifiant les commandes dont le montant dépasse le montant moyen des commandes.
8. Utiliser pvvector pour rechercher les produits les plus proches d'un produit demandé.
9. À partir des résultats de cette recherche, préparer une commande contenant un produit sélectionné.
10. Démontrer que si la transaction échoue, les modifications effectuées dans cette transaction sont annulées.





#### GROUPE 2 : Automatisation de la gestion des stocks

##### Contexte

L'entreprise souhaite automatiser les mouvements de stock afin de limiter les erreurs liées aux interventions manuelles.

##### Travail demandé

1. Créer un déclencheur qui met à jour le stock après l'insertion d'une ligne de commande.
2. Adapter le mécanisme au cas de la modification d'une quantité commandée.
3. Prévoir le cas de la suppression d'une ligne de commande.
4. Empêcher un stock négatif.
5. Tester les opérations dans une transaction.
6. Écrire une requête avec jointures affichant les produits et les quantités commandées.
7. Écrire une sous-requête identifiant les produits dont le stock est inférieur au stock moyen.
8. Utiliser pvvector pour rechercher des produits similaires à un produit donné.
9. Afficher les stocks des produits retournés par la recherche vectorielle.
10. Expliquer pourquoi deux produits similaires ne sont pas nécessairement interchangeables et pourquoi la similarité ne garantit pas leur disponibilité.

#### GROUPE 3 : Gestion transactionnelle des paiements

##### Contexte

Le service comptable enregistre les paiements des commandes. Une commande peut être réglée en plusieurs fois.

##### Travail demandé

1. Écrire une transaction permettant d'enregistrer un paiement.
2. Vérifier que le montant du paiement est positif.
3. Empêcher la confirmation d'un paiement qui dépasserait le montant restant dû.
4. Prévoir le cas d'un paiement rejeté.
5. Utiliser COMBAT et POLLBACK dans des situations appropriées.
6. Écrire une requête avec jointures affichant les commandes, les clients et les paiements.
7. Écrire une sous-requête permettant d'identifier les commandes dont les paiements confirmés restent inférieurs au montant total.
8. Utiliser pvvector pour rechercher des produits associés à une description textuelle transformée en embedding.





9. Combiner cette recherche avec des jointures permettant d'afficher les commandes contenant les produits retrouvés.
10. Expliquer pourquoi la recherche vectorielle n'effectue pas, à elle seule, la vérification compatible du paiement.

#### GROUPE 4 : Gestion de la concurrence sur les stocks

##### Contexte

Deux commerciaux tentent simultanément de commander le dernier exemplaire d'un produit. L'entreprise veut éviter que les deux commandes soient validées si le stock est insuffisant.

##### Travail demandé

1. Créer deux sessions PostgreSQL.
2. Simuler deux tentatives de commande concurrentes.
3. Observer le comportement sans verrouillage explicite.
4. Utiliser `SELECT ... FOR UPDATE` pour verrouiller la ligne du produit.
5. Comparer le comportement avec et sans verrouillage.
6. Expliquer le role de COMMIT et de ROLLBACK dans la libération des verrous.
7. Comparer READ COMMITTED et SERIALIZABLE sur un scenario adapté.
8. Ecrire une requête identifiant les produits dont le stock est inférieur au stock moyen.
9. Utiliser pgvector pour rechercher les produits similaires à un produit demandé.
10. Vérifier le stock d'un produit proposé comme alternative avant de préparer une commande.
11. Expliquer pourquoi une recherche vectorielle ne remplace ni le verrouillage ni la vérification du stock au moment de la validation.

#### GROUPE 5 : Niveaux d'isolation et cohérence des transactions

##### Contexte

Un comptable consulte les paiements d'une commande pendant qu'un autre utilisateur enregistre ou confirme un paiement. L'objectif est de comprendre comment les transactions concurrentes peuvent observer des états différents de la base.

##### Travail demandé

1. Ouvrir deux sessions PostgreSQL.
2. Effectuer des lectures et des modifications concurrentes sous READ COMMITTED.
3. Reexecuter les lectures et expliquer les résultats.
4. Recommencer sous REPEATABLE READ.
5. Construire un scenario adapté sous SERIALIZABLE.
6. Comparer les comportements observés.
7. Identifier les situations dans lesquelles un verrou explicite est nécessaire.
8. Ecrire une requête avec jointures affichant les commandes et leurs paiements confirmés.
9. Ecrire une sous-requête identifiant les commandes dont les paiements confirmés sont insuffisants.
10. Executer une recherche vectorielle dans une transaction, modifier un embedding depuis une autre session et observer la visibilité du changement selon le niveau d'isolation.
