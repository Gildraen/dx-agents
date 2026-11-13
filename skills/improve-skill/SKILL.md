---
name: improve-skill
description: Workflow pour auditer et ameliorer un ou plusieurs skills pour clients IA compatibles, verifier leur pertinence, reduire leur ambiguite et valider leur chargement.
---

# Amelioration de skill

Role proprietaire : [skill-manager](../../agents/skill-manager.agent.md).

## Quand l'utiliser

Utiliser ce skill lorsqu'un skill existant doit etre relu, corrige, rendu plus
precis ou audite avec tous les skills d'un repertoire ou du runtime.

## Procedure

1. Relever les skills cibles et la tache repetable attendue de chacun, avec
   ses entrees, sa condition d'arret et son resultat.
2. Lire chaque SKILL.md en entier ainsi que ses references, scripts, assets et
   les agents qui l'utilisent.
3. Pour chaque skill, verifier :
   - pertinence de la procedure par rapport a son usage reel ;
   - description et mots-cles de decouverte, presence du "quand l'utiliser" ;
   - nom du dossier identique au champ `name` du frontmatter ;
   - format Agent Skills avec `name` et `description`, sans API client imposee ;
   - absence de responsabilites qui devraient appartenir a une instruction,
     un agent ou un prompt ;
   - taille du SKILL.md et chargement progressif (detail volumineux
     externalise en reference/script/asset) ;
   - chemins relatifs corrects vers les ressources ;
   - doublons ou chevauchement avec d'autres skills ;
   - liens, chemins de chargement et tests concernes, sans garantie de
     decouverte native.
4. Comparer les contrats d'entree/sortie des skills voisins : distinguer un
   doublon de procedure d'axes complementaires a composer. Identifier le role
   proprietaire des regles communes plutot que les recopier dans ses skills.
5. Proposer pour chaque ecart un changement et un cas d'usage discriminant.
   Si l'ecriture est autorisee, appliquer les corrections retenues et ajuster
   les ressources affectees ; sinon, conserver ces corrections en propositions.
6. Controler nom/dossier, frontmatter, references et chargement ; exercer la
   procedure sur le cas retenu lorsque le client le permet.

## Sortie attendue

Decision par skill : conserver, corriger ou proposer une refonte, avec son
contrat distinct, les chevauchements etablis et les corrections proposees ou
appliquees. Signaler les regles a remonter au role proprietaire et distinguer
chargement verifie et execution reelle de la procedure.
