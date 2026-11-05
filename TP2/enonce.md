# PROJET : Conception et exploitation d'une plateforme de services universitaires avec les bases de données NoSQL (clé-valeur, orientées colonnes, documents et graphes)

**Niveau :** ITT3-IR
**Environnement technique proposé :** Redis, Cassandra, MongoDB et Neo4j

---

## 1. Contexte

Une université souhaite mettre en place une plateforme numérique permettant de centraliser et d'exploiter les informations relatives aux étudiants, aux enseignants, aux formations, aux unités d'enseignement, aux inscriptions, aux évaluations et aux activités pédagogiques.

La plateforme doit prendre en charge plusieurs services :

- la consultation rapide des informations d'un étudiant ;
- la gestion des dossiers étudiants ;
- le suivi des inscriptions aux unités d'enseignement ;
- la consultation des résultats académiques ;
- l'analyse des activités pédagogiques ;
- la recherche des relations entre étudiants, enseignants et formations ;
- la recommandation de ressources pédagogiques ;
- la détection de situations nécessitant une intervention administrative ou pédagogique.

L'université souhaite exploiter les quatre grands paradigmes NoSQL, pour répondre aux différents besoins de cette plateforme. L'objectif du projet est donc de concevoir et d'exploiter une base de données commune, puis de développer un module fonctionnel spécifique pour chacun des huit groupes.

---

## 1- Travail demandé à tous les groupes

1. Se connecter à son SGBD.
2. Créer les structures nécessaires à son module.
3. Importer les données communes qui lui sont utiles.
4. Effectuer au moins deux insertions.
5. Effectuer au moins deux consultations.
6. Effectuer une mise à jour.
7. Effectuer une suppression contrôlée.
8. Vérifier les résultats des opérations réalisées.

---

## 2. Travail spécifique à chaque groupe

### Groupe 1 : Redis : consultation rapide des dossiers étudiants

**Scénario**

Le service de scolarité reçoit de nombreuses demandes de consultation des informations des étudiants. Pour réduire les temps d'accès, l'université souhaite utiliser Redis comme système de stockage clé-valeur pour les informations fréquemment consultées.

**Travail demandé**

1. Créer une clé Redis pour chaque étudiant.
2. Enregistrer les informations essentielles d'au moins cinq étudiants.
3. Retrouver les informations d'un étudiant à partir de son identifiant.
4. Modifier la filière d'un étudiant.
5. Supprimer les données d'un étudiant.
6. Mettre en place une durée d'expiration pour une donnée temporaire.
7. Comparer l'accès direct par clé à une recherche nécessitant de parcourir plusieurs enregistrements.

---

### Groupe 2 : Redis : gestion des sessions et des inscriptions aux UE

**Scénario**

Pendant les inscriptions pédagogiques, l'université souhaite conserver temporairement les choix d'UE des étudiants et compter les demandes reçues pour chaque unité d'enseignement.

**Travail demandé**

1. Créer une structure représentant les choix d'UE d'un étudiant.
2. Enregistrer les choix de plusieurs étudiants.
3. Ajouter une UE à la liste des choix d'un étudiant.
4. Retirer une UE de cette liste.
5. Maintenir un compteur de demandes par UE.
6. Incrémenter le compteur lorsqu'un étudiant choisit une UE.
7. Simuler l'expiration d'une session d'inscription.
8. Expliquer comment éviter les incohérences entre les choix des étudiants et les compteurs.

---

### Groupe 3 : Cassandra : historique des activités pédagogiques

**Scénario**

La plateforme enregistre les consultations de ressources, les connexions, les téléchargements et les activités des étudiants. L'université souhaite conserver cet historique pour analyser l'utilisation de la plateforme.

**Travail demandé**

1. Créer un keyspace Cassandra.
2. Créer une table adaptée au stockage des activités.
3. Définir une clé primaire permettant de retrouver les activités d'un étudiant dans une période donnée.
4. Insérer plusieurs activités pour différents étudiants.
5. Afficher les activités d'un étudiant.
6. Afficher les activités d'un étudiant pour une période donnée.
7. Ajouter une nouvelle activité.
8. Expliquer pourquoi la modélisation de la table dépend des requêtes attendues.

---

### Groupe 4 : Cassandra : suivi des résultats académiques

**Scénario**

L'université souhaite consulter rapidement les résultats académiques par étudiant, par UE et par année universitaire. Les données doivent pouvoir être exploitées même lorsque le volume de résultats augmente.

**Travail demandé**

1. Concevoir une table Cassandra permettant de consulter les résultats d'un étudiant.
2. Définir une clé primaire adaptée à cette consultation.
3. Insérer les résultats de plusieurs étudiants.
4. Afficher les résultats d'un étudiant pour une année universitaire.
5. Concevoir une seconde table pour répondre à un besoin de consultation différent, par exemple les résultats d'une UE.
6. Insérer les données nécessaires dans les deux tables.
7. Comparer les deux modèles de stockage.
8. Expliquer pourquoi une même information peut être stockée dans plusieurs tables Cassandra.

---

### Groupe 5 : MongoDB : gestion des dossiers étudiants

**Scénario**

Les dossiers étudiants contiennent des informations variables selon les formations. Certains étudiants disposent de pièces justificatives supplémentaires, de certifications ou de stages à enregistrer. L'université souhaite utiliser MongoDB pour gérer ces dossiers sous forme de documents.

**Travail demandé**

1. Créer une base de données et une collection `etudiants`.
2. Insérer au moins cinq documents étudiants.
3. Représenter les informations de formation et les coordonnées dans les documents.
4. Ajouter des informations complémentaires à certains étudiants sans imposer les mêmes champs à tous.
5. Rechercher les étudiants d'une filière donnée.
6. Mettre à jour les informations d'un étudiant.
7. Supprimer un dossier de test.
8. Comparer l'intégration des informations dans un document à leur stockage dans plusieurs tables relationnelles.

---

### Groupe 6 : MongoDB : gestion des ressources pédagogiques

**Scénario**

Les enseignants déposent différents types de ressources : cours PDF, vidéos, exercices, liens externes et supports pratiques. Chaque ressource peut posséder des métadonnées différentes. L'université souhaite pouvoir rechercher les ressources selon leur type, leur UE, leur auteur ou leur niveau.

**Travail demandé**

1. Créer une collection `ressources`.
2. Insérer au moins huit ressources pédagogiques de types différents.
3. Associer chaque ressource à une ou plusieurs UE.
4. Rechercher les ressources d'une UE.
5. Rechercher les ressources selon leur type.
6. Modifier les métadonnées d'une ressource.
7. Utiliser une agrégation pour compter les ressources par type.
8. Expliquer comment les documents permettent de représenter des métadonnées hétérogènes.

---

### Groupe 7 : Neo4j : analyse des relations pédagogiques

**Scénario**

L'université souhaite comprendre les relations entre étudiants, formations, enseignants et unités d'enseignement. Elle souhaite notamment retrouver les étudiants qui suivent les mêmes UE et identifier les enseignants intervenant dans une formation.

**Travail demandé**

1. Créer les nœuds représentant les étudiants, les enseignants, les formations et les UE.
2. Créer les relations entre ces nœuds.
3. Afficher les UE suivies par un étudiant.
4. Rechercher les étudiants qui suivent au moins une UE commune.
5. Identifier les enseignants associés à une formation.
6. Rechercher les étudiants appartenant à une formation donnée.
7. Modifier une propriété d'un nœud.
8. Supprimer un nœud de test et gérer les relations associées.

---

### Groupe 8 : Neo4j : recommandation de ressources pédagogiques

**Scénario**

L'université souhaite proposer aux étudiants des ressources susceptibles de les aider dans leurs apprentissages. Par exemple, un étudiant qui suit l'UE « Bases de données NoSQL » pourrait recevoir des recommandations de ressources utilisées par d'autres étudiants inscrits à cette même UE.

**Travail demandé**

1. Créer les nœuds `Etudiant`, `UE` et `Ressource`.
2. Représenter les inscriptions aux UE.
3. Relier les UE aux ressources pédagogiques correspondantes.
4. Représenter les consultations de ressources par les étudiants.
5. Identifier les ressources consultées par les étudiants qui suivent une UE commune avec un étudiant donné.
6. Exclure des résultats les ressources déjà consultées par cet étudiant.
7. Afficher les recommandations avec le titre et le type de chaque ressource.
8. Expliquer les limites de cette méthode de recommandation.
