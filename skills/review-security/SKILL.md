---
name: review-security
description: Revue de securite (OWASP Top 10, secrets, permissions, entrees non fiables), a utiliser pour les changements touchant auth, entrees utilisateur, secrets ou permissions.
---

# Revue securite

Role proprietaire : [review](../../agents/review.agent.md).

## Quand l'utiliser

Changement touchant l'authentification/autorisation, une entree utilisateur,
un secret ou token, une permission de fichier/processus, ou une dependance
externe.

Partir des entrees et frontieres de confiance touchees par le diff ; relier
chaque risque au chemin accessible et aux privileges requis pour l'exploiter.

## Checklist (alignee OWASP Top 10)

- Injection: entrees utilisateur echappees/parametrees (SQL, shell, template,
  regex).
- Authentification/session: pas de contournement, expiration et stockage de
  session corrects.
- Controle d'acces: verification d'autorisation a chaque point d'entree
  sensible, pas seulement cote UI.
- Donnees sensibles: aucun secret en clair dans le code, les logs ou
  l'historique Git; chiffrement au repos/transit si applicable.
- Configuration: permissions minimales necessaires, pas de mode debug expose
  en production.
- Dependances: pas d'ajout non necessaire ou non maintenu sans justification.
- SSRF / entrees externes: URLs et ressources externes validees, pas de
  requete arbitraire construite depuis une entree utilisateur.
- Logging: pas de donnee sensible loggee (tokens, mots de passe, PII).

## Sortie attendue

Chaque finding classe par severite (bloquant / a corriger / a surveiller),
avec le vecteur d'attaque explicite.
