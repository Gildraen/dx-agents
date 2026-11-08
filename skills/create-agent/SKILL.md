---
name: create-agent
description: Workflow pour creer un agent pour clients IA compatibles, partage ou specifique au projet, avec ses metadonnees, son contenu, son chargement et ses validations.
---

# Creation d'agent

Role proprietaire : [agent-manager](../../agents/agent-manager.agent.md).

## Quand l'utiliser

Utiliser ce skill lorsqu'une demande vise la creation d'un nouvel agent, le
choix de sa portee, son chargement par un client IA compatible ou la verification de sa
structure.

## Procedure

1. Partir du besoin de role retenu : utilisateurs, declencheur, decisions
   propres et limites de l'agent.
2. Determiner la portee :
   - partage dx-agents -> `agents/<nom>.agent.md` dans `Gildraen/dx-agents` ;
   - projet -> `.agents/agents/<nom>.agent.md`.
3. Identifier les skills que le role possede ou compose, leur ordre et les
   cas a deleguer. Placer les regles communes de cette famille dans le role,
   pas dans chacune de ses procedures.
4. Ecrire le frontmatter neutre limite a `name` et `description` :
   ```yaml
   ---
   name: <nom-court>
   description: <role et cas d'utilisation>
   ---
   ```
5. Rediger le role avec objectif, activation, regles de domaine, selection et
   composition des skills, limites de delegation et format de sortie.
6. Exercer un scenario nominal et un scenario de refus ou de delegation pour
   verifier les frontieres du nouveau role.
7. Verifier les references, les liens, le frontmatter, `task validate`,
   `task test` dans `Gildraen/dx-agents` et
   les conventions documentaires concernees.

## Sortie attendue

Donner le chemin canonique de la source, le mode de chargement explicite,
la portee retenue, les validations executees et les limites.
