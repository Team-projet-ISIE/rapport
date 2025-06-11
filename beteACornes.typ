// #import "report/report.typ": * // Import all report symbols
#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node
#set page(width: 18.5cm, height: 7cm, margin: .2cm, fill: none)
#import fletcher.shapes: rect
#let HIGH = $3.3 V$ // Définition du niveau électrique HAUT
#let LOW = $0 V$ // Définition du niveau électrique BAS

#import fletcher.shapes: *
#diagram(
  spacing: .25em,
  node((0, 0), [À qui rend-il service~?]),
  node(
    (0, 1),
    height: 4em,
    width: 12em,
    [Personnes présentes dans la pièce cible],
    stroke: black, // Add a black border
    shape: ellipse,
    inset: 1.25em,
  ),
  edge(bend: -14deg, stroke: 1pt),
  node(
    (2, 1),
    height: 4em,
    width: 12em,
    [Air de la pièce cible et de la pièce référence],
    stroke: black, // Add a black border
    shape: ellipse,
    inset: 1.25em,
  ),
  node((2, 0), [Sur quoi agit-il~?]),
  node(
    (1, 2),
    height: 5em,
    width: 18em,
    [Déclencheur d’aération sur commande en température],
    stroke: black, // Add a black border
    shape: ellipse,
    inset: 1.5em,
  ),
  node((1, 4), [Dans quel but~?]),
  edge((1.65, 1.33), (1.5, 4.5), "->", bend: -17deg, stroke: 1pt),
  node(
    (1, 5),
    name: <goal>,
    height: 4em,
    width: 22em,
    [
      Profiter de températures confortables dans la pièce cible
    ],
    stroke: black, // Add a black border
    inset: .5em,
    corner-radius: .5em,
  ),
)
