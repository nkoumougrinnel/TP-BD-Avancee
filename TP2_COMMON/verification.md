# Partie Commune TP2 - Vérifier les Résultats

## Vérification des opérations selon la technologie

### MongoDB
```javascript
use universityDB;

// Vérification 1 : Après insertions
print("=== Vérification après insertions ===");
print("Nombre total d'étudiants : " + db.etudiants.countDocuments({}));
print("Nombre total d'UES : " + db.ue.countDocuments({}));

// Vérification 2 : Après mise à jour
print("\n=== Vérification après mise à jour ===");
var etudiant = db.etudiants.findOne({ matricule: "E2024001" });
print("Email de E2024001 : " + etudiant.email);
print("Filières de E2024002 : " + etudiant.filières.join(", "));

// Vérification 3 : Après suppression
print("\n=== Vérification après suppression ===");
print("Nombre d'étudiants restants : " + db.etudiants.countDocuments({}));
var list = db.etudiants.find({}, {matricule: 1, nom: 1, prenom: 1}).toArray();
print("Liste des matricules restants :");
list.forEach(function(e) {
  print("   - " + e.matricule + " : " + e.nom + " " + e.prenom);
});

// Vérification 4 : Compter par filière
print("\n=== Compte par filière ===");
var filières = [...new Set(db.etudiants.find({}, {filieres: 1}).toArray().flatMap(e => e.filieres))];
filières.forEach(function(f) {
  var count = db.etudiants.countDocuments({ filieres: f });
  print("   - " + f + " : " + count + " étudiant(s)");
});
```
