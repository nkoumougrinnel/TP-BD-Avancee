#!/usr/bin/env mongosh
print("=== Task 6 : Mise à jour des informations étudiant ===");
print("1. Mise à jour de l'email de Jean Durand :");
db.etudiants.updateOne(
  { matricule: "E2024001" },
  { $set: { email: "jean.durand.nouveau@etudiant.univ.fr" } }
);
var updated = db.etudiants.findOne({ matricule: "E2024001" });
print("   ✅ Nouvel email : " + updated.email);
print("\n2. Mise à jour de la filière de Pierre Moreau :");
db.etudiants.updateOne(
  { matricule: "E2024003" },
  { $set: { filières: ["Gestion Internationale"] } }
);
var moreau = db.etudiants.findOne({ matricule: "E2024003" });
print("   ✅ Nouvelle filière : " + moreau.filières.join(", "));
print("\n3. Ajout numéro de téléphone à Marie Petit :");
db.etudiants.updateOne(
  { matricule: "E2024004" },
  { $set: { telephone: "+33 5 45 67 89 01" } }
);
var petit = db.etudiants.findOne({ matricule: "E2024004" });
print("   ✅ Téléphone ajouté : " + petit.telephone);
print("\n4. Mise à jour nested (coordonnées) :");
db.etudiants.updateOne(
  { matricule: "E2024005" },
  { $set: { "coordonnes.ville": "Bordeaux", "coordonnes.codePostal": "33000" } }
);
var thompson = db.etudiants.findOne({ matricule: "E2024005" });
print("   ✅ Nouvelle ville : " + thompson.coordonnes.ville + " (" + thompson.coordonnes.codePostal + ")");
print("\n5. Ajout certification suite mise à jour :");
db.etudiants.updateOne(
  { matricule: "E2024001" },
  { $push: { certifications: { nom: "Certification MongoDB", organisme: "MongoDB University", dateObtention: new Date() } } }
);
var durand = db.etudiants.findOne({ matricule: "E2024001" });
print("   ✅ Certifications maintenant : " + durand.certifications.length + " certificats");
print("\n6. Verification finale des modifications :");
print("   - Durand : " + db.etudiants.findOne({ matricule: "E2024001" }).email);
print("   - Moreau : " + db.etudiants.findOne({ matricule: "E2024003" }).filières);
print("   - Petit : " + db.etudiants.findOne({ matricule: "E2024004" }).telephone);
print("   - Thompson : " + db.etudiants.findOne({ matricule: "E2024005" }).coordonnes.ville);