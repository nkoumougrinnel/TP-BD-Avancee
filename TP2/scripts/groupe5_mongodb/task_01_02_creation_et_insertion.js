#!/usr/bin/env mongosh
use universityDB;
db.createCollection("etudiants");
db.etudiants.insertMany([]);
print("Task 1 & 2 created");
