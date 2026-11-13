---
name: tests-complete
description: 'Ecrire ou completer les tests et scripts de test pour combler des lacunes identifiees, avec preuve de detection par non-regression ou falsification controlee ; a utiliser par dx-tests pour implementer une suite de tests.'
---

# Completion de la suite de tests

Role proprietaire : [tests](../../agents/tests.agent.md).

## Quand l'utiliser

Utiliser ce skill lorsque des lacunes de couverture sont deja identifiees
(par exemple par `tests-audit`) ou explicitement demandees, et qu'il faut
ecrire ou completer les tests et scripts de test correspondants, y compris
lorsque le comportement de production est deja correct.

## Procedure

1. Reprendre la liste des lacunes priorisees ou, a defaut, le perimetre
   explicitement demande.
2. Associer chaque lacune a un comportement observable, un oracle attendu et
   la commande cible utilisant le runner existant.
3. Ecrire les tests et scripts necessaires, puis etablir leur pouvoir de
   detection :
   - pour un bug corrige, constater l'echec avant correction et le succes
     apres correction lorsque cette comparaison est disponible ;
   - pour un comportement deja correct, utiliser si possible une entree
     fautive, un double de test ou une mutation temporaire isolee qui simule
     la regression. Verifier l'echec attendu, restaurer l'etat puis verifier
       le succes. Ne laisser aucune mutation dans le resultat livre ; aucun
       correctif de production n'est requis pour couvrir un comportement deja
       correct ;
   - si une falsification sure et reversible est impossible, expliquer la
     limite et ne pas presenter le seul succes comme une preuve rouge/vert.
4. Executer la commande cible apres restauration, puis la suite pertinente
   pour detecter les interactions avec les tests existants.
5. Documenter explicitement les zones sciemment laissees sans test (limite
   technique, cout disproportionne) plutot que de les omettre silencieusement.

## Sortie attendue

Correspondance lacune/test, resultat de la falsification ou de la comparaison
avant/apres, confirmation de restauration et resultat final de la suite.
Identifier les lacunes restantes et les limites de preuve.
