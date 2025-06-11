// LTeX: language=fr
= Étude de l'existant

== Captage

=== Température

==== Gravity AHC20

#link(
  "https://www.mouser.fr/ProductDetail/DFRobot/SEN0528?qs=Jm2GQyTW%2FbgFUSAl1tK%252BEQ%3D%3D",
)[Lien Mouser]

Ce capteur est précis, stable et combine la mesure de température et d'humidité,
ce qui est un plus pour évaluer la qualité de l'air. Il utilise une interface
I²C, qui est un bus de communication standard et facile à mettre en œuvre avec
la plupart des microcontrôleurs, ne nécessitant que deux broches. Sa
consommation est très faible, de l'ordre de quelques microampères en veille.

Néanmoins, peut être légèrement plus cher qu'un capteur de température seul.

Pour la mesure de température et d'humidité dans notre système, le choix s'est
porté sur le capteur DHT20, principalement pour ses performances améliorées par
rapport à son prédécesseur le DHT11, ainsi que pour sa compatibilité avec les
microcontrôleurs via une interface I²C standard. Ce capteur fonctionne avec une
tension d'alimentation comprise entre 2.2V et 5.5V, ce qui le rend adaptable
aussi bien aux systèmes en 3.3V qu’en 5V. En plus d’une large plage de
fonctionnement, il présente une consommation très faible : seulement 250 nA en
veille et 980 µA en fonctionnement, ce qui est particulièrement avantageux pour
les applications alimentées sur batterie ou nécessitant une faible consommation
énergétique. Il présente une plage de mesure pour la température allant de -40
°C à +80 °C, avec une résolution de 0.01 °C.

Le DHT20 offre une précision de ±0.5°C pour la température, ce qui est suffisant
pour notre usage puisque la précision est demande au dégrée près. Ce capteur
communique via le protocole I²C, avec une adresse esclave par défaut de 0x38. Il
est recommandé d’utiliser des résistances de pull-up (typiquement 4.7 kΩ) sur
les lignes SDA et SCL, et de placer un condensateur de découplage de 100 nF
entre VDD et GND, au plus près du capteur.

==== Seeed DHT22

#link(
  "https://www.digikey.fr/fr/products/detail/seeed-technology-co-ltd/101020932/14552870",
)[Lien DigiKey]

Capteur très populaire et peu coûteux qui mesure également la température et
l'humidité.

Néanmoins, il utilise un protocole de communication propriétaire sur un seul fil
qui est très sensible au timing. La lecture des données peut être peu fiable sur
des systèmes non-temps-réel ou si le microcontrôleur est occupé. Sa consommation
en mesure est plus élevée que celle de l'AHT20.

==== TC74A0-3.3VAT-ND

#link(
  "https://www.digikey.fr/fr/products/detail/microchip-technology/TC74A0-3-3VAT/442720",
)[Lien DigiKey].

Très simple, très peu cher, et extrêmement basse consommation (quelques µA). Son
interface I2C le rend facile à intégrer. C'est un choix solide si seule la
température est nécessaire.

Ne mesure pas l'humidité, ce qui est une limitation si ce paramètre devient
pertinent pour déclencher l'aération.

=== Interaction humaine

==== Commutateur à glissière OS102011MS2QN1

#link(
  "https://www.digikey.fr/fr/products/detail/c-k/OS102011MS2QN1/411602",
)[Lien DigiKey]

Simple, peu coûteux, et fournit une indication visuelle claire de son état
(On/Off). Idéal pour un interrupteur de configuration (ex: "Mode forcé", "Mode
auto").

Peut-être moins esthétique qu'un bouton à bascule selon le design du boîtier.

==== Commutateur à bascule A107SYCQ04

#link(
  "https://www.mouser.fr/ProductDetail/TE-Connectivity-AMP/A107SYCQ04?qs=9WkjXeXHXGz78jldEjGFKg%3D%3D",
)[Lien Mouser]

Fonctionnellement similaire au commutateur à glissière, mais avec une ergonomie
différente (bascule). Peut être perçu comme plus qualitatif. Celui-ci est un
modèle (On)-Off-(On) momentané, ce qui pourrait être utile pour naviguer dans un
menu simple (ex: augmenter/diminuer une consigne).

Le caractère momentané de ce modèle le rend inadapté pour un simple interrupteur
On/Off permanent.

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

===== Relais de puissance G5LE-14 DC3 (Omron Electronics Inc-EMC Div)

#link(
  "https://www.digikey.fr/fr/products/detail/omron-electronics-inc-emc-div/G5LE-14-DC3/1815628",
)[Lien Digikey]

Faible courant de bobine (3V DC), réduit la consommation du circuit de commande.

Pouvoir de coupure élevé (10A 250VAC), suffisant pour un aérateur domestique.

Isolation diélectrique élevée (5000 VAC), assurant une bonne sécurité entre le
circuit de commande basse tension et le circuit de puissance 230_V CA.

Électromécanique, implique une usure mécanique au fil du temps, un bruit audible
lors de l'activation/désactivation et un temps de commutation plus lent par
rapport aux relais statiques.

===== Relais de puissance AWHSH112DM00G (Amphenol Anytek)

#link(
  "https://www.digikey.fr/fr/products/detail/amphenol-anytek/AWHSH112DM00G/16721953",
)[Lien Digikey]

Tension de bobine de 12V DC, compatible avec une alimentation 12V DC. Courant de
coupure de 10A 250~Vac.

Consommation de la bobine (typ. 360mW 12V DC) environ 3 fois plus élevée.

Nécessite un driver ou une alimentation 12V distincte pour la bobine.

==== Relais statique AZ943-1AH-12DEF (American Zettler)

#link(
  "https://www.digikey.fr/fr/products/detail/american-zettler/AZ943-1AH-12DEF/14307629",
)[Lien Digikey]

Relais statique~: pas d’usure, pas de bruit, commutation plus rapide.

Tension de contrôle de 12V DC, courant de charge de 2A 240~Vac (suffisant).

Chute de tension à l'état passant (ON-state voltage drop) qui entraîne une
dissipation de puissance sous forme de chaleur. Pour 2A, cela pourrait
nécessiter un dissipateur de chaleur léger, même si l'aérateur consomme moins.

Coût généralement plus élevé.

==== MOSFET (nécessaire sur les relais à bobine)

===== IRLZ44NPBF

#link(
  "https://www.digikey.fr/fr/products/detail/infineon-technologies/IRLZ44NPBF/811808",
)[Lien Digikey]

Une faible résistance à l'état passant (Rds(on)) signifie une dissipation de
chaleur minimale et une bonne efficacité énergétique. Peut être directement
piloté par les signaux 3.3V ou 5V de la plupart des microcontrôleurs.

Mais, n'intègre pas une diode de roue libre (flyback diode) en parallèle avec le
ventilateur, qui est cruciale pour protéger le MOSFET contre les pics de tension
lorsque le ventilateur est éteint (dû à la bobine du moteur).

==== CC 12~V

===== Driver Adafruit 4489

#link(
  "https://www.digikey.fr/fr/products/detail/adafruit-industries-llc/4489/11594498",
)[Lien DigiKey]

===== Driver TB6615PG8-ND

#link(
  "https://www.digikey.fr/fr/products/detail/toshiba-semiconductor-and-storage/TB6615PG-8/7809551",
)[Lien Digikey]

=== Aération

==== Alimentée en CA 230~V

===== Sygonix SY-5233248

#link(
  "https://www.conrad.fr/fr/p/sygonix-sy-5233250-ventilateur-tubulaire-encastrable-230-v-ac-240-m-h-125-mm-2616625.html",
)[Lien Conrad]

Bon rapport débit/prix (240 m³/h pour ≃ 20 €), alimentation secteur 230V.

Voir à l’usage la consommation et le bruit.

===== Airope Axial inline 125mm

#link(
  "https://www.manomano.fr/p/airope-inline-125-mmextracteur-dair-silencieux190-m3-h16-wconduit-en-ligneaxial-de-la-gainconome-en-nergiepour-le-bainwctoilettetenteserrecuisinebureaugaragegarantie-5-ans-66851732?model_id=70287817",
)[Lien ManoMano]

Bon compromis débit/prix, 16~W, débit légèrement inférieur au Sygonix.

==== Alimentée en 12~V

===== Manrose SELV

#link(
  "https://www.pureventilation.com.au/buy/manrose-selv-12v-ceiling-wall-exhaust-fan-125mm",
)[Lien PureVentilation]

Ventilateur adapté aux gaines 125~mm mais utilisable directement par nous sans
habilitation particulière. Malheureusement, très cher (≃ 180 €), et le 12V AC
semble peu commun.

===== Ventilateur MEC0251V3-000U-A99

#link(
  "https://www.digikey.fr/fr/products/detail/sunon-fans/MEC0251V3-000U-A99/2021100",
)[Lien DigiKey]

Simple à alimenter : 12V pour le faire tourner, 0V pour l'arrêter.

En revanche, pas de contrôle de vitesse possible, sauf à faire varier la tension
d'alimentation, ce qui est peu efficace. Cela n’est pas un problème car en
général les aérateurs ne sont pas réglables en vitesse.

===== Ventilateur 603-1212-ND

#link(
  "https://www.digikey.fr/fr/products/detail/delta-electronics/AFB1212HHE-TP02/2034815",
)[Lien DigiKey]

Le 4ème fil (PWM) permet un contrôle précis de la vitesse de rotation. Cela
permettrait une ventilation proportionnelle à la température, plus silencieuse
et plus économique en énergie qu'un simple On/Off. Le 3ème fil (tachymètre)
permet de vérifier que le ventilateur tourne bien.

Mais, légèrement plus complexe à piloter (nécessite une sortie PWM du
microcontrôleur).

=== Régulation de tension

==== Régulateur de tension linéaire LM1085CT-3.3/LM1086CT-3.3

#link(
  "https://www.digikey.fr/fr/products/detail/analog-devices-inc/LT1085CT-3-3-PBF/889588",
)[LM1085 chez DigiKey],
#link(
  "https://www.digikey.fr/fr/products/detail/texas-instruments/LM1086CT-3-3-NOPB/363571",
)[LM1086 chez DigiKey]

Régulateur linéaire basse chute de tension (LDO) qui délivre une tension fixe de
3.3V avec un courant de sortie maximal de 1.5 A. Il présente l’avantage d’un
bruit de sortie très faible. Cependant, son rendement est relativement bas,
notamment lorsque la tension d’entrée est significativement supérieure à la
tension de sortie comme dans notre cas 12V → 3.3V. Cette différence de potentiel
entraîne une forte dissipation thermique, et donc une perte énergétique
importante, rendant souvent nécessaire l’ajout d’un dissipateur thermique.

De plus, le courant de repos très élevé (typ. 5-10 mA), alors que le système
risque de passer un certain temps en repos.

Nous estimons le coût à 2,01 € (régulateur) + 0,60 € (condensateurs) + 1,50 €
(dissipateur) = 4,11 €.

==== Régulateur de tension linéaire LM2574N-3.3

Régulateur à découpage step-down (buck) capable de fournir une tension fixe de
3.3V avec un courant de sortie maximal garanti de 500 mA. Contrairement au
LM1086, ce composant fonctionne par hachage et présente un rendement énergétique
élevé (jusqu'à 80-90%), ce qui limite la dissipation thermique. Il nécessite
cependant l’ajout de composants externes comme une inductance, une diode de roue
libre et des condensateurs adaptés.

Nous estimons son coût à 3,38 € (régulateur) + 0,60 € (condensateurs) + 0,30 €
(diode) + 1,52 € (inductance) = 5,80 €.

==== Régulateur de tension linéaire LE33CZ-TR

#link(
  "https://www.digikey.fr/fr/products/detail/stmicroelectronics/LE33CZ-TR/725169",
)[Lien DigiKey]

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

- PIC24FJ256GA702-I/SP 28 broches #link(
    "https://www.digikey.fr/fr/products/detail/microchip-technology/PIC24FJ256GA702-I-SP/6562000",
  )[Lien DigiKey]

- PIC24F08KL301-I/P-ND 20 broches #link(
    "https://www.digikey.fr/fr/products/detail/microchip-technology/PIC24F08KL301-I-P/2835112ç",
  )[Lien DigiKey]

Nous avons sélectionne le microcontrôleur PIC24F04KA200 pour notre projet en
raison de son excellent compromis entre performances, consommation énergétique,
et facilité d’intégration, et son prix.

Le PIC24F04KA200 appartient à la famille des PIC24, avec une architecture 16
bits plus puissante que les microcontrôleurs 8 bits classiques, maintenant
obsolète. Cette caractéristique est essentielle pour gérer efficacement les
tâches temps réel, notamment la lecture des capteurs de température, la gestion
des entrées utilisateurs (boutons, interrupteurs) et la communication sans fil
via le module Zigbee.

La consommation énergétique est également un critère important. Le PIC24F04KA200
dispose de modes basse consommation (Sleep, Idle) qui permettent de limiter la
consommation lors des périodes d’inactivité, un atout essentiel pour un système
fonctionnant en continu, notamment lorsqu’il communique via Zigbee. Cette
gestion fine de l’énergie contribue à optimiser l’autonomie, surtout dans un
contexte d’optimisation énergétique.

Le microcontrôleur intègre des périphériques adaptés facilitant la gestion de
nombreuses entrées/ sorties numériques permet de contrôler sans difficulté les
boutons poussoirs, LEDs, ainsi que le ventilateur via des transistors. De plus,
ses interfaces série comme l’I2C, l’UART ou le SPI simplifient la communication
avec le module Zigbee et l’écran LCD, et le capteur de temperature, réduisant la
complexité matérielle et logicielle du projet.

La facilité de programmation est un autre point fort. En effet, la programmation
In-Circuit (ICSP), permet le développement et la mise à jour rapides ce qui
facilite le prototypage et la maintenance.

Enfin, pour notre projet, la mémoire Flash et la RAM du PIC24F04KA200 sont
adaptées car la complexité du programme reste modérée. En effet, le
microcontrôleur doit gérer la lecture des capteurs de température, le contrôle
de l’affichage LCD, la gestion des boutons poussoirs, ainsi que la communication
Zigbee, tâches qui ne nécessitent pas un volume important de mémoire. Cette
capacité mémoire permet d’assurer un fonctionnement fluide tout en gardant une
marge pour l’optimisation du code. Ainsi, le choix de ce microcontrôleur
correspond parfaitement aux besoins fonctionnels et à la simplicité relative du
logiciel à développer dans ce projet.

Le PIC24F04KA200 se distingue comme le microcontrôleur le plus adapté à notre
projet. Il offre une puissance supérieure et plus d’interfaces que les PIC16F 8
bits, tout en restant plus simple à programmer, moins énergivore et moins
coûteux que les ARM Cortex-M comme le STM32. Familiarisés avec la famille PIC
grâce à notre formation, nous bénéficions d’un développement facilité. Ce
microcontrôleur gère efficacement les capteurs I2C, l’affichage LCD, les entrées
utilisateur et la communication Zigbee, offrant un compromis optimal entre
performance, intégration et budget.

== Communication

=== Communication sans-fil (faible consommation)

Pour transmettre la température sans fil entre nos deux cartes, on a choisi
d’utiliser un module Zigbee, le XB3-24Z8PT-J. Ce choix est lié au fait que notre
carte est alimentée en 3,3 V, et ce module communique aussi en 3,3 V, ce qui
évite d’avoir à ajouter des convertisseurs de niveau. De plus, c’est le seul
module Zigbee que l’on a trouvé qui correspond à ces critères et qui est facile
à intégrer avec notre microcontrôleur via une liaison UART.

On a comparé ce choix avec d’autres technologies comme la radio 433 MHz ou le
Bluetooth. La radio 433 MHz peut avoir une portée similaire, mais elle est
souvent plus compliquée à gérer en termes de protocole et de fiabilité. Le
Bluetooth, lui, consomme plus d’énergie et a une portée généralement plus
courte, environ 10 à 30 mètres, ce qui peut poser problème si les cartes sont un
peu éloignées.

Le Zigbee offre une bonne portée, jusqu’à 100 mètres en champ libre, ce qui est
un vrai plus pour la fiabilité de la communication. En plus, la communication se
fait simplement via UART, ce qui est possible sur notre microcontroleur. Enfin
il s’agissait du modele le moins évoluer ce qui évite d’utiliser des modules
trop complexes ou trop « boîte noire ».

==== Digi XB3-24Z8PT-J

#link(
  "https://www.digikey.fr/fr/products/detail/digi/XB3-24Z8PT-J/8130934",
)[Lien DigiKey]

Module moderne et puissant. Supporte Zigbee 3.0, qui est intéressant pour le
maillage réseau (les modules se relaient les informations).

==== Digi XB24CDMSIT-001 chez

#link(
  "https://www.mouser.fr/ProductDetail/Digi/XB24CDMSIT-001?qs=XmMZR4xR0DDHBWHJZQYv7A%3D%3D",
)[Lien]

Quasiment le standard de facto pour des réseaux Zigbee simples et robustes. Très
facile à utiliser en "mode transparent" via l'UART : ce qui est envoyé sur
l'UART d'un module sort sur l'UART de l'autre. Très bien documenté et supporté.

Néanmoins, moins de fonctionnalités que le XBee 3.

==== Digi WRL-22630

#link(
  "https://www.digikey.fr/fr/products/detail/sparkfun-electronics/WRL-22630/22321047",
)[Lien DigiKey]

Module performant, supportant Bluetooth LE, Thread, et Zigbee.

=== Affichage

- Afficheur LCD 4411-CN0295D-ND #link(
    "https://www.digikey.fr/fr/products/detail/sunfounder/CN0295D/18668612",
  )[Lien DigiKey]
- Afficheur FSTN NHD-C0220BIZ-FSW-FBW-3V3M-ND #link(
    "https://www.digikey.fr/fr/products/detail/newhaven-display-international-limited/NHD-C0220BIZ-FSW-FBW-3V3M/2626407",
  )[Lien Digikey]
// Points forts : Afficheur caractères standard (probablement 16x2 ou 20x4) avec
// une interface I2C, ce qui le rend facile à piloter. Peu coûteux.

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

L’interface visuelle avec l’utilisateur repose sur un écran LCD 16x2 connecté
via le bus I2C. Ce choix permet une économie significative de broches sur le
microcontrôleur, ce qui est essentiel car le projet mets en place plusieurs
périphériques comme des capteurs, des boutons, des LED et un module Zigbee.
L’affichage sera utilisé pour indiquer la température mesurée ainsi que la
température cible, et pourra, à terme, afficher d’autres informations comme
l’état du ventilateur ou le mode de fonctionnement (manuel/automatique),
actuellement indiqués par des LED. Le bus I2C est stabilisé par des résistances
de tirage (pull-up) qui assurent l’intégrité des signaux et la fiabilité de la
communication avec le microcontrôleur.
