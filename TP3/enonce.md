# PROJET D’ANALYSE DE DONNÉES SOUS RSTUDIO

*ACP normée • AFC • Intelligence artificielle • Classification et prédiction*

Classe : ITT3-IR
Examinateur : M. SASSA Giquel

---

## 1. Contexte

La société fictive CamerDigital, opérateur camerounais de services numériques, souhaite mieux comprendre les usages de ses clients. Elle veut identifier des profils de consommation, étudier les liens entre catégories socioprofessionnelles et satisfaction, puis utiliser les résultats pour améliorer ses offres. Le service d’analyse dispose d’un échantillon synthétique de 120 clients. Les données sont fictives et conçues à des fins pédagogiques : elles ne représentent pas les clients réels d’un opérateur.

## 2. Objectifs pédagogiques

- Importer et contrôler un jeu de données dans RStudio.
- Réaliser une ACP normée sur les variables quantitatives et interpréter axes, contributions et représentations.
- Réaliser une AFC à partir d’un tableau de contingence de variables qualitatives.
- Associer l’ACP à K-means pour regrouper les clients dans l’espace factoriel.
- Associer l’AFC à K-means pour regrouper les modalités représentées dans l’espace factoriel.
- Justifier les choix de préparation, de dimensionnement et d’interprétation, sans confondre association et causalité.

## 3. Jeu de données commun

le jeu_donnees_clients_telecom.csv. contient 120 lignes et 12 colonnes. Quelques valeurs manquantes ont été introduites volontairement afin de permettre un exercice de contrôle qualité.

**Remarque méthodologique** : l’ACP est réalisée sur les variables quantitatives.

L’AFC nécessite un tableau de contingence; elle n’est pas appliquée directement à l’ensemble des colonnes mixtes. Dans ce TP, le tableau principal croise Categorie_socioprofessionnelle et Satisfaction.

## 4. Mise en route dans RStudio

1. Créer un dossier de travail et y placer le CSV et le script R fourni. 2. Ouvrir le script dans RStudio. 3. Installer les packages une seule fois, si nécessaire. 4. Importer les données et vérifier les types, les dimensions et les valeurs manquantes.

```r
install.packages(c("FactoMineR","factoextra","cluster","dplyr","ggplot2","rpart"))
```

```r
donnees <- read.csv("jeu_donnees_clients_telecom.csv", na.strings = c("", "NA"))

dim(donnees); str(donnees); summary(donnees); colSums(is.na(donnees));
sum(duplicated(donnees))
```

---

## 5. Questions communes obligatoires (à réaliser par les huit groupes)

### Partie A : ACP normée

1. A1. Sélectionner les sept variables quantitatives et exclure l’identifiant.
2. A2. Contrôler les valeurs manquantes et décrire la stratégie retenue pour les traiter.
3. A3. Réaliser une ACP normée. Pourquoi faut-il centrer-réduire les variables dans ce cas ?
4. A4. Présenter les valeurs propres et la variance expliquée par chaque axe. Combien d’axes retenez-vous et pourquoi ?
5. A5. Interpréter le cercle des corrélations, les contributions et les cos².
6. A6. Décrire la projection des individus et les éventuelles oppositions entre profils.
7. A7. Donner deux conclusions opérationnelles, en précisant les limites de l’interprétation.

Commandes de départ :

```r
X <- donnees_prep[, vars_quant]; res_acp <- PCA(X, scale.unit=TRUE, graph=FALSE); print(res_acp$eig); fviz_eig(res_acp); fviz_pca_var(res_acp, col.var="contrib", repel=TRUE); fviz_pca_ind(res_acp, repel=FALSE).
```

### Partie B : AFC

8. B1. Construire le tableau de contingence Catégorie socioprofessionnelle × Satisfaction.
9. B2. Calculer les profils lignes et colonnes. Que représentent-ils ?
10. B3. Réaliser l’AFC et examiner l’inertie expliquée.
11. B4. Interpréter les axes et la carte factorielle : quelles modalités sont associées ou opposées ?
12. B5. Vérifier que l’interprétation tient compte des effectifs et de la qualité de représentation.
13. B6. Formuler une conclusion prudente : une association observée ne démontre pas une causalité.

Commandes de départ :

```r
tab_afc <- table(donnees_prep$Categorie_socioprofessionnelle, donnees_prep$Satisfaction); res_afc <- CA(tab_afc, graph=FALSE); print(res_afc$eig); fviz_ca_biplot(res_afc, repel=TRUE).
```

### Partie C : ACP + intelligence artificielle

14. C1. Extraire les coordonnées des clients sur les deux premiers axes retenus.
15. C2. Appliquer K-means aux coordonnées factorielles, avec plusieurs initialisations.
16. C3. Étudier k de 2 à 6 à l’aide de la silhouette moyenne et justifier le nombre de groupes choisi.
17. C4. Visualiser les groupes et comparer leurs moyennes sur les variables initiales.
18. C5. Nommer les profils obtenus en s’appuyant sur les résultats, sans inventer de caractéristiques.

**Attention** : les coordonnées utilisées ici sont celles des clients. K-means ne doit pas recevoir l’identifiant comme variable.

### Partie D : AFC + intelligence artificielle

19. D1. Reprendre l’AFC du tableau Catégorie socioprofessionnelle × Satisfaction.
20. D2. Extraire les coordonnées factorielles des modalités-lignes (catégories socioprofessionnelles).
21. D3. Appliquer K-means aux coordonnées des modalités et afficher l’appartenance de chaque catégorie à un groupe.
22. D4. Interpréter les regroupements en revenant au tableau de contingence et aux coordonnées.
23. D5. Expliquer ce que l’algorithme ajoute à l’AFC et quelles informations sont perdues en réduisant l’analyse aux deux premiers axes.

Dans la correction proposée, la classification porte explicitement sur les modalités-lignes de l’AFC, donc sur les catégories socioprofessionnelles. Il est possible d’étudier les modalités-colonnes séparément, mais il ne faut pas mélanger sans précaution des coordonnées issues de deux ensembles de modalités.

---

## 6. Modules complémentaires spécifiques

### Groupe 1 : Qualité et préparation des données

- Quantifier les valeurs manquantes par variable.
- Rechercher les doublons et repérer des valeurs atypiques avec des graphiques adaptés.
- Comparer les résultats avant et après une stratégie d’imputation justifiée.

### Groupe 2 : Interprétation approfondie de l’ACP

- Classer les variables selon leur contribution aux axes retenus.
- Examiner les cos² des variables et des individus.
- Identifier les interprétations robustes et celles qui doivent rester prudentes.

### Groupe 3 : Profilage des clients

- Décrire les groupes ACP–K-means à partir des variables d’origine.
- Présenter un tableau de moyennes ou médianes par groupe.
- Proposer une offre adaptée à chaque profil identifié.

### Groupe 4 : Prédiction de la satisfaction

- Construire un arbre de décision pour prédire Satisfaction.
- Séparer les données en apprentissage et test avant l’ajustement.
- Présenter la matrice de confusion, l’exactitude et les limites liées à la taille de l’échantillon.

### Groupe 5 : Évaluation de la classification

- Calculer la silhouette moyenne pour plusieurs valeurs de k.
- Examiner la taille des groupes et leur interprétabilité.
- Discuter la sensibilité de K-means à l’initialisation et à la représentation factorielle.

### Groupe 6 : Visualisation

- Produire des graphiques lisibles et correctement titrés pour l’ACP, l’AFC et K-means.
- Choisir des couleurs et légendes compréhensibles.
- Rédiger un commentaire interprétatif pour chaque figure.

### Groupe 7 : Associations entre variables qualitatives

- Étudier d’autres tableaux de contingence, par exemple Ville × Type_abonnement.
- Comparer les profils et réaliser une AFC sur un tableau alternatif.
- Comparer les conclusions à celles de l’AFC commune.

### Groupe 8 : Aide à la décision

- Synthétiser les résultats des quatre analyses communes.
- Proposer trois recommandations opérationnelles argumentées par les résultats.
- Préciser les limites des données et les analyses complémentaires nécessaires.
