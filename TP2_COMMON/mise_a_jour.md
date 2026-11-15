# Partie Commune TP2 - 1 Mise à Jour

## Exemple de mise à jour selon la technologie

### MongoDB
```javascript
use universityDB;

// Mise à jour 1 : Modifier l'email d'un étudiant
db.etudiants.updateOne(
  { matricule: "E2024001" },
  { $set: { email: "jean.durand.nouveau@univ.fr" } }
);
print("Email mis à jour pour E2024001");

// Mise à jour 2 : Ajouter une filière à un étudiant
db.etudiants.updateOne(
  { matricule: "E2024002" },
  { $addToSet: { filieres: "Mathématiques Avancées" } }
);
print("Filière ajoutée pour E2024002");

// Vérification
var updated = db.etudiants.findOne({ matricule: "E2024001" });
print("Nouvel email : " + updated.email);
```
