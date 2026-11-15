#!/usr/bin/env mongosh
print("=== Task 5 : Recherche par filière ===");
print("1. Étudiants en Informatique :");
var infos = db.etudiants.find({ filières: "Informatique" }).toArray();
infos.forEach(function(e) {
  print("   - " + e.matricule + " : " + e.nom + " " + e.prenom + " (" + e.anneeEnture + ")");
});
print("\n2. Étudiants en Mathématiques :");
db.etudiants.find({ filières: "Mathématiques" }).forEach(function(e) {
  print("   - " + e.matricule + " : " + e.nom + " " + e.prenom);
});
print("\n3. Étudiants en Gestion OU Informatique :");
db.etudiants.find({ filières: { $in: ["Gestion", "Informatique"] } }).forEach(function(e) {
  print("   - " + e.matricule + " : " + e.nom + " " + e.prenom + " - Filières : " + e.filières.join(", "));
});
print("\n4. Recherche avancée ($or) :");
db.etudiants.find({
  $or: [
    { filières: "Physique" },
    { filières: "Gestion" }
  ]
}).forEach(function(e) {
  print("   - " + e.matricule + " : " + e.nom + " " + e.prenom + " - " + e.filières.join(", "));
});
print("\n5. Compte par filière :");
var filièresUnies = [...new Set(db.etudiants.find({}, { filieres: 1 }).toArray().flatMap(function(e) { return e.filieres; }))];
filièresUnies.forEach(function(f) {
  var count = db.etudiants.countDocuments({ filières: f });
  print("   - " + f + " : " + count + " étudiant(s)");
});