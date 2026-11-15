#!/usr/bin/env mongosh
print("=== Task 7 : Suppression contrôlée ===");
print("1. Suppression d'un étudiant de test par matricule :");
print("   Avant suppression : " + db.etudiants.countDocuments({}) + " étudiants");
var result = db.etudiants.deleteOne({ matricule: "E2024006" });
if (result.deletedCount > 0) {
  print("   ✅ Étudiant de test supprimé");
} else {
  print("   ℹ️  Aucun étudiant de test trouvé");
}
print("   Après suppression : " + db.etudiants.countDocuments({}) + " étudiants");
print("   Différence : " + (db.etudiants.countDocuments({}) - result.count) + " étudiant(s)");

print("\n2. Suppression par ObjectId (approche alternative) :");
var testStudent = db.etudiants.findOne({ nom: "Test", prenom: "Suppression" });
if (testStudent) {
  print("   ID trouvé : " + testStudent._id);
  var result2 = db.etudiants.deleteOne({ _id: testStudent._id });
  print("   ✅ Suppression par ID : " + result2.deletedCount + " document(s) supprimé(s)");
} else {
  print("   ℹ️  Aucun étudiant 'Test Suppression' trouvé");
}

print("\n3. État final de la collection etudiants :");
print("   Total étudiants : " + db.etudiants.countDocuments({}));
print("   Liste matricules :");
db.etudiants.find({}, { matricule: 1, nom: 1, prenom: 1 }).forEach(function(e) {
  print("     - " + e.matricule + " : " + e.nom + " " + e.prenom);
});

print("\n4. Résumé suppression :");
print("   - Operation ciblée par matricule ou _id");
print("   - Utiliser matricule pour la lisibilité");
print("   - Vérifier toujours après suppression avec countDocuments()");