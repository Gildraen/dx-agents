---
name: evolution-config
description: 'Externaliser une variabilite codee en dur dans une configuration ou une convention simple, sans introduire un systeme de plugins inutile.'
---

# Evolution config

Role proprietaire : [evolution](../../agents/evolution.agent.md).

## Quand l'utiliser

Utiliser ce skill lorsqu'un comportement varie selon le projet, le contexte,
un environnement ou une nouvelle entree et que cette variabilite est enfouie
dans des conditions ou des constantes du code.

Entree : une variation identifiee et ses consommateurs. Le resultat est un
contrat de configuration ; la recherche automatique de composants releve de
`evolution-discovery`, le deploiement d'une rupture de `evolution-migration`.

## Procedure

1. Distinguer la variabilite reelle des constantes qui doivent rester dans le
   code et relever les appelants qui dependent de la valeur actuelle.
2. Choisir le niveau de configuration le plus proche du besoin : fichier,
   frontmatter, option de commande, variable d'environnement ou valeur par
   defaut versionnee.
3. Definir le schema minimal, les valeurs par defaut, la validation, la
   compatibilite et le comportement en cas de valeur inconnue.
4. Lire la configuration via une seule source de verite et supprimer les
   branches ou constantes dupliquees devenues inutiles.
5. Tester les valeurs par defaut, une valeur personnalisee, une valeur invalide
   et l'absence de configuration.
6. Documenter qui peut modifier la configuration et comment verifier son effet.

## Criteres de qualite

- La configuration ne duplique pas une information deja derivee du projet.
- Les valeurs invalides echouent clairement et sans comportement implicite
  dangereux.
- Le comportement historique est conserve par defaut lorsque c'est possible.

## Sortie attendue

Indiquer la variabilite extraite, le schema retenu, les valeurs par defaut,
les validations, les fichiers modifies et les risques de compatibilite.
