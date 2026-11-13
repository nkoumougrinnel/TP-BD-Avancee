
### 4 : Administration des utilisateurs et des privileges

L'administrateur doit controler les acces a la base selon les responsabilites professionnelles.

#### Travail demandé

1. Créer les rôles PostgreSQL suivants :
   - role_commercial;
   - role_stock;
   - role_comptabilite;
   - role_logistique;
   - role_supervision.


\c entreprise_tp postgres

CREATE ROLE role_commercial   NOLOGIN;
CREATE ROLE role_stock        NOLOGIN;
CREATE ROLE role_comptabilite NOLOGIN;
CREATE ROLE role_logistique   NOLOGIN;
CREATE ROLE role_supervisor  NOLOGIN;


2. Crer les comptes PostgreSQL suivants :
   - user_commercial;
   - user_stock;
   - user_compatible;
   - user_logistique;
   - user_superviseur.

CREATE USER user_commercial   WITH PASSWORD 'Commercial#2026' NOSUPERUSER;
CREATE USER user_stock        WITH PASSWORD 'Stock#2026'      NOSUPERUSER;
CREATE USER user_comptabilite WITH PASSWORD 'Compta#2026'     NOSUPERUSER;
CREATE USER user_logistique   WITH PASSWORD 'Logistique#2026' NOSUPERUSER;
CREATE USER user_superviseur  WITH PASSWORD 'Superviseur#2026' NOSUPERUSER;  

3. Associer chaque compte au role correspondant.

GRANT role_commercial   TO user_commercial;
GRANT role_stock        TO user_stock;
GRANT role_comptabilite TO user_comptabilite;
GRANT role_logistique   TO user_logistique;
GRANT role_supervisor  TO user_superviseur;

4. Accorder les privileges necessaires a chaque fonction.


GRANT USAGE ON SCHEMA public TO role_commercial, role_stock,
  role_comptabilite, role_logistique, role_supervision;

// les privileges pour le role commercial.

GRANT SELECT, INSERT, UPDATE ON clients, commandes, lignes_commande TO role_commercial;
GRANT SELECT ON produits TO role_commercial;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO role_commercial;

// ceux du role stock.

GRANT SELECT, UPDATE ON produits TO role_stock;
GRANT SELECT ON commandes, lignes_commande TO role_stock;

// ceux du role  comptabilite

GRANT SELECT, INSERT, UPDATE ON paiements TO role_comptabilite;
GRANT SELECT ON commandes, clients TO role_comptabilite;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO role_comptabilite;

// ceux du role logistique

GRANT SELECT ON commandes, clients, lignes_commande, produits TO role_logistique;
GRANT UPDATE (statut) ON commandes TO role_logistique;

// ceux du role supervisor. lecture sur toutes les tables slm.

GRANT SELECT ON ALL TABLES IN SCHEMA public TO role_supervisor;

5. Tester au moins deux operations autorisees et une operation interdite.
SET ROLE user_commercial;

// permission  autorisée ici  : lire les produits

SELECT libelle, prix, stock FROM produits;

// permission encore autorisée dans ce cas : créer une commande

INSERT INTO commandes (id_client, id_utilisateur, statut, montant_total)
VALUES (1, 1, 'EN_ATTENTE', 12000);

// permission refusee il ne peut pas supprimer. msg "ERREUR : permission denied for table paiements"

DELETE FROM paiements WHERE id_paiement = 1;

RESET ROLE;

6. Expliquer la difference entre un role PostgreSQL, un compte de connexion et un utilisateur fonctionnel enregistre dans la table utilisateurs.

.Rôle PostgreSQL : un groupe de droits (ex : role_commercial). Il dit ce qu’on a le droit de faire.
.Compte de connexion : un rôle avec LOGIN et un mot de passe (ex : user_commercial). C’est lui qui se connecte au serveur.
.Utilisateur fonctionnel : une simple ligne dans la table utilisateurs (ex : Paul, Commercial). C’est une donnée de l’application. PostgreSQL ne s’en sert pas pour gérer les accès

7. Montrer comment retirer un privilege avec REVOKE.

// Le commercial ne peut plus modifier les clients par exemple

REVOKE UPDATE ON clients FROM role_commercial;

// Vérification

SET ROLE user_commercial. ERREUR AFFICHEE : permission denied for table clients;
UPDATE clients SET ville = 'Douala' WHERE id_client = 1;

RESET ROLE;

Les comptes doivent respecter le principe du moindre privilege. Aucun compte fonctionnel ne doit recevoir le privilege SUPERUSER. La création des comptes et l'attribution des privileges doivent être effectuées avec un compte administrateur disposant des droits nécessaires.