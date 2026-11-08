---
name: scope-planning
description: 'Planifier une intervention après analyse : comparer les options, poser les questions nécessaires et décider d''une action sans l''exécuter.'
---

# Scope planning

Role propriétaire : [evolution](../../agents/evolution.agent.md).

## Quand l'utiliser

Utiliser ce skill après `scope-analysis`, lorsqu'une demande nécessite un choix
d'architecture, une clarification des exigences ou un plan avant modification.
Ce mode est non mutatif : il prépare une décision mais n'exécute aucun
changement.

## Procedure

1. Reprendre le périmètre et le contrôle discriminant de `scope-analysis`, ou
   une analyse équivalente déjà disponible, puis lister les inconnues qui
   peuvent changer la solution.
2. Définir au plus trois options réalistes, dont l'option de ne rien changer
   lorsque le besoin n'est pas démontré.
3. Comparer chaque option selon le gain attendu, le coût, le couplage, la
   compatibilité, les risques, la testabilité et la réversibilité.
4. Recommander l'option retenue en reliant ses compromis au contrôle
   discriminant et aux consommateurs identifiés.
5. Poser uniquement les questions bloquantes, avec le contexte nécessaire et
   une conséquence claire pour chaque réponse.
6. Définir un plan séquencé : fichiers ou composants, tests, documentation,
   migration et condition d'arrêt.
7. Livrer le plan sans l'exécuter, en distinguant les décisions déjà acquises
   de celles qui nécessitent encore une réponse.

## Contraintes

- Ne pas multiplier les options théoriques sans différence concrète.
- Ne pas planifier de compatibilité ou d'abstraction sans consommateur ou
  risque qui le justifie.

## Sortie attendue

Présenter :

- périmètre retenu et hypothèses ;
- options comparées et compromis ;
- recommandation argumentée ;
- questions bloquantes, s'il y en a ;
- plan d'implémentation et validations prévues ;
- décisions encore requises avant exécution, le cas échéant.
