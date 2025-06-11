// #import "report/report.typ": * // Import all report symbols
#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node
#set page(width: 18cm, height: 5.5cm, margin: .2cm, fill: none)
#import fletcher.shapes: rect
#let HIGH = $3.3 V$ // Définition du niveau électrique HAUT
#let LOW = $0 V$ // Définition du niveau électrique BAS
#import fletcher.shapes: *


#diagram(
  spacing: 1cm,
  // Module 1
  node((0, 0), [Température pièce référence], name: <in1>),
  // node((0, 1), [Informations pièce cible (Ondes RF)], name: <in2>),
  node((2, .5), [Flux thermique], name: <out1>),
  node((2, 1.5), [Informations visuelles], name: <out2>),
  node(
    (1, .5),
    enclose: ((1, 0), (1, 2)),
    width: 17em,
    [
      Déclenchement intelligent de l’aération en fonction des informations
      recueillies
    ],
    stroke: black, // Add a black border
    inset: .5cm,
  ),
  edge(<in1>, (1, 0), "->"),
  // edge(<in2>, (1, 1), "->"),
  edge((1, .5), <out1>, "->"),
  edge((1, 1.5), <out2>, "->"),
  // Module 2
  node((0, 1), [Température pièce cible], name: <in3>),
  node((0, 2), [Choix du mode par l’utilisateur], name: <in4>),
  // node((2, 2.5), [Informations pièce cible (Ondes RF)], name: <out2>),
  // node(
  //   (1, 2.5),
  //   enclose: ((1, 2), (1, 3)),
  //   block(width: 20em)[
  //     Captage de la température pièce cible et du choix du mode, transmissions à
  //     l’autre module côté référence
  //   ],
  //   stroke: black, // Add a black border
  //   inset: .5cm,
  // ),
  edge(<in3>, (1, 1), "->"),
  edge(<in4>, (1, 2), "->"),
  // edge((1, 2.5), <out2>, "->"),
  // node((1, 3), [Informations autre pièce (Ondes RF)], name: <in2>),
  // edge((1, 2), <in2>, "->"),
  // edge(<in2>, (1, 2), "->"),
)
