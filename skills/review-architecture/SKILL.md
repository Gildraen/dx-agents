---
name: review-architecture
description: Revue de conception (couplage, responsabilites, contrats d'interface), a utiliser pour les changements touchant une interface partagee ou un decoupage de module.
---

# Revue architecture

Role proprietaire : [review](../../agents/review.agent.md).

## Quand l'utiliser

Changement qui modifie une interface partagee, deplace des responsabilites
entre modules, ou introduit une nouvelle abstraction/dependance
structurante.

Partir du diff et des interfaces touchees ; suivre leurs consommateurs pour
evaluer les contrats, sans refaire les autres axes de revue.

## Checklist

- Le changement respecte le contrat existant de l'interface touchee
  (signature, comportement, garanties), ou documente explicitement la
  rupture.
- Les responsabilites restent a l'endroit le plus logique (pas de logique
  metier fuitee dans une couche technique, ou l'inverse).
- Le couplage introduit est justifie; pas de dependance circulaire ni de
  nouvelle dependance forte evitable.
- La solution reste au niveau d'abstraction necessaire; pas de
  generalisation anticipee non demandee.
- Les impacts sur les autres consommateurs de l'interface sont identifies
  (recherche d'usages, pas seulement le point d'appel modifie).

## Sortie attendue

Findings centres sur les risques structurels et les impacts
multi-consommateurs, avec une alternative concrete si un point est bloquant.
