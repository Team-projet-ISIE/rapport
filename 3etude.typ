// LTeX: language=fr
= Veille technologique

// WARNING
// #align(center, text(size: 16pt, fill: red)[Brouillon encore. Des trucs à
//   ajouter/modifier ?])

== Captage

=== Température

==== Adafruit DHT20 (#link("https://www.mouser.fr/ProductDetail/DFRobot/SEN0528?qs=Jm2GQyTW%2FbgFUSAl1tK%252BEQ%3D%3D")[Mouser])

Ce capteur est largement assez précis pour notre cas et combine la mesure de
température et d'humidité, ce qui est un plus pour évaluer la qualité de l'air.

Il utilise une interface I#super[2]C, bus de communication standard et facile à
mettre en œuvre avec la plupart des microcontrôleurs, ne nécessitant que deux
broches.

Sa consommation relativement faible, de l'ordre de quelques microampères en
veille.

Néanmoins, peut être légèrement plus cher qu'un capteur de température seul.

==== Seeed DHT22 (#link("https://www.digikey.fr/fr/products/detail/seeed-technology-co-ltd/101020932/14552870")[DigiKey])

Capteur populaire et peu coûteux qui mesure également la température et
l'humidité.

Néanmoins, il utilise un protocole de communication propriétaire sur un seul fil
qui apparait comme très sensible au timing. La lecture des données peut être peu
fiable sur des systèmes non-temps-réel ou si le microcontrôleur est occupé.

Sa consommation en mesure est plus élevée que celle du DHT20.

==== Microchip TC74A0 (#link("https://www.digikey.fr/fr/products/detail/microchip-technology/TC74A0-3-3VAT/442720")[DigiKey])

Simple, peu cher, et très basse consommation (quelques µA).

Interface I#super[2]C.

Ne mesure pas l'humidité, ce qui n’est pas une demande explicite du projet, mais
qui pourrait se reveler utile à l’avenir.

=== Interaction humaine

==== Commutateur à glissière OS102011MS2QN1 (#link("https://www.digikey.fr/fr/products/detail/c-k/OS102011MS2QN1/411602")[DigiKey])

Simple, peu coûteux, fournit une indication visuelle claire de son état
(On/Off).

Peut-être moins esthétique qu'un bouton à bascule (subjectif).

==== Commutateur à bascule A107SYCQ04 (#link("https://www.mouser.fr/ProductDetail/TE-Connectivity-AMP/A107SYCQ04?qs=9WkjXeXHXGz78jldEjGFKg%3D%3D")[Mouser])

Fonctionnellement similaire au commutateur à glissière, mais avec une ergonomie
différente (bascule).

Celui-ci est un modèle (On)-Off-(On) momentané, ce qui pourrait être utile pour
naviguer dans un menu simple (ex: augmenter/diminuer une consigne). Moins adapté
pour un simple interrupteur entre deux états (On/Off) permanent.

Peut être perçu comme plus qualitatif.

== Analogique

=== Commande en puissance

==== CA 230~V

// - Relais de puissance G5LE-14 DC3 #link(
//     "https://www.digikey.fr/fr/products/detail/omron-electronics-inc-emc-div/G5LE-14-DC3/1815628",
//   )[chez Digikey]
// - Relais de puissance AWHSH112DM00G #link(
//     "https://www.digikey.fr/fr/products/detail/amphenol-anytek/AWHSH112DM00G/16721953",
//   )[chez Digikey]
// - Relais statique AZ943-1AH-12DEF #link(
//     "https://www.digikey.fr/fr/products/detail/american-zettler/AZ943-1AH-12DEF/14307629",
//   )[chez Digikey]
// - Relais statique AZ943-1AH-12DEF #link(
//     "https://www.digikey.fr/fr/products/detail/american-zettler/AZ943-1AH-12DEF/14307629",
//   )[chez Digikey]
// - Relais statique J107F1CS1212VDC.36 #link(
//     "https://www.digikey.fr/fr/products/detail/cit-relay-and-switch/J107F1CS1212VDC-36/12502789",
//   )[chez Digikey]

===== Relais de puissance G5LE-14 DC3 (#link("https://www.digikey.fr/fr/products/detail/omron-electronics-inc-emc-div/G5LE-14-DC3/1815628")[Digikey])

Faible courant de bobine (3~V CC), réduit la consommation du circuit de
commande.

Pouvoir de coupure élevé (10~A 250~V CA), suffisant pour un aérateur domestique.

Isolation diélectrique élevée (5000~V CA), assurant une bonne sécurité entre le
circuit de commande basse tension et le circuit de puissance 230~V CA.

Électromécanique, implique une usure mécanique au fil du temps, un bruit audible
lors de l'activation/désactivation et un temps de commutation plus lent par
rapport aux relais statiques.

===== Relais de puissance AWHSH112DM00G (#link("https://www.digikey.fr/fr/products/detail/amphenol-anytek/AWHSH112DM00G/16721953")[Digikey])

Tension de bobine de 12~V CC, compatible avec une alimentation 12~V CC. Courant
de coupure de 10A 250~V AC.

Consommation de la bobine (typ. 360~mW 12~V CC) environ 3 fois plus élevée.

Nécessite un driver ou une alimentation 12~V distincte pour la bobine.

===== Relais statique AZ943-1AH-12DEF (#link("https://www.digikey.fr/fr/products/detail/american-zettler/AZ943-1AH-12DEF/14307629")[Digikey])

Relais statique~: pas d’usure, pas de bruit, commutation plus rapide.

Tension de contrôle de 12~V CC, courant de charge de 2~A 240~V AC (suffisant).

Chute de tension à l'état passant (ON-state voltage drop) qui entraîne une
dissipation de puissance sous forme de chaleur. Pour 2~A, cela pourrait
nécessiter un dissipateur de chaleur léger, même si l'aérateur consomme moins.

Coût généralement plus élevé.

==== MOSFET

===== IRLZ44NPBF (#link("https://www.digikey.fr/fr/products/detail/infineon-technologies/IRLZ44NPBF/811808")[Digikey])

Une faible résistance à l'état passant $"Rds"("on")$ signifie une dissipation de
chaleur minimale et une bonne efficacité énergétique. Peut être directement
piloté par les signaux 3.3V ou 5V de la plupart des microcontrôleurs.

Attention, n'intègre pas de diode de roue libre en parallèle avec le
ventilateur, qui est cruciale pour protéger le circuit de commande contre les
pics de tension lorsque le ventilateur est éteint (dû à la bobine du moteur).

==== CC 12~V

===== Driver Adafruit 4489 (#link("https://www.digikey.fr/fr/products/detail/adafruit-industries-llc/4489/11594498")[DigiKey])

===== Driver TB6615PG8-ND (#link("https://www.digikey.fr/fr/products/detail/toshiba-semiconductor-and-storage/TB6615PG-8/7809551")[Digikey])

=== Aération

==== Alimentée en CA 230~V

===== Sygonix SY-5233248 (#link("https://www.conrad.fr/fr/p/sygonix-sy-5233250-ventilateur-tubulaire-encastrable-230-v-ac-240-m-h-125-mm-2616625.html")[Conrad])

240 m³/h.

Attention à la consommation et au bruit qui ne sont pas indiqués.

===== Airope Axial inline 125mm (#link("https://www.manomano.fr/p/airope-inline-125-mmextracteur-dair-silencieux190-m3-h16-wconduit-en-ligneaxial-de-la-gainconome-en-nergiepour-le-bainwctoilettetenteserrecuisinebureaugaragegarantie-5-ans-66851732?model_id=70287817")[ManoMano])

190 m³/h.

Attention à la consommation et au bruit qui ne sont pas indiqués.

==== Alimentée en 12~V

===== Manrose SELV (#link("https://www.pureventilation.com.au/buy/manrose-selv-12v-ceiling-wall-exhaust-fan-125mm")[PureVentilation])

Ventilateur adapté aux gaines 125~mm mais utilisable directement par nous en
12~V sans habilitation particulière. Malheureusement, très cher (≃ 180 €), et le
12V CA semble peu commun.

===== Ventilateur MEC0251V3-000U-A99 (#link("https://www.digikey.fr/fr/products/detail/sunon-fans/MEC0251V3-000U-A99/2021100")[DigiKey])

Simple à alimenter~: 12~V pour le faire tourner, 0~V pour l'arrêter.

En revanche, pas de contrôle de vitesse possible, sauf à faire varier la tension
d'alimentation, ce qui est peu efficace. Cela n’est pas un problème car en
général les aérateurs ne sont pas réglables en vitesse.

===== Ventilateur 603-1212 (#link("https://www.digikey.fr/fr/products/detail/delta-electronics/AFB1212HHE-TP02/2034815")[DigiKey])

Le 4ème fil (PWM) permet un contrôle précis de la vitesse de rotation. Cela
permettrait une ventilation proportionnelle à la température, plus silencieuse
et plus économique en énergie qu'un simple On/Off. Le 3ème fil (tachymètre)
permet de vérifier que le ventilateur tourne bien.

Mais, légèrement plus complexe à piloter (nécessite une sortie PWM du
microcontrôleur), pour un gain limité dans notre cas.

=== Régulation de tension

==== Régulateur de tension linéaire #link("https://www.digikey.fr/fr/products/detail/analog-devices-inc/LT1085CT-3-3-PBF/889588")[LM1085CT-3.3]/#link("https://www.digikey.fr/fr/products/detail/texas-instruments/LM1086CT-3-3-NOPB/363571")[LM1086CT-3.3]

Régulateur linéaire basse chute de tension (LDO) qui délivre une tension fixe de
3.3~V avec un courant de sortie maximal de 1.5~A. Il présente l’avantage d’un
bruit de sortie très faible. Cependant, son rendement est relativement bas,
notamment lorsque la tension d’entrée est significativement supérieure à la
tension de sortie comme dans notre cas 12V → 3.3V. Cette différence de potentiel
entraîne une forte dissipation thermique, et donc une perte énergétique
importante, rendant souvent nécessaire l’ajout d’un dissipateur thermique.

De plus, le courant de repos est élevé (typ. 5-10~mA).

Nous estimons le coût à 2,01 € (régulateur) + 0,60 € (condensateurs) + 1,50 €
(dissipateur) = 4,11 €.

==== Régulateur de tension linéaire LM2574N-3.3

Régulateur à découpage step-down (buck) capable de fournir une tension fixe de
3.3~V avec un courant de sortie maximal garanti de 500~mA. Contrairement au
LM1086, ce composant fonctionne par hachage et présente un rendement énergétique
élevé (jusqu'à 80-90%), ce qui limite la dissipation thermique. Il nécessite
cependant l’ajout de composants externes comme une inductance, une diode de roue
libre et des condensateurs adaptés.

Nous estimons son coût à 3,38 € (régulateur) + 0,60 € (condensateurs) + 0,30 €
(diode) + 1,52 € (inductance) = 5,80 €.

==== Régulateur de tension linéaire LE33CZ-TR (#link("https://www.digikey.fr/fr/products/detail/stmicroelectronics/LE33CZ-TR/725169")[DigiKey])

Régulateur ayant un courant de repos très faible (Iq ≤ 5 µA en veille), ce qui
est intéressant pour un appareil sur batterie ou basse consommation. Capacité en
courant (100 mA) largement suffisante pour le microcontrôleur et les capteurs.

==== Régulateur de tension linéaire MP2307

Rendement très élevé (>90%). Si l'alimentation principale est en 12V, un
régulateur linéaire dissipera (12V - 3.3V) × I en chaleur, ce qui est très
inefficace. Un régulateur à découpage ne chauffe quasiment pas.

Peut permettre de maximiser l'efficacité énergétique.

== Numérique

=== Microcontrôleur

==== PIC24FJ256GA702 28 broches #link("https://www.digikey.fr/fr/products/detail/microchip-technology/PIC24FJ256GA702-I-SP/6562000")[DigiKey]

==== PIC24F08KL301 20 broches #link("https://www.digikey.fr/fr/products/detail/microchip-technology/PIC24F08KL301-I-P/2835112ç")[DigiKey]

==== PIC24F04KA200 14 broches #link("https://www.digikey.fr/fr/products/detail/microchip-technology/PIC24F04KA200-I-P/2125573")[DigiKey]

== Communication

==== Digi XB3-24Z8PT-J (#link("https://www.digikey.fr/fr/products/detail/digi/XB3-24Z8PT-J/8130934")[DigiKey])

Module moderne et puissant. Supporte Zigbee 3.0, qui est intéressant pour le
maillage réseau (les modules se relaient les informations).

==== Digi XB24CDMSIT-001 (#link("https://www.mouser.fr/ProductDetail/Digi/XB24CDMSIT-001?qs=XmMZR4xR0DDHBWHJZQYv7A%3D%3D")[Mouser])

Semble très populaire pour des réseaux Zigbee simples et robustes. Facile à
utiliser en "mode transparent" via l'UART~: ce qui est envoyé sur l'UART d'un
module sort sur l'UART de l'autre. Bien documenté et supporté.

Néanmoins, moins de fonctionnalités que le XBee 3.

==== Digi WRL-22630 (#link("https://www.digikey.fr/fr/products/detail/sparkfun-electronics/WRL-22630/22321047")[DigiKey])

Module performant, supportant Bluetooth LE, Thread, et Zigbee.

=== Affichage

==== Afficheur LCD CN0295D (#link("https://www.digikey.fr/fr/products/detail/sunfounder/CN0295D/18668612")[DigiKey])

==== Afficheur FSTN NHD-C0220BIZ (#link("https://www.digikey.fr/fr/products/detail/newhaven-display-international-limited/NHD-C0220BIZ-FSW-FBW-3V3M/2626407")[Digikey])
// Points forts : Afficheur caractères standard (probablement 16x2 ou 20x4) avec
// une interface I#super[2]C, ce qui le rend facile à piloter. Peu coûteux.

// Points faibles : Consommation électrique élevée, surtout à cause du
// rétroéclairage (backlight) qui peut consommer 20-30 mA à lui seul. C'est un
// point critique pour un système basse consommation.

// Pertinence : Mauvais choix pour la basse consommation si l'affichage doit être
// permanent.
// Points forts : La technologie FSTN (un type de LCD passif) est conçue pour une
// très faible consommation. Le contraste est souvent meilleur que sur les LCD
// standards. Il peut fonctionner sans rétroéclairage.

// Points faibles : Peut-être un peu plus cher.

// Pertinence : Le choix idéal pour un afficheur dans un projet basse consommation.
// Sa très faible consommation est un atout décisif.
