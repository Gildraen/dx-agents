---
name: tests-audit
description: 'Cartographier la couverture de tests reelle d''un projet entier (modules, scripts, workflows, taskfiles), identifier les zones non testees ou mal testees et les prioriser par risque, sans ecrire aucun test ; a utiliser par dx-tests avant toute completion de la suite de tests.'
---

# Audit de couverture de tests

Role proprietaire : [tests](../../agents/tests.agent.md).

## Quand l'utiliser

Utiliser ce skill lorsqu'il faut etablir ou verifier l'etat reel de la
couverture de tests d'un projet entier, avant d'ecrire ou de completer des
tests. Ce mode est non mutatif : il ne cree, ne modifie et ne supprime aucun
fichier. Ne pas l'utiliser pour la revue d'un diff ponctuel pendant une code
review : ce cas reste couvert par le mode `review-tests` de `dx-review`.

## Procedure

1. Identifier le perimetre reel du projet : modules, packages, scripts,
   workflows, taskfiles et points d'entree, pas uniquement les fichiers
   recemment modifies.
2. Reperer les frameworks, runners et commandes de test deja en place (par
   exemple `task test`, `task validate`, `task feature:test`) et les
   conventions de nommage et de structure existantes, plutot que d'en
   imposer de nouvelles sans justification.
3. Construire une cartographie du perimetre teste et non teste : pour chaque
   module ou script, relier les comportements aux assertions et a la commande
   qui les execute, pas seulement a un nom de fichier de test. Verifier le
   nominal, les erreurs/limites et les non-regressions des bugs connus ;
   distinguer test present, test execute et couverture inconnue.
4. Prioriser les lacunes selon le risque reel (chemin critique, comportement
   public, script invoque en CI ou par des consommateurs) plutot que de
   viser une couverture uniforme sans discernement.
5. Arreter l'analyse des qu'une cartographie exploitable et une liste de
   lacunes priorisees sont etablies ; laisser l'ecriture des tests au skill
   `tests-complete`.

## Sortie attendue

Cartographie comportement/assertions/commande avec statut de preuve et niveau
de risque, lacunes priorisees et outils/conventions a reutiliser. Cette liste
est l'entree de `tests-complete`, pas une autorisation implicite de l'executer.
