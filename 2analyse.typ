#import "report/report.typ": * // Import all report symbols
// #show figure: set block(breakable: true)

= Analyse fonctionnelle // et cahier des charges

Notre objectif est de réaliser un système permettant d’équilibrer intelligemment
la température entre deux pièces via une gaine d’aération de diamètre 125~mm les
reliant. Pour cela, nous concevons un système composé de deux modules, un à
destination de la pièce référence (pièce qui est climatisée) et l’autre à
destination de la pièce cible (qui bénéficiera de la climatisation de l’autre
pièce).

Chaque module commence par capter la température de sa pièce d’accueil. N’ayant
pas besoin d’une importante précision et fonctionnant en température ambiante,
des capteurs "smart" connecant en I#super[2]C ou SPI semblent tout indiqués, ils
simplifieront le projet.

Les modules doivent communiquer entre eux, et pour cela, nous optons pour un
#link(
  "https://fr.digi.com/products/embedded-systems/digi-xbee/rf-modules",
)[XBee] fournissant une interface pour communiquer en @802-15@802-15-doc, à
priori au travers d’un protocole de plus haut niveau tel que @zigbee@xbee3-ds.

À notre stade du cursus, nous nous concentrons sur les microcontrôleurs se
programmant directement en bas niveau (registres…), en particulier 16~bit, et
nos cours et travaux-pratiques se concentrent sur l’architecture PIC24@pic24-ds
de Microchip, que l’on privilégiera donc. De plus, nous n’avons pas d’importants
besoins d’entrées-sorties et de puissance de calcul pour ce projet.

N’ayant pas la possibilité de produire un circuit avec composants soudés en
surface, tous nos composants sont sélectionnés montables en trou-traversant (ou
connectables tel qu’en Grove). Cela sera d’autant plus simple pour tester sur
breadboard.

#let HIGH = $3.3 V$ // Définition du niveau électrique HAUT
#let LOW = $0 V$ // Définition du niveau électrique BAS

#set page(flipped: true, header-ascent: .5em, footer-descent: .5em) // Paysage
#set par(justify: false) // Ne pas justifier les paragraphes, moche dans tables

== Analyse du besoin

=== Bête à cornes

#import fletcher.shapes: *
#fig(diagram(
  spacing: .25em,
  node((0, 0), [À qui rend-il service~?]),
  node(
    (0, 1),
    height: 4em,
    width: 14em,
    [Personnes présentes dans la @cible],
    stroke: black, // Add a black border
    shape: ellipse,
    inset: 1.25em,
  ),
  edge(bend: -14deg, stroke: 1pt),
  node(
    (2, 1),
    height: 4em,
    width: 14em,
    [Air de la @cible],
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
  edge((1.6, 1.4), (1.45, 4.5), "->", bend: -17deg, stroke: 1pt),
  node(
    (1, 5),
    name: <goal>,
    height: 4em,
    width: 22em,
    [
      Profiter de températures confortables dans la @réf
    ],
    stroke: black, // Add a black border
    inset: .5em,
    corner-radius: .5em,
  ),
))[Bête à cornes]

=== Matrice MOSCOW // Portée du projet

#fig(table(
  columns: 2,
  align: (left, left),
  table.header(
    align(center, strong[Must (à faire absolument, objectifs de la v1.0.0)]),
    align(center, strong[Should (objectifs de sous-versions v1.x.x)]),
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
  table.cell(align: center, strong[Could (objectifs de versions majeures
    ultérieures)]),
  table.cell(align: center, strong[Wont (ne va pas être fait, hors sujet)]),
  [
    - Fonctionnement sur batterie du module ne pilotant pas l’aérateur
  ],
  [
    - Compatibilité avec les standards de domotique, intégrations dans des
      systèmes domotiques plus larges
    - Fonctionnement avec plus de deux modules, deux pièces
  ],
))[Matrice MOSCOW]

#pagebreak()

== Schémas fonctionnels

#import fletcher.shapes: rect

=== Niveau 1 (SFN1)

#fig(
  diagram(
    spacing: 1cm,
    // Module 1
    node((0, 0), [Température @réf], name: <in1>),
    // node((0, 1), [Informations @cible (Ondes RF)], name: <in2>),
    node((2, 1), [Flux thermique], name: <out1>),
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
    edge((1, 1), <out1>, "->"),
    // Module 2
    node((0, 1), [Température @cible], name: <in3>),
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
  ),
)[SFN1 (vue holistique du système, pas en modules distincts)]

#pagebreak()
=== Premier degré

#let presentFig(f, c, body) = {
  set par(justify: true)
  grid(
    columns: (1fr, 3fr),
    rows: 1fr,
    gutter: .5em,
    body, align(horizon, fig(f, c)),
  )
}

#presentFig(image("./sf1d.v1.svg"), [SF1D])[
  Ce premier schéma fonctionnel offre une vue d’ensemble de ce que le système
  devra être capable de faire, mais dans certains cas sans se soucier de la
  façon dont ces besoins seront addressés.

  Il est un reflet direct de l’expression de besoin, auxquel ont été ajoutées
  les fonctions annexes d’alimentation et de programmation du #gls(
    "mcu",
    display: "microcontrôleur (MCU),",
  ) ainsi que la fonction principale de commande en puissance, qui apparaît
  directement nécessaire.
]

=== Second degré

#presentFig(image("./sf2d.v1.svg"), [SF2D])[second schéma fonctionnel]

=== Second degré alternatif 1

#presentFig(image("./sf2d.v2.svg"), [SF2D])[second schéma fonctionnel]

=== Second degré alternatif 2

#presentFig(image("./sf2d.v3.svg"), [SF2D])[second schéma fonctionnel]

#pagebreak()
== Description des fonctions et références de composants // TODO séparer réfs

=== Fonctions principales

==== Fonctions captage

#fig(table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, center + horizon),
  table.header([*Fonction*], [*FP2*], [Captage température]),
  [*Description / rôle*],
  table.cell(colspan: 2)[
    Deux instances, une captant la température de la @réf qui est climatisée et
    une autre captant celle de la @cible pour la comparer. Minimum capté
    $lt.eq 10 °C$, maximum capté $gt.eq 50 °C$.
  ],
  [*Signaux d’entrée*],
  table.cell(colspan: 2)[
    - Température ambiante de la pièce (référence/cible)
  ],
  [*Signaux de sortie*],
  table.cell(colspan: 2)[
    - TempRef / TempCib
  ],
))[Description de FP2]
//Références envisagées
//- Gravity AHC20 #link(
//    "https://www.mouser.fr/ProductDetail/DFRobot/SEN0528?qs=Jm2GQyTW%2FbgFUSAl1tK%252BEQ%3D%3D",
//  )[chez Mouser] (+ humidité).
//- Seeed DHT22 #link(
//    "https://www.digikey.fr/fr/products/detail/seeed-technology-co-ltd/101020932/14552870",
//  )[chez DigiKey] (+ humidité).
//- TC74A0-3.3VAT-ND #link(
//    "https://www.digikey.fr/fr/products/detail/microchip-technology/TC74A0-3-3VAT/442720",
//  )[chez DigiKey];.
//- Références avec humidité #link(
//    "https://www.digikey.fr/fr/products/filter/capteurs-d-humidité/529?s=N4IgjCBcoCwdIDGUBmBDANgZwKYBoQB7KAbRAGYBWANgE4wAOEAgdkoCZywZmQ324tXgwAM7SjGogAugQAOAFyggAygoBOASwB2AcxABfAnSihkkdNnxFSIOI1osZ8pZFUad%2Bo%2BFoMhCc0tcAmJIMhEZAyigA",
//  )[chez DigiKey];.
//- Références avec humidité chez #link(
//    "https://www.mouser.fr/c/embedded-solutions/sensor-modules/multiple-function-sensor-modules/?interface%20type=I2C~~I2C%2C%20SPI|~I2C%2C%20UART|~UART&type=Barometer%2C%20Humidity%20Sensor%20and%20Temperature%20Sensor|~CO2%2C%20Humidity%2C%20and%20Temperature%20Sensor~~CO2%2C%20Temperature%20and%20Humidity%20Sensor|~Data%20Logger%2C%20Accelerometer%2C%20Magnetometer%2C%20Humidity%2C%20Temperature%2C%20Pressure%2C%20Microphone%2C%20UV%20and%20Light%20Sensor|~Gas%2C%20Humidity%2C%20Pressure%2C%20Temperature|~Humidity%2C%20Light%2C%20Magnetic%20Flux%2C%20Temperature~~Humidity%20and%20Temperature%20Sensor|~Motion%2C%20Light%2C%20Temperature%2C%20Humidity~~Motion%2C%20Light%2C%20Temperature%2C%20Humidity%2C%20Sound&active=y&rp=embedded-solutions%2Fsensor-modules%2Fmultiple-function-sensor-modules|~Interface%20Type|~Type",
//  )[Mouser];.
//- Références #link(
//    "https://www.digikey.fr/fr/products/filter/capteurs-de-température/sortie-analogique-et-numérique/518?s=N4IgjCBcoCwdIDGUBmBDANgZwKYBoQB7KAbRAA4AGAJkoGYYQCrqBWGOpim%2B1ru1gDYAnGHJcA7K2oxKfAlOp0wjZjzri1bGIwC6BAA4AXKCADKRgE4BLAHYBzEAF8CIqKGSR02fEVIg4MWEJEH0QY1MLGwdnAjBhcmF3JFRMXAJiSDJKUKc8oA",
//  )[chez DigiKey];.
//- Références #link(
//    "https://www.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html",
//  )[Grove] Seeed Studio.

#fig(table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, center + horizon),
  table.header([*Fonction*], [*FP4*], [Interfaçage humain-machine]),
  [*Description / rôle*],
  table.cell(colspan: 2)[
    Choix binaire entre le mode été (refroidissement) et le mode hiver
    (chauffage). Idéalement, indique le mode actuellement choisi par sa position
    physique (bascule haut/bas, glissière gauche/droite…). Commutateur à
    bascule, commutateur à glissière ou boutton poussoir à auto-verrouillage.
  ],
  [*Signaux d’entrée*],
  table.cell(colspan: 2)[
    - Choix du mode par l’utilisateur (position haut ou bas)
  ],
  [*Signaux de sortie*],
  table.cell(colspan: 2)[
    - Mode
  ],
))[Description de FP4]
//Références envisagées
//- Commutateur à glissière OS102011MS2QN1 chez #link(
//    "https://www.digikey.fr/fr/products/detail/c-k/OS102011MS2QN1/411602",
//  )[DigiKey];.
//- Commutateur à bascule A107SYCQ04 #link(
//    "https://www.mouser.fr/ProductDetail/TE-Connectivity-AMP/A107SYCQ04?qs=9WkjXeXHXGz78jldEjGFKg%3D%3D",
//  )[chez Mouser];.
//- Références interrupteurs glissière #link(
//    "https://www.digikey.fr/fr/products/filter/interrupteurs-à-glissière/213?s=N4IgjCBcoGwJxVAYygMwIYBsDOBTANCAPZQDaIALGGABxwDsIhVYcATBM9ewKwgC6hAA4AXKCADKIgE4BLAHYBzEAF9CrOohApIGHAWJkQABgFqQAWjZadMgK4GSkcn34r3QA",
//  )[DigiKey];.
//- Références interrupteurs bascule #link(
//    "https://www.mouser.fr/c/electromechanical/switches/rocker-switches/?instock=y&active=y",
//  )[Mouser];.
//- Références glissière #link(
//    "https://www.mouser.fr/c/electromechanical/switches/slide-switches/?mounting%20style=Through%20Hole~~Through%20Hole%2C%20Right%20Angle&active=y&rp=electromechanical%2Fswitches%2Fslide-switches|~Mounting%20Style",
//  )[Mouser];.

==== Fonctions analogiques

// WARN N’étant pas qualifiés pour manipuler du courant d’aussi haute tension
// que celui secteur, n’est-ce pas préférable de réaliser ce projet avec un
// ventilateur en courant continu 12 V (type ventilateur d’ordinateur) ? Nous
// pouvons aussi faire l’essai avec un relais, mais qui ne sera pas connecté.

#fig(table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, center + horizon),
  table.header([*Fonction*], [*FP5*], [Commande aérateur en puissance]),
  [*Description / rôle*],
  table.cell(colspan: 2)[
    Contrôller la circulation du courant secteur (alternatif $230 V$) dans
    l’aérateur à partir du @mcu en #HIGH.
  ],
  [*Signaux d’entrée*],
  table.cell(colspan: 2)[
    - CmdAeration
    - Vac (230~V secteur)
  ],
  [*Signaux de sortie*],
  table.cell(colspan: 2)[
    - IAeration
  ],
))[Description de FP5]
//Références envisagées
//- TC209R #link(
//    "https://www.digikey.fr/fr/products/detail/bright-toward-industrial-co-ltd/TC209R/13556942",
//  )[chez Digikey];

#fig(table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, center + horizon),
  table.header([*Fonction*], [*FP5* (alt.)], [Commande aérateur en puissance]),
  [*Description / rôle*],
  table.cell(colspan: 2)[
    Contrôller la circulation du courant d’alimentation $approx 12 V$ dans
    l’aérateur à partir du @mcu en #HIGH.
  ],
  [*Signaux d’entrée*],
  table.cell(colspan: 2)[
    - CmdAeration
    - Vcc5-25 (5~V à 25~V)
  ],
  [*Signaux de sortie*],
  table.cell(colspan: 2)[IAeration],
))[Description de FP5 (alt.)]
//Références envisagées
//- Driver 1528-4489-ND #link(
//    "https://www.digikey.fr/fr/products/detail/adafruit-industries-llc/4489/11594498",
//  )[chez DigiKey];
//- Références #link(
//    "https://www.digikey.fr/fr/products/filter/gestion-de-l-alimentation-pmic/contrôleurs-variateurs-moteur/744?s=N4IgjCBcoGwJxVAYygMwIYBsDOBTANCAPZQDaIALGGABxwDsIAuoQA4AuUIAyuwE4BLAHYBzEAF9C9egCZEIFJAw4CxMiBoAGAMxwArJpCEa9GhT1HwFbVu2WZ2%2BtooJCumDIqX6e6RUOEMmB62poWgTY%2BASBB2jAGzGyckDz8wmKS4DAwXtAKaFh4hCSQ5DTaQTQwlhXOmtG1-jQ1Dv6uII2ajCwgHFy8gqIShGBwdPKKykVqpSCGTJkAtHJ5ivwArqol5BYLmdV5AgAmXItgmhBJXJbsAJ6suFzo2Cji4kA",
//  )[chez DigiKey];

#fig(table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, center + horizon),
  table.header([*Fonction*], [*FP6*], [Aération]),
  [*Description / rôle*],
  table.cell(colspan: 2)[
    Forcer l’air de la @réf à aller dans la @cible au travers d’une gaine 125~mm
    pour harmoniser leurs températures, si activé par le @mcu. Idéalement,
    encastrable dans la gaine 125~mm (pas le cas pour le premier prototype).
    // TODO à voir
  ],
  [*Signaux d’entrée*],
  table.cell(colspan: 2)[
    - IAeration
  ],
  [*Signaux de sortie*],
  table.cell(colspan: 2)[
    - Flux thermique (déplacement de l’air)
  ],
))[Description de FP6]
//Références envisagées
//- Ventilateur MEC0251V3-000U-A99 120~mm 12~V DC 2 fils #link(
//    "https://www.digikey.fr/fr/products/detail/sunon-fans/MEC0251V3-000U-A99/2021100",
//  )[chez DigiKey];.
//- Ventilateur 603-1212-ND 120~mm 12~V DC 4 fils (PWM) #link(
//    "https://www.digikey.fr/fr/products/detail/delta-electronics/AFB1212HHE-TP02/2034815",
//  )[chez DigiKey];.
//- Aérateur 125~mm #link(
//    "https://www.titan-cd.com/fr/product/TTC-SC32(A).html",
//  )[TTC-SC32(A)];, DC 12~V.
//- Phanteks 120~mm, DC 12~V PWM, référence #link(
//    "https://www.reichelt.com/fr/fr/shop/produit/ventilateur_phanteks_m25_gen2_120mm_noir-401616?utm_source=psuma&utm_medium=idealo.fr&PROVID=2842",
//  )[reichelt] ≃ 6~€
//- Arctic P12, 120~mm, DC 12~V PWM, référence #link(
//    "https://www.reichelt.com/fr/fr/shop/produit/ventilateur_pour_boitier_arctic_p12_max_120_mm-344145?utm_source=psuma&utm_medium=idealo.fr&PROVID=2842",
//  )[reichelt] ≃ 8~€
//- Manrose #link(
//    "https://www.pureventilation.com.au/buy/manrose-selv-12v-ceiling-wall-exhaust-fan-125mm/",
//  )[SELV];, AC 12~V ≃ 180~€
//- Sygonix #link(
//    "https://www.conrad.fr/fr/p/sygonix-sy-5233250-ventilateur-tubulaire-encastrable-230-v-ac-240-m-h-125-mm-2616625.html",
//  )[SY-5233248] 240 m³/h, AC 230~V ≃ 20~€
//- Airope Axial #link(
//    "https://www.manomano.fr/p/airope-inline-125-mmextracteur-dair-silencieux190-m3-h16-wconduit-en-ligneaxial-de-la-gainconome-en-nergiepour-le-bainwctoilettetenteserrecuisinebureaugaragegarantie-5-ans-66851732?model_id=70287817",
//  )[inline 125mm] 190 m³/h, AC 230~V ≃ 27~€
//- Références 12~V DC PWM #link(
//    "https://www.digikey.fr/fr/products/filter/ventilateurs/ventilateurs-cc-sans-balais-bldc/217?s=N4IgjCBcoKxaBjKAzAhgGwM4FMA0IB7KAbRAGYyAWAJmonzIE4wAGGOB5tgDhE9YBsLPuS4D65AQJgDKIsmAEB2AbwaKVjEUpiMWZAfI0wyIALr4ADgBcoIAMrWATgEsAdgHMQAX3xg50CBIkGhYeIQkINSUjDDchvjcSvG8FiA2do6unj74lIaBwaE4%2BESQpJQsqpUildUSddyUpnksSrTCre10tW201L3dLSBKLCzc8fKMyfm91Rwgld1yaRmQDs7uXr7gjNxahSgYJRHlIMJm3ldAA",
//  )[DigiKey];.
//- Références 12~V DC #link(
//    "https://www.digikey.fr/fr/products/filter/ventilateurs/ventilateurs-cc-sans-balais-bldc/217?s=N4IgjCBcpgLFoDGUBmBDANgZwKYBoQB7KAbRACZYBOAVgA4A2EAugdkbpAF0CAHAFyggAyvwBOASwB2AcxABfArCbQQySOmz4ipELAAMDOgeZ7DxiEvOwAzKYOty5fff2Pyls%2B-Kv3dgqz6%2BnSMpjZU7MquRrA0vk7wPCACQqKSsgoE9FQIaqiYuATEkGR0YDTO8ARgTuQ2TNW1NqymNR76cY1OYBBJKZAi4tJyiuBUdDmq6pqFOiUgLlzyy0A",
//  )[DigiKey];.
//- Références #link(
//    "https://www.conrad.fr/fr/o/ventilateurs-tubulaires-encastres-0812001.html?tfo_ATT_PRODSPEC_0649=125%20mm~~~12.5%20cm",
//  )[Conrad];.
//- Références aérateurs #link(
//    "https://www.leroymerlin.fr/produits/chauffage-et-ventilation/vmc-et-extracteur-air/extracteur-air/?p=1&filters={\"attribute-10854\"%3A\"120%2F125%23|125\"%7d",
//  )[Leroy Merlin];.
//- Références aérateurs 125~mm #link(
//    "https://www.manomano.fr/aerateur-1627?cat_attr_14840[min]=12&cat_attr_14840[max]=13&ls_filter=false",
//  )[ManoMano];.
//- Références bouche VMC #link(
//    "https://www.manomano.fr/bouche-vmc-2277?cat_attr_14840[min]=12&cat_attr_14840[max]=13&ls_filter=false",
//  )[ManoMano];.
//- Références 12~V #link(
//    "https://www.manomano.fr/cat/extracteur+air+12v?cat_attr_2[min]=12&cat_attr_2[max]=13&ls_filter=false",
//  )[ManoMano];.
//- #link(
//    "https://www.idealo.fr/cat/5155F2124519/ventilateurs-pour-pc.html",
//  )[Agrégation] ventilateurs PC 120~mm.
//- #link(
//    "https://www.idealo.fr/cat/28660/ventilateurs-de-salle-de-bains.html",
//  )[Agrégation] ventilateurs salle de bains.

==== Fonctions numériques

#fig(table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, center + horizon),
  table.header([*Fonction*], [*FP0*], [Traitements numériques côté référence]),
  [*Description / rôle*],
  table.cell(colspan: 2)[
    Déclencher ou stopper l’aération si les conditions sont réunies, selon les
    données rapportées par le module @cible et la température de la @réf. @mcu
    16~bit, conditionné en trou traversant, idéalement proposant des options
    basse consommation (mode veille, fréquence basse…).
  ],
  [*Signaux d’entrée*],
  table.cell(colspan: 2)[
    - TempRef
    - RxRF
  ],
  [*Signaux de sortie*],
  table.cell(colspan: 2)[
    - TxRF
    - CmdAeration
  ],
))[Description de FP0]
//Références envisagées
//- PIC24FJ256GA702-I/SP 28 broches #link(
//    "https://www.digikey.fr/fr/products/detail/microchip-technology/PIC24FJ256GA702-I-SP/6562000",
//  )[chez DigiKey];.
//- PIC24F08KL301-I/P-ND 20 broches #link(
//    "https://www.digikey.fr/fr/products/detail/microchip-technology/PIC24F08KL301-I-P/2835112ç",
//  )[chez DigiKey];.
//- PIC24F04KL100-I/P #link(
//    "https://www.digikey.fr/fr/products/detail/microchip-technology/PIC24F04KL100-I-P/2835099",
//  )[chez DigiKey];.
//- PIC24F04KL100-I/P #link(
//    "https://www.mouser.fr/ProductDetail/Microchip-Technology/PIC24F04KL100-I-P?qs=%252Bg1Dl%2FaibpHsewcuwRJLng%3D%3D",
//  )[chez Mouser];.
//- Références PIC24 #link(
//    "https://www.digikey.fr/fr/products/filter/embarqués/microcontrôleurs/685?s=N4IgjCBcoGwJxVAYygMwIYBsDOBTANCAPZQDaIALGGABxwDsIAuoQA4AuUIAyuwE4BLAHYBzEAF9CYOHUQgUkDDgLEyIAAzNJIALQU5CpXkIlI5AExwArOv2Fz5qzUb3HNGiFdW45rYR2%2B0PJQ-ACuKqbkVlraMHICACZcOmDqEGyckCCeIOwAnqy4XOjYKOLiQA",
//  )[chez DigiKey];.
//- Références PIC24 #link(
//    "https://www.mouser.fr/c/semiconductors/embedded-processors-controllers/microcontrollers-mcu/16-bit-microcontrollers-mcu/?core=PIC24E~~PIC24H&mounting%20style=Through%20Hole&active=y&rp=semiconductors%2Fembedded-processors-controllers%2Fmicrocontrollers-mcu%2F16-bit-microcontrollers-mcu|~Core|~Mounting%20Style",
//  )[chez Mouser];.
//- Références #link(
//    "https://www.microchip.com/en-us/products/microcontrollers-and-microprocessors/16-bit-mcus/pic24f-ga",
//  )[PIC24F GA] et #link(
//    "https://www.microchip.com/en-us/products/microcontrollers-and-microprocessors/16-bit-mcus/pic24f-gu-gl-gp",
//  )[PIC24 GU/GP] site Microchip.

#fig(table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, center + horizon),
  table.header([*Fonction*], [*FP1*], [Traitements numériques côté cible]),
  [*Description / rôle*],
  table.cell(colspan: 2)[
    - Mesurer
      - Température de la @cible
      - Choix du mode par l’utilisateur
    - Piloter
      - Émission sans-fil de ces informations vers le module @réf
      - Affichage des informations pour l’utilisateur

    @mcu 16~bit, conditionné en trou traversant, idéalement proposant des
    options basse consommation (mode veille, fréquence basse…).
  ],
  [*Signaux d’entrée*],
  table.cell(colspan: 2)[
    - TempCib
    - Mode
    - RxRF
  ],
  [*Signaux de sortie*],
  table.cell(colspan: 2)[
    - TxRF
  ],
))[Description de FP1]

==== Fonctions communication

#fig(table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, center + horizon),
  table.header([*Fonction*], [*FP3*], [Interfaçage RF]),
  [*Description / rôle*],
  table.cell(colspan: 2)[
    Communiquer sans-fil les informations du module de la pièce cible au module
    de la pièce référence. Idéalement, faible consommation.
  ],
  [*Signaux d’entrée*],
  table.cell(colspan: 2)[
    - TxRF
  ],
  [*Signaux de sortie*],
  table.cell(colspan: 2)[
    - RxRF
  ],
  [*Signaux E/S*],
  table.cell(colspan: 2)[
    - Ondes RF
  ],
))[Description de FP3]
//Références envisagées
//- XB3-24Z8PT-J #link(
//    "https://www.digikey.fr/fr/products/detail/digi/XB3-24Z8PT-J/8130934",
//  )[chez DigiKey];, antenne intégrée, ZigBee 3, 802.15.4, I2C, SPI, UART ≃
//  24~€
//- XB24CDMSIT-001 chez #link(
//    "https://www.mouser.fr/ProductDetail/Digi/XB24CDMSIT-001?qs=XmMZR4xR0DDHBWHJZQYv7A%3D%3D",
//  )[Mouser];, 802.15.4, Zigbee, SPI/UART ≃ 28~€
//- WRL-22630 #link(
//    "https://www.digikey.fr/fr/products/detail/sparkfun-electronics/WRL-22630/22321047",
//  )[chez DigiKey];, Bluetooth v4.2, Bluetooth v5.0, Zigbee, SPI/UART ≃
//  29~€
//- Références modules RF #link(
//    "https://www.digikey.fr/fr/products/filter/modems-et-modules-d-émetteurs-récepteurs-rf/872?s=N4IgjCBcoGwJxVAYygMwIYBsDOBTANCAPZQDaIALGGABxwDsIAuoQA4AuUIAyuwE4BLAHYBzEAF9CcGAFZEIFJAw4CxMiADMMuGBlzCWnTJjM2nSD37Cxk8DRob5i5XkIlI5AEw0Y9eyEJvX2lTEA4uXkFRCUJaGgonNCxXNQ8QeJl6MAAGAPTPGE8NBEJ6OBowDQhS8o0qPLKabI1PBvLs6gaZTyoTQgps7Pp6XP7smBy%2BynHdavSKGRp6VtLMmAdQ8ItI6xjwcoRoBSSVN3VcpnEroA",
//  )[chez DigiKey];.
//- Références modules #link(
//    "https://fr.digi.com/products/embedded-systems/digi-xbee/rf-modules",
//  )[Digri XBee] site constructeur.

#fig(table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, center + horizon),
  table.header([*Fonction*], [*FP7*], [Interfaçage machine humain]),
  [*Description / rôle*],
  table.cell(colspan: 2)[
    Afficher la température actuelle de la @cible, le mode choisi
    (chauffage/refroidissement) et l’état actuel de la ventilation.
    Éventuellement, afficher la température de la @réf.
  ],
  [*Signaux d’entrée*],
  table.cell(colspan: 2)[
    - IAeration
  ],
  [*Signaux de sortie*],
  table.cell(colspan: 2)[
    - Informations visuelles
  ],
))[Description de FP7]
//Références envisagées
//- Afficheur LCD 4411-CN0295D-ND #link(
//    "https://www.digikey.fr/fr/products/detail/sunfounder/CN0295D/18668612",
//  )[DigiKey];.
//- Références afficheurs LCD #link(
//    "https://www.digikey.fr/fr/products/filter/lcd-oled-alphanumériques/99?s=N4IgjCBcpgrALFUBjKAzAhgGwM4FMAaEAeygG0QBmWANgE4wAOEIgdlgCZKxE3PuOLEKzqtGdWCAC6RAA4AXKCADK8gE4BLAHYBzEAF8iYOuKQhUkTLkIlyIAAzT9hkDTMaAJkoC0YexDlFSBAheQBPWTwlDBxUZyA",
//  )[chez DigiKey];.

=== Fonctions annexes

==== Fonctions analogiques

// LTeX: enabled=false // Désactive la correction orthographique temporairement
#fig(table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, center + horizon),
  table.header([*Fonction*], [*FA1*], [Alimentation]),
  [*Description / rôle*],
  table.cell(colspan: 2)[
    Fournir un courant continu de #HIGH au circuit incluant le @mcu, à partir
    d’une alimentation générique fournissant du courant continu entre $5 V$ et
    $25 V$.
  ],
  [*Signaux d’entrée*],
  table.cell(colspan: 2)[
    - Vcc5-25 (5~V à 25~V)
  ],
  [*Signaux de sortie*],
  table.cell(colspan: 2)[
    - Vcc33
  ],
))[Description de FA1]
// [*Références envisagées*],
//   - Régulateur de tension linéaire LM1086CT-3.3/NOPB-ND #link(
//       "https://www.digikey.fr/fr/products/detail/texas-instruments/LM1086CT-3-3-NOPB/363571",
//     )[chez DigiKey];.
//   - IRM-10-3.3 #link(
//       "https://www.digikey.fr/fr/products/detail/mean-well-usa-inc/IRM-10-3-3/7704656",
//     )[chez DigiKey];.
//   - Références régulateurs de tension linéaires #link(
//       "https://www.digikey.fr/fr/products/filter/régulateurs-de-tension-linéaires/699?s=N4IgjCBcoGwJxVAYygMwIYBsDOBTANCAPZQDaIALGGABxwDsIAuoQA4AuUIAyuwE4BLAHYBzEAF9CYevQTQQKSBhwFiZcPSpgArCCmawAJgAMzNp0g9%2BwsZPBw6iBWix5CJSOVNNxvoA",
//     )[chez DigiKey];.

#fig(table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, center + horizon),
  table.header([*Fonction*], [*FA2*], [Alimentation commande en puissance]),
  [*Description / rôle*],
  table.cell(colspan: 2)[
    Fournir un courant continu de $approx 12 V$ à la structure d’alimentation en
    puissance, à partir d’une alimentation générique fournissant du courant
    continu entre $5 V$ et $25 V$.
  ],
  [*Signaux d’entrée*],
  table.cell(colspan: 2)[
    - Vcc5-25 (5~V à 25~V)
  ],
  [*Signaux de sortie*],
  table.cell(colspan: 2)[
    - Vcc120 (12~V)
  ],
))[Description de FA2]

#fig(table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, center + horizon),
  table.header([*Fonction*], [*FA3*], [Alimentation module cible autonome]),
  [*Description / rôle*],
  table.cell(align: left, colspan: 2)[
    Fournir un courant continu de #HIGH au module de la @cible, à partir de
    piles (ou d’une batterie).
  ],
  [*Signaux d’entrée*],
  table.cell(colspan: 2)[
    - Batterie
  ],
  [*Signaux de sortie*],
  table.cell(colspan: 2)[
    - Vcc33
  ],
))[Description de FA3]

==== Fonctions numériques // TODO Fonction numérique ?

#fig(table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, center + horizon),
  table.header([*Fonction*], [*FA0*], [Programmation in-situ]),
  [*Description / rôle*],
  table.cell(colspan: 2)[
    Programmer le @mcu en le laissant soudé au ciruit imprimé ou placé sur la
    breadboard. Programmateur adapté au @mcu choisi, par exemple PICKit pour un
    @mcu PIC24.
  ],
  [*Signaux de sortie*],
  table.cell(colspan: 2)[
    - MCUR
  ],
  [*Signaux E/S*],
  table.cell(colspan: 2)[
    - Données (communication avec ordinateur via USB)
    - PGD
    - PGC
  ],
))[Description de FA0]

== Description des signaux // TODO infos manquantes

// #show table.cell.where(colspan: 9): set align(left)

#fig(table(
  columns: 10,
  align: center + horizon,
  table.header(
    table.cell(rowspan: 2)[*Signal*],
    [*Fonctions concernées*],
    [*Nature du signal\ (A/N/GP)*],
    [*Taille entité*],
    [*Grandeur et unité\ (U, I…)*],
    [*Plage de variation - Niveaux*],
    [*Excursion en fréquence*],
    [*Valeur au repos*],
    [*Contraintes temporelles*],
    [*Conformité à une norme*],
    table.cell(colspan: 9)[*Description*],
  ),
  table.cell(rowspan: 2)[TempRef],
  [FP2→FP0],
  [N],
  // TODO, valeurs provisoires
  [1],
  [U (V)],
  [#LOW à #HIGH],
  [< 1 Hz],
  [#LOW],
  [N~/~A],
  [I²C / SPI],
  table.cell(colspan: 9)[
    Signal fournissant la température de la @réf.
  ],
  table.cell(rowspan: 2)[TempCib],
  [FP2→FP1],
  [N],
  // TODO, valeurs provisoires
  [1],
  [U (V)],
  [#LOW à #HIGH],
  [< 1 Hz],
  [#LOW],
  [N~/~A],
  [I²C / SPI],
  table.cell(colspan: 9)[
    Signal fournissant la température de la @cible.
  ],
  table.cell(rowspan: 2)[TxRF],
  [FP0→FP3\ FP1→FP3],
  [N],
  // TODO, valeurs provisoires
  [1],
  [U (V)],
  [#LOW à #HIGH],
  [< 1 Hz],
  [#LOW],
  [N~/~A],
  [I²C / SPI],
  table.cell(colspan: 9)[
    Données que le microcontrôleur envoie pour transmission au travers du module
    sans-fil.
  ],
  table.cell(rowspan: 2)[RxRF],
  [FP3→FP0\ FP3→FP1],
  [N],
  // TODO, valeurs provisoires
  [1],
  [U (V)],
  [#LOW à #HIGH],
  [< 1 Hz],
  [#LOW],
  [N~/~A],
  [I²C / SPI],
  table.cell(colspan: 9)[
    Données que le microcontrôleur reçoit depuis le module sans-fil.
  ],
  table.cell(rowspan: 2)[Mode],
  [FP4→FP1],
  [N],
  // TODO, valeurs provisoires
  [2],
  [U (V)],
  [#LOW / #HIGH\ Hiver / Été],
  [\<~1~Hz],
  [#LOW\ (0 logique)],
  [N~/~A],
  [I²C / SPI],
  table.cell(colspan: 9)[
    Bloquant (0) pour le mode hiver (chauffage), passant (1) pour le mode été
    (refroidissement).
  ],
))[Description des signaux (1~/~2)]

#fig(table(
  columns: 10,
  align: center + horizon,
  table.header(
    table.cell(rowspan: 2)[*Signal*],
    [*Fonctions concernées*],
    [*Nature du signal\ (A/N/GP)*],
    [*Taille entité*],
    [*Grandeur et unité\ (U, I…)*],
    [*Plage de variation - Niveaux*],
    [*Excursion en fréquence*],
    [*Valeur au repos*],
    [*Contraintes temporelles*],
    [*Conformité à une norme*],
    table.cell(colspan: 9)[*Description*],
  ),
  table.cell(rowspan: 2)[CmdAeration],
  [FP0→FP5],
  [A],
  // TODO, valeurs provisoires
  [2],
  [U (V)],
  [#LOW / #HIGH\ KO / OK],
  [\< 1~Hz],
  [0~V (bloquant)],
  [N~/~A],
  [N~/~A],
  table.cell(colspan: 9)[
    Bloque l’alimentation de l’aérateur à 0, laisse passer l’alimentation de
    l’aérateur à 1.
  ],
  table.cell(rowspan: 2)[IAeration],
  [FP5→FP6],
  [A],
  [2],
  [I (A)],
  [0 / 230~V\ KO / OK],
  [\< 1~Hz],
  [#LOW],
  [N~/~A],
  [N~/~A],
  table.cell(colspan: 9)[
    Puissance nécessaire pour actionner le mouvement de l’aérateur.
  ],
  table.cell(rowspan: 2)[Vcc33],
  [FA1→Tous],
  [A],
  [1],
  [U (V)],
  [#HIGH$plus.minus 10 %$],
  [N~/~A],
  [N~/~A],
  [N~/~A],
  [N~/~A],
  table.cell(colspan: 9)[Alimentation en énergie électrique des composants.],
  table.cell(rowspan: 2)[Vcc5-25],
  [FA1, FP5],
  [A],
  [1],
  [U (V)],
  [5~V à 25~V],
  [N~/~A],
  [N~/~A],
  [N~/~A],
  [N~/~A],
  table.cell(colspan: 9)[
    Courant continu fourni par une alimentation générique, à adapter à notre
    circuit précisément.
  ],
  table.cell(rowspan: 2)[Température pièce référence],
  [FP2 (réf)],
  [GP],
  [1],
  [T (°C)],
  [0~°C à 50~°C],
  [N~/~A],
  [N~/~A],
  [N~/~A],
  [N~/~A],
  table.cell(colspan: 9)[Température de la pièce de référence (climatisée).],
  table.cell(rowspan: 2)[Ondes RF],
  [FP3],
  [A],
  [1],
  [N~/~A],
  [N~/~A],
  [N~/~A],
  [Absent],
  [N~/~A],
  [N~/~A],
  table.cell(colspan: 9)[Communications sans-fils entre les deux modules.],
  table.cell(rowspan: 2)[Température pièce cible],
  [FP2 (cib)],
  [GP],
  [1],
  [T (°C)],
  [0~°C à 50~°C],
  [N~/~A],
  [N~/~A],
  [N~/~A],
  [N~/~A],
  table.cell(colspan: 9)[Température de la pièce cible (où l’on souhaite
    profiter de la climatisation de l’autre pièce).],
  table.cell(rowspan: 2)[Choix mode utilisateur],
  [FP4],
  [GP],
  [2],
  [N~/~A],
  [Haut / Bas],
  [< 1 Hz],
  [N~/~A],
  [N~/~A],
  [N~/~A],
  table.cell(colspan: 9)[Choix du mode par l’utilisateur en positionnant un
    interrupteur en haut ou en bas.],
  table.cell(rowspan: 2)[Flux thermique],
  [FP6],
  [GP],
  [1],
  [N~/~A],
  // [P (Pa)],
  [0~°C à 50~°C],
  [N~/~A],
  [N~/~A],
  [N~/~A],
  [N~/~A],
  table.cell(colspan: 9)[Flux d’air entrainé par l’aérateur depuis la pièce
    référence vers la pièce cible.],
))[Description des signaux (2~/~2)]

// LTeX: enabled=true // Réactive la correction orthographique

// == Contraintes // TODO À voir

// == Cahier des charges fonctionnel // TODO À voir

// == Performances attendues // TODO À voir
