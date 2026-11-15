---
name: contribution-publish
description: "Publier une contribution Git sur GitHub, ouvrir ou reprendre sa PR, suivre la CI et effectuer un merge autorisé après vérification du commit et de ses checks."
---

# Publication de contribution

Role proprietaire : [contribution](../../agents/contribution.agent.md).

## Entrées et limites

Partir du dépôt, de la worktree, du diff retenu, de la branche cible et du
mandat : commit, push, ouverture de PR, suivi ou merge. Ne pas ajouter de tag,
de workflow de release ou de nettoyage au mandat de publication.

## Procédure

1. Vérifier le diff complet et les dépendances de la contribution. Comparer la
   base au distant actuel. Une avance rapide compatible avec les edits locaux
   peut conserver le travail ; en cas de divergence ou conflit, s'arrêter pour
   établir la stratégie au lieu de réinitialiser le checkout.
2. Obtenir la revue et exécuter les checks appropriés du dépôt avant la
   publication. Un échec, un finding non résolu ou un check indisponible doit
   être signalé ; ne pas fabriquer une CI verte en ignorant une suite.
3. Si le mandat le couvre, indexer seulement les fichiers retenus, vérifier
   le diff indexé, committer puis pousser la branche. Confirmer le SHA distant
   et les changements locaux qui restent hors commit.
4. Chercher une PR existante pour le même dépôt, la même branche source et la
   même cible avant d'en ouvrir une. Décrire le périmètre, les checks exécutés,
   leurs limites et les dépendances de publication ; ne pas clore une issue
   dont le travail dépasse ce diff.
5. Suivre la CI sur le SHA de la PR avec le watcher natif du client en sortie
   non interactive. Vérifier les conclusions finales, pas seulement le retour
   de la commande ou l'absence de sortie. En cas d'échec, relever le check et
   les logs utiles sans relancer aveuglément ni exposer de secrets.
6. Si le merge est autorisé, vérifier la cible, l'absence de conflit et la
   réussite des checks attendus sur le commit courant. Utiliser le SHA attendu
   pour protéger l'intégration contre une modification concurrente. Une PR
   modifiée ou une CI encore en cours impose une nouvelle vérification.
7. Confirmer l'état fusionné et le contenu ou contrat disponible sur la
   branche cible. Synchroniser les checkouts concernés sans perdre leurs edits
   locaux. Signaler les conflits et laisser le travail intact plutôt que
   forcer la synchronisation.

## Condition d'arrêt et résultat

Terminer à l'étape autorisée : branche poussée, PR ouverte, checks terminés ou
merge confirmé. Donner les SHA, le lien de PR, les checks et leurs conclusions,
les modifications non publiées et les limites restantes. Un merge ne prouve
pas à lui seul qu'un artefact a été publié ou qu'un consommateur a été migré.
