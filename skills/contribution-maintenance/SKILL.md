---
name: contribution-maintenance
description: "Inventorier, mettre en pause, reprendre ou nettoyer des branches et worktrees Git en conservant les edits, stashes et commits uniques avant une suppression autorisée."
---

# Conservation et nettoyage

Role propriétaire : [worktree](../../agents/worktree.agent.md).

## Entrées et limites

Préciser le dépôt, les branches et worktrees concernées, puis l'opération :
pause, reprise ou nettoyage. Un inventaire seul ne retire aucune référence.
Les tags, stashes, fichiers utilisateur et autres tâches restent hors du
nettoyage de branches sauf mandat distinct.

## Mise en pause

1. Examiner les edits indexés, non indexés, non suivis et ignorés dans la
   worktree, ainsi que les commits propres à la branche. Déterminer ce qui
   doit être conservé et ce qui peut être retiré.
2. Choisir une sauvegarde adaptée au contenu. Un stash nommé peut conserver
   les edits Git et les fichiers non suivis retenus, mais pas les fichiers
   ignorés ; un bundle conserve les commits et références, pas les edits du
   checkout. Ne pas placer de secrets dans une sauvegarde Git.
3. Vérifier la sauvegarde avant tout retrait : contenu attendu, lisibilité,
   emplacement et identifiant stable. Conserver le SHA du stash plutôt qu'un
   indice qui changera avec les prochaines sauvegardes.
4. Retirer uniquement la worktree devenue propre et la branche dont le
   retrait est autorisé. Signaler les contenus non sauvegardés et s'arrêter
   plutôt que forcer leur suppression.

## Reprise

1. Vérifier si le travail sauvegardé est déjà intégré : état et SHA de la PR,
   contenu ou équivalence du patch, notamment après un squash. Ne pas réappliquer
   automatiquement une sauvegarde dont le travail est déjà présent.
2. Pour le travail restant, préparer une worktree sur la base appropriée et
   appliquer la sauvegarde par son identifiant stable sans la supprimer.
3. Inspecter le diff et les conflits, puis exécuter les checks utiles avant de
   poursuivre. En cas de conflit, conserver les deux versions et la sauvegarde
   pour une résolution explicite.

## Déplacement

1. Déplacer uniquement la worktree de la tâche courante ou une worktree dont le
   déplacement a été explicitement autorisé. Identifier son chemin, sa branche,
   son SHA, son état indexé, non indexé, non suivi et ignoré.
2. Calculer la destination depuis la worktree principale recensée par
   `git worktree list --porcelain`, sous `tmp/worktree/<task-slug>`. Vérifier
   que la destination est absente et ignorée par le `.gitignore` versionné avec
   `git check-ignore -v`.
3. Vérifier que la worktree source n'est pas verrouillée et que le chemin source
   est accessible. Ne pas exiger un état propre: les changements suivis, non
   suivis et ignorés doivent rester dans le même dossier déplacé.
4. Exécuter `git worktree move <source> <destination>` sans forcer. En cas
   d'échec, laisser la source en place et diagnostiquer plutôt que supprimer ou
   recréer la worktree.
5. Vérifier le chemin dans `git worktree list`, la branche et le SHA, puis
   comparer `git status --short --branch --untracked-files=all` et
   `git status --short --ignored` à l'état relevé avant le déplacement.

## Nettoyage

1. Rapprocher l'inventaire local des branches distantes actuelles et des PR.
   Confirmer le SHA à retirer, pas seulement le nom d'une PR ancienne : une
   branche peut avoir reçu du travail après son merge.
2. Pour chaque candidat, distinguer travail intégré, travail unique abandonné
   explicitement et travail encore actif. Une PR fermée ne prouve pas un merge.
   Pour une intégration par squash, vérifier la PR au SHA concerné ou le patch.
   Conserver une sauvegarde vérifiée des commits uniques avant leur retrait.
3. Vérifier les fichiers locaux avant de retirer une worktree. Si son chemin
   est inaccessible, ne pas la déclarer propre : limiter un retrait autorisé
   à son enregistrement Git obsolète, sans supprimer des fichiers sur un
   emplacement non inspectable.
4. Supprimer uniquement les références autorisées, jamais la branche cible
   principale. Protéger les suppressions distantes par leurs SHA attendus ;
   une modification concurrente exige une nouvelle décision. Un rejet de
   suppression locale après squash exige une preuve d'intégration ou une
   sauvegarde, pas une suppression forcée par réflexe.
5. Nettoyer les références de suivi obsolètes et vérifier l'inventaire final,
   les edits conservés et les sauvegardes. Ne pas supprimer les stashes ou
   expirer les sauvegardes pour obtenir artificiellement un dépôt propre.

## Résultat

Lister ce qui a été retiré, ce qui reste actif et les contenus préservés.
Donner les identifiants et emplacements de reprise, avec toute limite de
vérification, notamment une worktree inaccessible ou une sauvegarde incomplète.
