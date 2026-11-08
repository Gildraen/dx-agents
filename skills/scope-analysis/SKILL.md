---
name: scope-analysis
description: 'Analyser le périmètre d une demande sans modifier le projet : surface concernée, consommateurs, contraintes, risques et validations disponibles.'
---

# Scope analysis

Role propriétaire : [evolution](../../agents/evolution.agent.md).

## Quand l'utiliser

Utiliser ce skill lorsqu'un agent doit comprendre une demande avant d'agir,
cartographier son périmètre ou vérifier qu'une hypothèse est fondée. Ce mode
est explicitement non mutatif : il ne crée, ne modifie et ne supprime aucun
fichier.

## Procedure

1. Reformuler l'objectif observable et distinguer les faits fournis, les
   hypothèses et les inconnues.
2. Identifier l'ancre locale : fichier, symbole, commande, test, erreur ou
   comportement qui décide réellement du sujet.
3. Suivre les dépendances immédiates : appelants, consommateurs, contrats,
   configuration, documentation et tests voisins.
4. Délimiter ce qui est dans le scope, hors scope ou encore ambigu, sans
   explorer largement les zones qui ne peuvent pas changer la décision.
5. Relever les contraintes techniques, les effets de bord possibles et le
   contrôle le moins coûteux qui pourrait réfuter l'hypothèse principale.
6. Arrêter l'analyse dès qu'une hypothèse falsifiable, un périmètre défendable
   et une validation discriminante sont établis.

Le résultat est une entrée pour `scope-planning` lorsqu'un choix reste à
faire, ou pour la procédure d'évolution retenue lorsque la décision existe
déjà. L'analyse s'arrête au périmètre et au contrôle discriminant, pas au plan
de refonte.

## Sortie attendue

Produire une analyse courte avec :

- objectif et ancre examinée ;
- faits vérifiés et hypothèse principale ;
- fichiers, symboles et consommateurs concernés ;
- inclusions, exclusions et questions ouvertes ;
- risques identifiés ;
- validation discriminante recommandée ;
- décision : périmètre suffisamment établi ou analyse à poursuivre.
