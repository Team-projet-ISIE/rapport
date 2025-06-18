#import "report/report.typ": * // Import all report symbols
= Introduction

// == Contexte général

Réaliser ce déclencheur d’aération, en étant responsables du recueil de besoin
jusqu’à la réalisation, en passant par l’analyse et la conception, représente
une opportunité de consolider les nombreux apprentissages effectués en cette
première année en @isie à @polytech, les mettant en pratique. Mais, ce projet,
pour nous le premier de cette envergure, représente aussi un important défi.

N’ayant pas d’expérience préalable sur un projet de cet acabit, nous ne savions
pas à priori par quelles étapes passer, quelle méthodologie adopter. Si nous
avons pu nous en référer aux enseignements théoriques de l’année, la tâche est
tout autre lorsqu’il s’agit de la diriger. Nous avons donc exploré plusieurs
pistes et fait demi-tour à plusieurs reprises. Si ce processus peut apparaître
comme fastidieux, il n’en a pas moins constitué une expérience riche en
enseignements.

== Problématiques à résoudre

Les projets commencent généralement par une expression du besoin, et ce présent
projet n’y déroge pas. Si nous n’étions pas sûrs des questions à poser, des
points à éclaircir, nous avons tout de même le sentiment de sortir de
l’entretien avec @chauvin en ayant une assez bonne idée de ce que nous devions
réaliser.

L’idée est de réaliser un système composé de deux modules communicants, de
préférence sans-fil, étant capable de déclencher un échange d’air entre deux
pièces reliées par une gaine d’aération.

== Objectifs du projet

L’objectif du projet est de pouvoir profiter de la climatisation d’une pièce
dans une autre pièce, limitant ainsi le nombre d’unités de climatisation
nécessaires dans le bâtiment.

Il doit être possible de choisir entre deux modes : chauffage ou
refroidissement. En fonction du choix utilisateur, il faut utiliser l’air
climatisé de la @réf pour aérer la @cible aux moments opportuns.

#fig(image("./schemaPiecesAeration.excalidraw.svg"))[Croquis du système
  d’aération dans son ensemble]
