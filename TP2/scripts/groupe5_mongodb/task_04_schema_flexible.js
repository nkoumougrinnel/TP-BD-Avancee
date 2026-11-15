#!/usr/bin/env mongosh
print("=== Task 4 : Schéma flexible ===");
print("1. Ajout certification à Marie Petit :");
db.etudiants.updateOne(
  { matricule: "E2024004" },
  { $push: { certifications: { nom: "Certification AWS", organisme: "Amazon Web Services", dateObtention: "2024-06-01", niveau: "Associate" } } }
);
print("   ✅ Certification ajoutée");
print("\n2. Ajout stage à Robert Thompson :");
db.etudiants.updateOne(
  { matricule: "E2024005" },
  { $push: { stages: { entreprise: "DataScience Inc.", periode: "2024-01-15 to 2024-03-15", domaine: "Analyse de données", statut: "Terminé" } } }
);
print("   ✅ Stage ajouté");
print("\n3. Ajout coordonnées supplémentaires à Jean Durand :");
db.etudiants.updateOne(
  { matricule: "E2024001" },
  { $set: { "coordonnes.adresseSecondaire": "78 Boulevard de la Recherche", "coordonnes.codePostalSecondaire": "75001" } }
);
print("   ✅ Coordonnées ajoutées");
print("\n4. Illustration de la flexibilité schema :");
print("   - Durand (E2024001) : a des coordonnéesSecondaires");
print("   - Martin (E2024002) : a des certifications Mathématiques/Physique");
print("   - Moreau (E2024003) : pas de certifications ni de stages");
print("   - Petit (E2024004) : a des documentsJustificatifs");
print("   - Thompson (E2024005) : a des stages");
print("\n5. Vérification individuelle :");
db.etudiants.find({ matricule: "E2024001" }).forEach(function(e) {
  print("   " + e.matricule + " : certifications = " + e.certifications.length + ", stages = " + e.stages.length + ", docJustificatifs = " + e.documentsJustificatifs.length);
});
db.etudiants.find({ matricule: "E2024003" }).forEach(function(e) {
  print("   " + e.matricule + " : certifications = " + e.certifications.length + ", stages = " + e.stages.length + ", docJustificatifs = " + e.documentsJustificatifs.length);
});