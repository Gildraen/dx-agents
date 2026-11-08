---
name: review-performance
description: Revue de performance (complexite, requetes, allocations, chemins chauds), a utiliser pour les changements sur un chemin critique en volume ou en latence.
---

# Revue performance

Role proprietaire : [review](../../agents/review.agent.md).

## Quand l'utiliser

Changement sur un chemin frequemment execute (boucle chaude, requete
reseau/BDD, serialisation) ou sur un volume de donnees non borne.

Partir du chemin modifie, du volume attendu et des mesures disponibles ;
distinguer cout estime et regression mesuree.

## Checklist

- Complexite algorithmique adaptee au volume de donnees attendu (pas de
  N+1, pas de boucle imbriquee evitable).
- Requetes reseau/BDD groupees ou mises en cache quand c'est possible; pas
  d'appel repete evitable dans une boucle.
- Allocations et copies memoire evitees sur le chemin chaud quand une
  alternative simple existe.
- Pas de regression de latence/throughput introduite sans mesure ou
  justification.
- Toute limite connue (taille de payload, pagination, timeout) est
  respectee ou explicitement geree.

## Sortie attendue

Findings avec estimation de l'impact (frequence x cout) et alternative
concrete, pas seulement un signalement generique de lenteur possible.
