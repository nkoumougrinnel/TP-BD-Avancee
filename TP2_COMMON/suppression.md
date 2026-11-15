# Partie Commune TP2 - 1 Suppression Contrôlée

## Exemple de suppression selon la technologie

### MongoDB
```javascript
use universityDB;

// Suppression 1 : Supprimer un étudiant de test par matricule
var beforeCount = db.etudiants.countDocuments({});
print("Avant suppression : " + beforeCount + " étudiants");

var result = db.etudiants.deleteOne({ matricule: "E2024006" });
if (result.deletedCount > 0) {
  print("✅ Étudiant E2024006 supprimé");
} else {
  print("ℹ️  Aucun étudiant E2024006 trouvé");
}

var afterCount = db.etudiants.countDocuments({});
print("Après suppression : " + afterCount + " étudiants");
print("Différence : " + (beforeCount - afterCount) + " étudiant(s)");

// Suppression 2 : Supprimer par ObjectId (approche alternative)
var testStudent = db.etudiants.findOne({ nom: "Test", prenom: "Suppression" });
if (testStudent) {
  print("Suppression par ID : " + testStudent._id);
  db.etudiants.deleteOne({ _id: testStudent._id });
  print("✅ Document supprimé par ObjectId");
} else {
  print("ℹ️  Aucun étudiant 'Test Suppression' trouvé");
}

// État final
print("Total étudiants restants : " + db.etudiants.countDocuments({}));
```
