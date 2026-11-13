---
name: improve-agent
description: Workflow pour auditer et ameliorer un ou plusieurs agents pour clients IA compatibles, verifier leur pertinence, reduire leur ambiguite et valider leur comportement.
---

# Amelioration d'agent

Role proprietaire : [agent-manager](../../agents/agent-manager.agent.md).

## Quand l'utiliser

Utiliser ce skill lorsqu'un agent existant doit etre relu, corrige, rendu plus
precis ou audite avec tous les agents d'un repertoire ou du runtime.

## Procedure

1. Relever les agents cibles et le comportement de role a evaluer : selection,
   decisions, delegation ou sortie attendue.
2. Lire chaque agent en entier ainsi que ses skills, instructions, delegations,
   tests et references directement lies.
3. Pour chaque agent, verifier :
   - pertinence du role par rapport a son usage reel ;
   - description et mots-cles de decouverte ;
   - frontmatter neutre limite a `name` et `description` ;
   - absence de responsabilites qui devraient appartenir a une instruction,
     un skill ou un prompt ;
   - limites, outils, delegations et risques de boucle ;
   - clarté de la methode, des criteres de decision et de la sortie attendue ;
   - doublons ou contradictions avec d'autres agents ;
   - liens, chemins de chargement et tests, sans garantie de decouverte native.
4. Pour chaque ecart, relier la regle du role a un scenario d'invocation :
   activation attendue, skill selectionne, delegation ou refus attendu.
   Proposer une correction et un controle qui distinguerait les deux versions.
5. Si l'ecriture est autorisee, appliquer les corrections retenues et ajuster
   les references, tests ou documents affectes par un changement de contrat.
   Sinon, livrer les propositions sans les appliquer.
6. Controler le frontmatter, les liens et le chargement du role ; rejouer les
   scenarios disponibles, en distinguant lecture statique et invocation reelle.

## Sortie attendue

Decision par agent : conserver, corriger ou proposer une refonte, avec le
scenario qui la justifie et les corrections proposees ou appliquees. Distinguer
les contrats verifies statiquement des comportements effectivement exerces.
