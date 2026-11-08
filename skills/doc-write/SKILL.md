---
name: doc-write
description: 'Creer, restructurer ou mettre a jour un document Markdown (README, guide, reference) a partir du contexte reel du projet ; utilise par l''agent de documentation pour toute production ou refonte de contenu.'
---

# Ecriture de documentation

Role proprietaire : [documentation](../../agents/documentation.agent.md).

## Quand l'utiliser

Utiliser ce skill pour creer un nouveau document Markdown, restructurer un
document existant (refonte de plan, fusion, decoupage) ou mettre a jour son
contenu suite a un changement de comportement, de configuration ou de
contrat.

Ne pas l'utiliser pour une simple relecture sans intention de modifier le
document ; utiliser `doc-review` pour cela.

## Procedure

1. Identifier le public vise, l'objectif du document, son emplacement final
   et le comportement ou le contrat qu'il doit decrire.
2. Rassembler les contrats sources et, s'ils existent, les findings de
   `doc-review` retenus pour cette mise a jour.
3. Pour une refonte, identifier d'abord ce qui doit etre conserve (sens
   technique, ton, exemples encore valides) avant de reorganiser.
4. Organiser ou reorganiser le contenu autour des parcours reels du lecteur :
   pre-requis, installation, utilisation, configuration, verification et
   limites, uniquement lorsque ces rubriques sont utiles au document concerne.
5. Rediger les parcours et leurs exemples avec preconditions et resultat
   attendu ; conserver les faits non resolus comme questions a trancher.
## Sortie attendue

Indiquer le document cree ou modifie, les faits verifies avec leur source,
les changements apportes, les liens/commandes controles et les questions ou
limites restantes.
