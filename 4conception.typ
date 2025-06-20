#import "report/report.typ": * // Import all report symbols
// - Architecture globale ?
// - Schéma bloc ?
// - @mcu ?
// - @datasheet ?

= Conception

== Conception matérielle

=== Choix des composants

// ==== Traitements numériques (FP0/FP1)
// #fig(table(
//   columns: 4,
//   [*Composant*], [*Valeur recommandée*], [*Type*], [*Justification*],
//   [C3, C4],
//   [100 nF ($0.1 ~mu F$)],
//   [Céramique],
//   [Filtrage local obligatoire pour éviter les resets parasites du PIC24F],
// ))[Choix des composants du bloc alimentation]

// ==== Interfaçage humain-machine (FP4)
// #fig(table(
//   columns: 4,
//   [*Composant*], [*Valeur recommandée*], [*Type*], [*Justification*],
//   [LED (rouge)], [R1], [330 $Omega$], [Résistance],
//   [LED rouge (\~2V), courant 3 à 5 mA en 3.3V],
//   [LED (verte)],
//   [R2],
//   [470 $Omega$],
//   [Résistance],
//   [LED verte (\~2.2V) nécessite un courant plus bas pour même luminosité],
//   [LED (jaune)],
//   [R3],
//   [390 $Omega$], [Résistance], [Tension typique \~2.1V], [LED (orange)],
//   [R4], [390-470 $Omega$], [Résistance], [Similaire au jaune],
// ))[Choix des composants du bloc alimentation]
// Formule utilisée: $R = V_"alim" - V_"led" / I$

// ==== Alimentation (FA0)
// #fig(table(
//   columns: 4,
//   [*Composant*], [*Valeur recommandée*], [*Type*], [*Justification*],
//   [C1 (entrée LM2574)],
//   [$100 ~mu F$],
//   [Électrolytique],
//   [Filtrage basse fréquence (ripple d'entrée)],
//   [C2 (sortie LM2574)],
//   [$0.1 mu F + 100 mu F$],
//   [Céramique],
//   [Le $0.1 mu F$ filtre les hautes fréquences à la sortie],
//   [D1], [1N5822], [Diode Schottky], [Faible chute de tension, rapide],
//   [L1],
//   [$100~mu H$ - $330~mu H$],
//   [Self],
//   [Recommandée dans les \ régulateurs à découpage],
// ))[Choix des composants du bloc alimentation]

=== Écoconception

==== Alimentation

Remplacement du LM2574 (rendement 75–80 %) par un #link(
  "https://www.mouser.fr/c/?q=MP1584&srsltid=AfmBOoomZs3Ve2X_ggsdSyUf4NPJ5ALkqRL-gmh70By6GHsim0H8emv",
)[MP1584] (rendement 90–95 %) pour un gain de rendement de 15 à 20~%.

Ajout d’un MOSFET pour couper l’alimentation des périphériques (LCD, XBee)
lorsqu’ils ne sont pas utilisés.

==== Microcontrôleur

Utilisation des modes Sleep du PIC24.

Réduction de fréquence d’horloge via PLL/OSCCON.

==== Passifs

Remplacement pull-up 4,7 kΩ par 10–47 kΩ, suppression de condensateurs
"superflus".

=== Schémas structurels

#fig(image("./cible.png"))[Schéma structurel du module
  @cible]

#fig(image("./reference.ventilateur.png"))[Schéma structurel du module @réf avec
  un ventilateur 12~V]

#fig(image("./reference.relais.png"))[Schéma structurel du module
  @réf]

#set page(flipped: false)

=== Conception du circuit imprimé

== Conception logicielle

// - Architecture globale ?
// - Schéma bloc ?

=== Algorithme d’aération

// === Interfaçage humain-machine ?

L’algorithme d’aération du système dans son ensemble est relativement simple,
constitué principalement de deux tests pouvant mener à deux actions,
l’activation ou la désactivation de l’aération.

Le temps d’attente entre chaque test de température peut être réduit à quelques
secondes pour augmenter la réactivité du système, ou allongé à plusieurs
dizaines de secondes pour diminuer la consommation énergétique. Mais, il s’agit
déjà d’une considération plus bas niveau, qu’il convient de mettre en
perspective avec la nécessité de communiquer des informations sans fil entre
deux modules distants.

#fig(pseudo[
  + *Boucler Indéfiniment*
    + temp_ref $arrow.l$ lire(température pièce référence)
    + temp_cib $arrow.l$ lire(température pièce cible)
    + mode $arrow.l$ lire(mode sélectionné)
    + *Si* ( mode $=$ CHAUFFAGE *Et* temp_ref $>$ temp_cib $+ 1°C$ )
      + *Ou* ( mode $=$ REFROIDISSEMENT *Et* temp_cib $>$ temp_ref $+ 1°C$ )
      + activer_aération()
    + *Sinon*
      + désactiver_aération()
    + *Fin Si*
    + dormir(N secondes)
  + *Fin Boucle*
])[Algorithme d’aération haut niveau]
