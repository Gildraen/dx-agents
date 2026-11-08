---
name: evolution-discovery
description: 'Remplacer une enumeration ou une liste codee en dur par une decouverte automatique controlee, quand de nouveaux composants doivent etre pris en compte sans modifier une liste centrale.'
---

# Evolution discovery

Role proprietaire : [evolution](../../agents/evolution.agent.md).

## Quand l'utiliser

Utiliser ce skill lorsqu'un projet enumere manuellement des fichiers, agents,
plugins, commandes, routes ou composants qui suivent une convention stable et
pourraient etre decouverts automatiquement.

Entree : une enumeration et une convention candidate. Le resultat est un
mecanisme de selection controlee ; rendre une valeur parametrable releve de
`evolution-config`, migrer ses consommateurs de `evolution-migration`.

## Procedure

1. Identifier la liste, sa source de verite, ses consommateurs et le
   comportement attendu lorsqu'un element est ajoute, supprime ou invalide.
2. Rechercher une convention fiable : arborescence, extension, frontmatter,
   nommage, entree de configuration ou registre deja existant.
3. Comparer le parcours de fichiers, le glob, l'introspection et le registre
   explicite selon la portee, l'ordre, les doublons, les permissions et le
   cout d'execution.
4. Implementer la decouverte au plus pres de la responsabilite qui consomme
   les elements, avec filtrage explicite et erreurs observables.
5. Ajouter des tests pour l'element decouvert, l'element invalide, l'absence
   d'element, les doublons et les chemins hors perimetre pertinents.
6. Documenter la convention : comment ajouter un element, quels noms sont
   acceptes et quelles erreurs sont refusees.

## Criteres de qualite

- Un nouvel element conforme est pris en compte sans modifier une liste
  centrale.
- La decouverte ne capture pas silencieusement des fichiers inattendus.
- L'ordre et les erreurs restent deterministes ou sont documentes comme tels.

## Sortie attendue

Indiquer la liste remplacee, la convention retenue, les limites de la
decouverte, les fichiers modifies et les tests executes.
