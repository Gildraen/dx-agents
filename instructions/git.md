---
name: dx-git-workflow
description: Regles Git et workflow de contribution partagees Gildraen.
---

# Git workflow

## Objectif

Definir le cadre Git minimal pour toute modification d'un repository Gildraen.

## Regles

- Travailler sur une branche dediee, jamais directement sur `main`.
- Pour chaque nouvelle demande impliquant des modifications, creer une worktree Git dediee sur cette branche avant toute edition. Effectuer les editions et validations dans cette worktree, pas dans le checkout principal.
- Reutiliser la worktree de la tache pour ses suites et transmettre son chemin aux sous-agents. Ne pas modifier ni supprimer les worktrees des autres taches. Une analyse en lecture seule ne necessite pas de nouvelle worktree.
- Ne jamais commit ni push sans approbation explicite de l'utilisateur.
- Utiliser des messages de commit conventionnels (`<type>: <description courte>`) qui decrivent la decision.
- Ouvrir une PR vers `main` et s'assurer que la validation CI passe avant merge.

## Review obligatoire avant commit ou push

L'agent effectue plusieurs passes avant de publier un changement :

1. relire le diff complet et les contrats des interfaces touchees ;
2. verifier le comportement nominal, les erreurs, les dependances et l'environnement declare ;
3. rechercher les regressions silencieuses, problemes de portabilite, secrets, permissions et fichiers absents ;
4. executer les checks les plus proches du changement puis la validation du depot (`task validate`, `task test`).

Tout finding doit etre corrige ou signale explicitement avant toute publication. La review doit couvrir le changement complet, pas seulement le dernier fichier modifie.
