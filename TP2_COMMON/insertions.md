# Partie Commune TP2 - Au Moins 2 Insertions

## Exemples d'insertions selon la technologie

### MongoDB
```javascript
use universityDB;

// Insertion 1 : Nouvel étudiant
db.etudiants.insertOne({
  matricule: "E2024006",
  nom: "Sanchez",
  prenom: "Claudia",
  email: "claudia.sanchez@univ.fr",
  filieres: ["Data Science"],
  anneeEntree: 2024
});

// Insertion 2 : Nouvelle UE
db.ue.insertOne({
  code: "INFO201",
  titre: "Bases de Données Avancées",
  credits: 6,
  semestre: "Printemps"
});

// Vérification
print("Total étudiants : " + db.etudiants.countDocuments({}));
print("Total UEs : " + db.ue.countDocuments({}));
```
