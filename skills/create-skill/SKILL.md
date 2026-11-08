---
name: create-skill
description: Workflow pour creer un skill pour clients IA compatibles, partage ou specifique au projet, avec son frontmatter Agent Skills, sa structure de fichiers et ses validations.
---

# Creation de skill

Role proprietaire : [skill-manager](../../agents/skill-manager.agent.md).

## Quand l'utiliser

Utiliser ce skill lorsqu'une demande vise la creation d'un nouveau skill, le
choix de sa portee, son chargement par un client IA compatible ou la verification de sa
structure.

## Procedure

1. Partir de la tache repetable retenue : entrees necessaires, declencheurs,
   condition d'arret et resultat attendu.
2. Determiner la portee :
   - partage dx-agents -> `skills/<nom>/SKILL.md` dans `Gildraen/dx-agents` ;
   - projet -> `.agents/skills/<nom>/SKILL.md`.
3. Identifier son role proprietaire et les procedures voisines dont il recoit
   ou auxquelles il transmet un resultat. Referencer le role pour une
   invocation directe, sans recopier ses regles ni sa logique de routage.
4. Ecrire un frontmatter au format Agent Skills avec `name` et `description`,
   et `name` identique au nom du dossier :
   ```yaml
   ---
   name: <nom-dossier>
   description: '<ce que fait le skill et quand l'utiliser, mots-cles inclus>'
   ---
   ```
5. Rediger la procedure avec ses controles et son resultat. Relier les
   ressources necessaires par des chemins relatifs `./`, puis exercer un cas
   d'usage avec les entrees retenues.
6. Si le skill est partage, verifier sa prise en compte par les tests de
   decouverte et le contrat du `README.md` de `Gildraen/dx-agents`.
   `task validate` et `task test` controlent les ressources dans ce depot.
   Le test `tests/test-resource-discovery.sh` decouvre les dossiers par
   convention : ne pas y ajouter une enumeration. Ajuster seulement les
   consommateurs dont le contrat change.
7. Verifier le frontmatter, la correspondance nom/dossier, les references et
    les liens depuis le chemin de chargement retenu, pas seulement depuis le
    repertoire de travail de l'auteur.

## Sortie attendue

Donner le chemin du SKILL.md, la portee retenue, les validations executees et
les questions ou limites restantes.
