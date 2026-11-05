-- ============================================================
-- TP : ADMINISTRATION POSTGRESQL
-- PARTIE COMMUNE AUX 8 GROUPES
-- Base : entreprise_tp
-- Extension : pgvector
-- ============================================================

-- ============================================================
-- 1. CREATION DE LA BASE DE DONNEES
-- ============================================================

SELECT 'CREATE DATABASE entreprise_tp'
WHERE NOT EXISTS (
    SELECT FROM pg_database
    WHERE datname = 'entreprise_tp'
)
;

-- ============================================================
-- 2. ACTIVATION DE PGVECTOR
-- ============================================================

-- Attention : pgvector doit être préalablement installé
-- sur le serveur PostgreSQL.

CREATE EXTENSION IF NOT EXISTS vector;


-- ============================================================
-- 3. CREATION DES TABLES
-- ============================================================

-- TABLE CLIENTS

CREATE TABLE IF NOT EXISTS clients (
    id_client SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    ville VARCHAR(100),
    email VARCHAR(150) UNIQUE
);


-- TABLE UTILISATEURS FONCTIONNELS

CREATE TABLE IF NOT EXISTS utilisateurs (
    id_utilisateur SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    fonction VARCHAR(50) NOT NULL,
    actif BOOLEAN DEFAULT TRUE
);


-- TABLE PRODUITS

CREATE TABLE IF NOT EXISTS produits (
    id_produit SERIAL PRIMARY KEY,
    libelle VARCHAR(100) NOT NULL,
    prix NUMERIC(12,2) NOT NULL CHECK (prix >= 0),
    stock INTEGER NOT NULL CHECK (stock >= 0),
    embedding VECTOR(3)
);


-- TABLE COMMANDES

CREATE TABLE IF NOT EXISTS commandes (
    id_commande SERIAL PRIMARY KEY,

    id_client INTEGER NOT NULL
        REFERENCES clients(id_client),

    id_utilisateur INTEGER
        REFERENCES utilisateurs(id_utilisateur),

    date_commande TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    statut VARCHAR(20) NOT NULL DEFAULT 'EN_ATTENTE'
        CHECK (
            statut IN (
                'EN_ATTENTE',
                'VALIDEE',
                'ANNULEE',
                'EXPEDIEE',
                'LIVREE'
            )
        ),

    montant_total NUMERIC(12,2) NOT NULL
        CHECK (montant_total >= 0)
);


-- TABLE LIGNES_COMMANDE

CREATE TABLE IF NOT EXISTS lignes_commande (
    id_ligne SERIAL PRIMARY KEY,

    id_commande INTEGER NOT NULL
        REFERENCES commandes(id_commande),

    id_produit INTEGER NOT NULL
        REFERENCES produits(id_produit),

    quantite INTEGER NOT NULL CHECK (quantite > 0),

    prix_unitaire NUMERIC(12,2) NOT NULL
        CHECK (prix_unitaire >= 0)
);


-- TABLE PAIEMENTS

CREATE TABLE IF NOT EXISTS paiements (
    id_paiement SERIAL PRIMARY KEY,

    id_commande INTEGER NOT NULL
        REFERENCES commandes(id_commande),

    montant NUMERIC(12,2) NOT NULL CHECK (montant > 0),

    date_paiement TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    statut VARCHAR(20) NOT NULL
        CHECK (
            statut IN (
                'EN_ATTENTE',
                'CONFIRME',
                'REJETE'
            )
        )
);


-- ============================================================
-- 4. INSERTION DES DONNEES COMMUNES
-- ============================================================

-- CLIENTS

INSERT INTO clients (nom, ville, email)
SELECT *
FROM (
    VALUES
    ('Alice', 'Yaounde', 'alice@example.com'),
    ('Boris', 'Douala', 'boris@example.com'),
    ('Carine', 'Bafoussam', 'carine@example.com'),
    ('David', 'Garoua', 'david@example.com'),
    ('Estelle', 'Yaounde', 'estelle@example.com')
) AS donnees(nom, ville, email)
WHERE NOT EXISTS (
    SELECT 1 FROM clients
);


-- UTILISATEURS

INSERT INTO utilisateurs (nom, fonction)
SELECT *
FROM (
    VALUES
    ('Paul', 'Commercial'),
    ('Marie', 'Responsable stock'),
    ('Jean', 'Comptable'),
    ('Sarah', 'Logisticien')
) AS donnees(nom, fonction)
WHERE NOT EXISTS (
    SELECT 1 FROM utilisateurs
);


-- PRODUITS

INSERT INTO produits (libelle, prix, stock)
SELECT *
FROM (
    VALUES
    ('Ordinateur', 350000, 10),
    ('Imprimante', 85000, 15),
    ('Clavier', 12000, 30),
    ('Souris', 8000, 40),
    ('Routeur', 45000, 12)
) AS donnees(libelle, prix, stock)
WHERE NOT EXISTS (
    SELECT 1 FROM produits
);


-- COMMANDES

INSERT INTO commandes
(id_client, id_utilisateur, statut, montant_total)

SELECT *
FROM (
    VALUES
    (1, 1, 'EN_ATTENTE', 382000),
    (2, 1, 'VALIDEE', 85000),
    (3, 2, 'EN_ATTENTE', 105000),
    (4, 3, 'VALIDEE', 366000),
    (5, 1, 'ANNULEE', 12000)
) AS donnees(id_client, id_utilisateur, statut, montant_total)

WHERE NOT EXISTS (
    SELECT 1 FROM commandes
);


-- LIGNES DE COMMANDES

INSERT INTO lignes_commande
(id_commande, id_produit, quantite, prix_unitaire)

SELECT *
FROM (
    VALUES
    (1, 3, 2, 12000),
    (1, 4, 1, 8000),
    (1, 1, 1, 350000),
    (2, 2, 1, 85000),
    (3, 2, 1, 85000),
    (3, 4, 1, 8000),
    (3, 3, 1, 12000),
    (4, 1, 1, 350000),
    (4, 4, 2, 8000),
    (5, 3, 1, 12000)
) AS donnees(id_commande, id_produit, quantite, prix_unitaire)

WHERE NOT EXISTS (
    SELECT 1 FROM lignes_commande
);


-- PAIEMENTS

INSERT INTO paiements (id_commande, montant, statut)

SELECT *
FROM (
    VALUES
    (1, 200000, 'CONFIRME'),
    (2, 85000, 'CONFIRME'),
    (3, 50000, 'EN_ATTENTE'),
    (4, 366000, 'CONFIRME'),
    (5, 12000, 'REJETE')
) AS donnees(id_commande, montant, statut)

WHERE NOT EXISTS (
    SELECT 1 FROM paiements
);


-- ============================================================
-- 5. CREATION DES ROLES POSTGRESQL
-- ============================================================

DO $$
BEGIN

    IF NOT EXISTS (
        SELECT FROM pg_roles WHERE rolname = 'role_commercial'
    ) THEN
        CREATE ROLE role_commercial NOLOGIN;
    END IF;

    IF NOT EXISTS (
        SELECT FROM pg_roles WHERE rolname = 'role_stock'
    ) THEN
        CREATE ROLE role_stock NOLOGIN;
    END IF;

    IF NOT EXISTS (
        SELECT FROM pg_roles WHERE rolname = 'role_comptabilite'
    ) THEN
        CREATE ROLE role_comptabilite NOLOGIN;
    END IF;

    IF NOT EXISTS (
        SELECT FROM pg_roles WHERE rolname = 'role_logistique'
    ) THEN
        CREATE ROLE role_logistique NOLOGIN;
    END IF;

    IF NOT EXISTS (
        SELECT FROM pg_roles WHERE rolname = 'role_supervision'
    ) THEN
        CREATE ROLE role_supervision NOLOGIN;
    END IF;

END $$;


-- ============================================================
-- 6. CREATION DES COMPTES DE CONNEXION
-- ============================================================

-- Remplacer ces mots de passe avant utilisation réelle.

DO $$
BEGIN

    IF NOT EXISTS (
        SELECT FROM pg_roles WHERE rolname = 'user_commercial'
    ) THEN
        CREATE USER user_commercial
        WITH PASSWORD 'Commercial_TP_2026';
    END IF;

    IF NOT EXISTS (
        SELECT FROM pg_roles WHERE rolname = 'user_stock'
    ) THEN
        CREATE USER user_stock
        WITH PASSWORD 'Stock_TP_2026';
    END IF;

    IF NOT EXISTS (
        SELECT FROM pg_roles WHERE rolname = 'user_comptabilite'
    ) THEN
        CREATE USER user_comptabilite
        WITH PASSWORD 'Comptabilite_TP_2026';
    END IF;

    IF NOT EXISTS (
        SELECT FROM pg_roles WHERE rolname = 'user_logistique'
    ) THEN
        CREATE USER user_logistique
        WITH PASSWORD 'Logistique_TP_2026';
    END IF;

    IF NOT EXISTS (
        SELECT FROM pg_roles WHERE rolname = 'user_superviseur'
    ) THEN
        CREATE USER user_superviseur
        WITH PASSWORD 'Supervision_TP_2026';
    END IF;

END $$;


-- ============================================================
-- 7. ASSOCIATION DES COMPTES AUX ROLES
-- ============================================================

GRANT role_commercial TO user_commercial;

GRANT role_stock TO user_stock;

GRANT role_comptabilite TO user_comptabilite;

GRANT role_logistique TO user_logistique;

GRANT role_supervision TO user_superviseur;


-- ============================================================
-- 8. PRIVILEGES GENERAUX
-- ============================================================

GRANT CONNECT ON DATABASE entreprise_tp TO
role_commercial,
role_stock,
role_comptabilite,
role_logistique,
role_supervision;

GRANT USAGE ON SCHEMA public TO
role_commercial,
role_stock,
role_comptabilite,
role_logistique,
role_supervision;


-- ============================================================
-- 9. PRIVILEGES DU COMMERCIAL
-- ============================================================

GRANT SELECT ON clients, produits, commandes,
lignes_commande TO role_commercial;

GRANT INSERT ON commandes, lignes_commande
TO role_commercial;

GRANT USAGE, SELECT ON SEQUENCE
commandes_id_commande_seq,
lignes_commande_id_ligne_seq
TO role_commercial;


-- ============================================================
-- 10. PRIVILEGES DU GESTIONNAIRE DE STOCK
-- ============================================================

GRANT SELECT ON produits, lignes_commande
TO role_stock;

GRANT UPDATE (stock) ON produits
TO role_stock;


-- ============================================================
-- 11. PRIVILEGES DU COMPTABLE
-- ============================================================

GRANT SELECT ON commandes, paiements
TO role_comptabilite;

GRANT INSERT ON paiements
TO role_comptabilite;

GRANT UPDATE (statut) ON paiements
TO role_comptabilite;

GRANT USAGE, SELECT ON SEQUENCE
paiements_id_paiement_seq
TO role_comptabilite;


-- ============================================================
-- 12. PRIVILEGES DU LOGISTICIEN
-- ============================================================

GRANT SELECT ON clients, produits,
commandes, lignes_commande
TO role_logistique;

GRANT UPDATE (statut) ON commandes
TO role_logistique;


-- ============================================================
-- 13. PRIVILEGES DU SUPERVISEUR
-- ============================================================

GRANT SELECT ON ALL TABLES IN SCHEMA public
TO role_supervision;


-- ============================================================
-- 14. INITIALISATION DES EMBEDDINGS
-- ============================================================

UPDATE produits

SET embedding = CASE id_produit

    WHEN 1 THEN '[0.90, 0.10, 0.10]'::vector

    WHEN 2 THEN '[0.80, 0.20, 0.10]'::vector

    WHEN 3 THEN '[0.10, 0.90, 0.10]'::vector

    WHEN 4 THEN '[0.10, 0.80, 0.20]'::vector

    WHEN 5 THEN '[0.70, 0.20, 0.20]'::vector

END

WHERE id_produit BETWEEN 1 AND 5
AND embedding IS NULL;


-- ============================================================
-- 15. RECHERCHE SEMANTIQUE
-- ============================================================

SELECT
    id_produit,
    libelle,
    prix,
    stock,

    embedding <=> '[0.85, 0.15, 0.10]'::vector
    AS distance_cosinus

FROM produits

WHERE embedding IS NOT NULL

ORDER BY embedding <=> '[0.85, 0.15, 0.10]'::vector

LIMIT 3;


-- ============================================================
-- 16. VERIFICATIONS FINALES
-- ============================================================

-- Vérification des tables


-- Vérification des rôles et comptes


-- Nombre d'enregistrements

SELECT 'clients' AS table_name, COUNT(*) AS total
FROM clients

UNION ALL

SELECT 'utilisateurs', COUNT(*) FROM utilisateurs

UNION ALL

SELECT 'produits', COUNT(*) FROM produits

UNION ALL

SELECT 'commandes', COUNT(*) FROM commandes

UNION ALL

SELECT 'lignes_commande', COUNT(*) FROM lignes_commande

UNION ALL

SELECT 'paiements', COUNT(*) FROM paiements;


-- Vérification des embeddings

SELECT id_produit, libelle, embedding
FROM produits
ORDER BY id_produit;


-- Vérification de l'extension

SELECT extname, extversion
FROM pg_extension
WHERE extname = 'vector';


-- Vérification de la cohérence des commandes

SELECT
    c.id_commande,
    c.montant_total,
    SUM(l.quantite * l.prix_unitaire) AS montant_calcule

FROM commandes c

JOIN lignes_commande l
ON c.id_commande = l.id_commande

GROUP BY c.id_commande, c.montant_total

ORDER BY c.id_commande;


-- ============================================================
-- FIN DE LA PARTIE COMMUNE
-- ============================================================
