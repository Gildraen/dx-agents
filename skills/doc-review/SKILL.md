---
name: doc-review
description: 'Relire et auditer un document Markdown existant (README, guide, reference) pour signaler les informations fausses, obsoletes, ambigues ou incompletes ; utilise par l''agent de documentation pour toute relecture sans intention de reecrire.'
---

# Relecture de documentation

Role proprietaire : [documentation](../../agents/documentation.agent.md).

## Quand l'utiliser

Utiliser ce skill pour auditer un document Markdown existant : verifier son
exactitude, sa completude et sa clarte sans le reecrire soi-meme.

Ne pas l'utiliser pour creer ou restructurer un document ; utiliser
`doc-write` pour cela, en s'appuyant eventuellement sur les findings produits
ici.

## Procedure

1. Partir du document cible, de son public et de son objectif ; relever les
   parcours que le lecteur doit pouvoir suivre.
2. Associer les affirmations du document aux contrats sources correspondants
   et reperer les etapes manquantes dans les parcours retenus.
3. Relever en priorite les informations fausses, incompletes, ambigues,
   obsoletes ou impossibles a suivre, chacune avec une preuve (fichier,
   commande ou comportement observe) et une correction proposee.
4. Relier chaque finding au passage concerne et au parcours rendu incorrect
   ou incomplet. Transmettre les corrections retenues a `doc-write` si une
   mise a jour est demandee ; la relecture s'arrete aux findings.

## Sortie attendue

Liste des findings par severite avec preuve et correction proposee, suivie
des points positifs et des limites restantes de la revue.
