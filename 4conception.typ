#import "report/report.typ": * // Import all report symbols
= Conception

- Architecture globale ?
- Schéma bloc ?
- @mcu ?
- @datasheet ?

#set page(flipped: true)

== Conception matérielle

=== Choix des composants

#text(red)[
  *TODO: Est-ce la meilleure manière de présenter ? Paragraphes pour
  justifier ?*
]

// TODO check si bon code fonction
==== Traitements numériques (FP0/FP1)

#fig(table(
  columns: 4,
  [*Composant*], [*Valeur recommandée*], [*Type*], [*Justification*],
  [C3, C4],
  [100 nF ($0.1 ~mu F$)],
  [Céramique],
  [Filtrage local obligatoire pour éviter les resets parasites du PIC24F],
))[Choix des composants du bloc alimentation]

// TODO check si bon code fonction
==== Captage température et humidité (FP2)

#fig(table(
  columns: 4,
  [*Composant*], [*Valeur recommandée*], [*Type*], [*Justification*],
  [], [], [], [],
))[Choix des composants]

==== Interfaçage RF (FP3)

#fig(table(
  columns: 4,
  [*Composant*], [*Valeur recommandée*], [*Type*], [*Justification*],
  [], [], [], [],
))[Choix des composants]

==== Interfaçage humain-machine (FP4) // TODO check si bon code fonction

#fig(table(
  columns: 4,
  [*Composant*], [*Valeur recommandée*], [*Type*], [*Justification*],
  [LED (rouge)], [R1], [330 $Omega$], [Résistance],
  [LED rouge (\~2V), courant 3 à 5 mA en 3.3V],
  [LED (verte)],
  [R2],
  [470 $Omega$],

  [Résistance],
  [LED verte (\~2.2V) nécessite un courant plus bas pour même luminosité],
  [LED (jaune)],
  [R3],

  [390 $Omega$], [Résistance], [Tension typique \~2.1V], [LED (orange)],
  [R4], [390-470 $Omega$], [Résistance], [Similaire au jaune],
))[Choix des composants du bloc alimentation]

// Formule utilisée: $R = V_"alim" - V_"led" / I$

==== Commande aérateur en puissance (FP5)

#fig(table(
  columns: 4,
  [*Composant*], [*Valeur recommandée*], [*Type*], [*Justification*],
  [], [], [], [],
))[Choix des composants]

==== Aération (FP6)

#fig(table(
  columns: 4,
  [*Composant*], [*Valeur recommandée*], [*Type*], [*Justification*],
  [], [], [], [],
))[Choix des composants]

==== Alimentation (FA0) // TODO check si bien FA0

#fig(table(
  columns: 4,
  [*Composant*], [*Valeur recommandée*], [*Type*], [*Justification*],

  [C1 (entrée LM2574)],
  [$100 ~mu F$],
  [Électrolytique],
  [Filtrage basse fréquence (ripple d'entrée)],

  [C2 (sortie LM2574)],
  [$0.1 mu F + 100 mu F$],
  [Céramique],
  [Le $0.1 mu F$ filtre les hautes fréquences à la sortie],

  [D1], [1N5822], [Diode Schottky], [Faible chute de tension, rapide],

  [L1],
  [$100~mu H$ - $330~mu H$],
  [Self],
  [Recommandée dans les \ régulateurs à découpage],
))[Choix des composants du bloc alimentation]

=== Schéma électronique

// TODO export NI Multisim
#fig(image("placeholder.svg", height: 90%))[Schéma électronique (NI Multisim)]

#set page(flipped: false)

=== Conception du circuit imprimé

== Conception logicielle

- Architecture globale ?
- Schéma bloc ?

=== Algorithme d’aération

// === Interfaçage humain-machine ?

