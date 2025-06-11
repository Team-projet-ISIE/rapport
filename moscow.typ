// #import "report/report.typ": * // Import all report symbols
#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node
#set page(width: 18.5cm, height: 8.5cm, margin: .2cm, fill: none)
#import fletcher.shapes: rect
#let HIGH = $3.3 V$ // Définition du niveau électrique HAUT
#let LOW = $0 V$ // Définition du niveau électrique BAS
#import fletcher.shapes: *

#table(
  columns: 2,
  align: (left, left),
  table.header(
    align(center, strong[
      Must\ (à faire absolument, objectifs de la v1.0.0)
    ]),
    align(center, strong[
      Should\ (objectifs de sous-versions v1.x.x)
    ]),
  ),
  [
    - Mode hiver (chauffage)~: Aérer si la pièce cible est plus froide que la
      pièce de référence
    - Mode été (refroidissement)~: Aérer si la pièce cible est plus chaude que
      la pièce de référence
    - Choix entre un des deux modes ci-dessous avec un commutateur physique
  ],
  [
    - Affichage de la température actuelle de la pièce cible
    - Affichage de la température actuelle de la pièce de référence
    - Réglage de la température seuil par l’utilisateur
  ],
  table.cell(align: center, strong[
    Could\ (objectifs de versions majeures ultérieures)
  ]),
  table.cell(align: center, strong[
    Wont\ (ne va pas être fait, hors sujet)
  ]),
  [
    - Fonctionnement sur batterie d’une partie du système
  ],
  [
    - Compatibilité avec les standards de domotique, intégrations dans des
      systèmes domotiques plus larges
    - Fonctionnement avec plus de deux pièces, autres que pièce référence et
      pièce cible
  ],
)
