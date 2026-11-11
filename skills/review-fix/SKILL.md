---
name: review-fix
description: Verifier, challenger et corriger les findings d'une revue de code avec une preuve independante avant tout correctif.
---

# Revue - correction des findings

Role proprietaire : [review](../../agents/review.agent.md).

## Quand l'utiliser

Utiliser ce skill apres une revue (`review-quick`, `review-security`,
`review-architecture`, `review-performance` ou `review-tests`) lorsque les
findings produits doivent etre verifies, puis eventuellement corriges selon
l'autorisation heritee. Une verification seule se termine au verdict et au
correctif propose.

## Procedure

1. Recuperer le diff, le finding complet, son fichier, sa ligne, sa severite,
   son impact et les hypotheses qui le soutiennent.
2. Reproduire ou verifier le chemin concerne dans le code et ses appelants,
   puis consulter les tests, la configuration et la documentation utiles.
3. Classer le finding : confirme, partiellement confirme, non reproduit,
   ambigu ou hors perimetre. Expliquer les elements qui justifient ce choix.
4. Challenger explicitement le finding quand son niveau de severite, sa cause,
   sa portee ou sa preuve ne tient pas. Ne pas fabriquer de correctif pour un
   probleme non etabli.
5. Pour un finding confirme, proposer un correctif traitant la cause racine.
  Si la correction est autorisee, l'appliquer et ajouter ou ajuster un test
  quand le comportement le permet ; sinon, ne pas modifier le projet.
6. Verifier le correctif applique contre la reproduction de l'etape 2 et
  reexaminer les effets de bord sur les appelants concernes.

## Contraintes

- Ne jamais rejeter un finding sans verifier le chemin de code concerne et
  fournir une raison falsifiable.
- Ne pas masquer un finding confirme en baissant sa severite.

## Sortie attendue

Pour chaque finding :

- verdict : confirme, partiellement confirme, non reproduit, ambigu ou hors
  perimetre ;
- preuves verifiees, avec fichier et ligne lorsque possible ;
- decision : correctif applique, correctif propose ou aucune modification ;
- resultat de la reproduction et, si corrige, du test de non-regression.

Terminer par une synthese des findings corriges, rejetes ou restant a traiter.
