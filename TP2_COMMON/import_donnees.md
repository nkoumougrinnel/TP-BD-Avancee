# Partie Commune TP2 - Import de Données Communes

## Import d'exemples de données selon la technologie

### MongoDB
```javascript
use universityDB;

// Import since JSON file (adapt the path)
db.etudiants.insertMany([
  {
    matricule: "E2024001",
    nom: "Durand",
    prenom: "Jean",
    email: "jean.durand@univ.fr",
    filieres: ["Informatique"],
    anneeEntree: 2023
  },
  {
    matricule: "E2024002",
    nom: "Martin", 
    prenom: "Sophie",
    email: "sophie.martin@univ.fr",
    filieres: ["Mathématiques"],
    anneeEntree: 2022
  }
]);

// Vérification
print("Nombre d'étudiants importés : " + db.etudiants.countDocuments({}));
```
