---
name: review-quick
description: Revue de code rapide et generale (lisibilite, style, evidences), utilisee par defaut par l'agent de review.
---

# Revue rapide

Role proprietaire : [review](../../agents/review.agent.md).

## Quand l'utiliser

Passe de surface sur le diff et son contexte immediat, sans risque particulier
identifie. Relever les signaux necessitant un axe specialise pour le role
proprietaire, sans reexecuter ici ses checklists.

## Checklist

- Le diff correspond exactement a l'intention annoncee, rien d'accidentel
  (fichiers oublies, code de debug, commentaires morts).
- Noms, structure et style coherents avec le reste du fichier/module.
- Pas de duplication evidente evitable avec le code existant a proximite.
- Erreurs et cas limites evidents geres, ou explicitement hors scope.
- Executer les checks pertinents disponibles ; si un check n'est pas lance,
  en donner la raison et signaler l'incertitude restante.

## Sortie attendue

Liste courte des findings de surface et des signaux a transmettre a un axe
specialise, ou absence de finding dans cette passe. Ne pas presenter ce resultat
comme une validation des axes non examines.
