# Partie Commune TP2 - Au Moins 2 Consultations

## Exemples de consultations selon la technologie

### MongoDB
```javascript
use universityDB;

// Consultation 1 : Récupérer un étudiant par matricule
var etudiant = db.etudiants.findOne({ matricule: "E2024001" });
print("Étudiant trouvé : " + etudiant.nom + " " + etudiant.prenom);

// Consultation 2 : Lister tous les étudiants d'une filière
print("--- Étudiants en Informatique ---");
var infos = db.etudiants.find({ filieres: "Informatique" }).toArray();
infos.forEach(function(e) {
  print("   - " + e.matricule + " : " + e.nom + " " + e.prenom);
});

// Alternative : Compter le nombre d'étudiants
print("Nombre total d'étudiants : " + db.etudiants.countDocuments({}));
```
