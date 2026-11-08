---
name: evolution-migration
description: 'Conduire une refactorisation vers une structure plus dynamique avec analyse des consommateurs, compatibilite, migration progressive et validation des effets de bord.'
---

# Evolution migration

Role proprietaire : [evolution](../../agents/evolution.agent.md).

## Quand l'utiliser

Utiliser ce skill lorsqu'une refactorisation dynamique modifie une interface,
un chemin de decouverte, une configuration partagee ou une convention utilisee
par plusieurs consommateurs.

Pour une refactorisation locale sans migration ni consommateur externe,
utiliser plutot `evolution-discovery` ou `evolution-config`.

Entree : contrats actuel/cible et consommateurs identifies. Ce skill organise
leur transition ; il ne redecide pas le mecanisme de configuration ou de
decouverte deja retenu.

## Procedure

1. Cartographier l'interface actuelle, ses producteurs, ses consommateurs,
   ses tests et ses exemples documentes.
2. Definir le contrat cible et classer les changements : transparents,
   compatibles avec avertissement ou necessitant une migration.
3. Introduire la nouvelle voie derriere un comportement par defaut compatible
   ou un adaptateur temporaire lorsque cela reduit le risque.
4. Migrer les consommateurs par groupes coherents et supprimer les anciennes
   branches seulement lorsque leur absence est verifiee.
5. Ajouter des tests de compatibilite, de migration, d'erreur et de retour
   arriere lorsque ce dernier est supporte.
6. Mettre a jour la documentation, les exemples et les contrats de validation,
   puis noter la date ou la condition de suppression de la compatibilite.

## Criteres de qualite

- Tous les consommateurs identifies ont une voie de migration explicite.
- La nouvelle convention est testee avant la suppression de l'ancienne.
- Les erreurs de migration sont detectables et actionnables.

## Sortie attendue

Indiquer les consommateurs examines, le contrat avant/apres, la strategie de
migration, les compatibilites temporaires, les validations executees et les
risques restants.
