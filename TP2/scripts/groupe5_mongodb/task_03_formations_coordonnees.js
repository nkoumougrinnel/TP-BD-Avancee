#!/usr/bin/env mongosh
print("=== Task 3 : Représentation des formations et coordonnées ===");
print("📚 Étudiants et leurs formations :");
db.etudiants.find().forEach(function(etud) {
  print("   - " + etud.matricule + " : " + etud.nom + " " + etud.prenom + " | Filières : " + etud.filieres.join(", ") + " | Niveau : " + etud.niveau + " | Spécialité : " + (etud.specialité || "Non défini"));
});
print("📍 Coordonnées complètes :");
db.etudiants.find({}).forEach(function(etud) {
  print("   " + etud.matricule + " - " + etud.nom + " " + etud.prenom + " :");
  if (etud.coordonnes) {
    var c = etud.coordonnes;
    print("     Adresse : " + c.adresse);
    print("     Ville : " + c.ville + " (" + c.codePostal + ")");
    print("     Téléphone : " + etud.telephone);
  }
});
print("🔍 Étudiants en Informatique avec coordonnées :");
db.etudiants.find({ filières: "Informatique" }).forEach(function(etud) {
  print("   - " + etud.matricule + " : " + etud.coordonnes.ville);
});