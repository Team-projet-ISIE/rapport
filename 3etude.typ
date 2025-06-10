// LTeX: language=fr
= Étude de l'existant

== Captage

=== Température

==== Gravity AHC20

#link(
  "https://www.mouser.fr/ProductDetail/DFRobot/SEN0528?qs=Jm2GQyTW%2FbgFUSAl1tK%252BEQ%3D%3D",
)[Lien Mouser]

Points forts : Ce capteur est précis, stable et combine la mesure de température
et d'humidité, ce qui est un plus pour évaluer la qualité de l'air. Il utilise
une interface I²C, qui est un bus de communication standard et facile à mettre
en œuvre avec la plupart des microcontrôleurs, ne nécessitant que deux broches.
Sa consommation est très faible, de l'ordre de quelques microampères en veille.

Points faibles : Légèrement plus cher qu'un capteur de température seul.

Pertinence : Très pertinent. L'ajout de l'humidité offre une gestion plus fine
de l'aération (par exemple, pour lutter contre la condensation) pour un surcoût
et une complexité minimes.

==== Seeed DHT22

#link(
  "https://www.digikey.fr/fr/products/detail/seeed-technology-co-ltd/101020932/14552870",
)[Lien DigiKey]

Points forts : C'est un capteur très populaire et peu coûteux qui mesure
également la température et l'humidité.

Points faibles : Il utilise un protocole de communication propriétaire sur un
seul fil qui est très sensible au timing. La lecture des données peut être peu
fiable sur des systèmes non-temps-réel ou si le microcontrôleur est occupé. Sa
consommation en mesure est plus élevée que celle de l'AHT20.

Pertinence : Bon choix pour un prototypage rapide et à bas coût, mais l'AHT20
est techniquement supérieur et plus fiable pour un produit final.

==== TC74A0-3.3VAT-ND

#link(
  "https://www.digikey.fr/fr/products/detail/microchip-technology/TC74A0-3-3VAT/442720",
)[Lien DigiKey].

Points forts : Très simple, très peu cher, et extrêmement basse consommation
(quelques µA). Son interface I2C le rend facile à intégrer. C'est un choix
solide si seule la température est nécessaire.

Points faibles : Ne mesure pas l'humidité, ce qui est une limitation si ce
paramètre devient pertinent pour déclencher l'aération.

Pertinence : Excellent choix si le budget est très serré et que la mesure
d'humidité n'est absolument pas envisagée.

=== Interaction humaine

==== Commutateur à glissière OS102011MS2QN1

#link(
  "https://www.digikey.fr/fr/products/detail/c-k/OS102011MS2QN1/411602",
)[Lien DigiKey]

Points forts : Simple, peu coûteux, et fournit une indication visuelle claire de
son état (On/Off). Idéal pour un interrupteur de configuration (ex: "Mode
forcé", "Mode auto").

Points faibles : Peut-être moins esthétique qu'un bouton à bascule selon le
design du boîtier.

Pertinence : Parfait pour une interaction simple et binaire.

==== Commutateur à bascule A107SYCQ04

#link(
  "https://www.mouser.fr/ProductDetail/TE-Connectivity-AMP/A107SYCQ04?qs=9WkjXeXHXGz78jldEjGFKg%3D%3D",
)[Lien Mouser]

Points forts : Fonctionnellement similaire au commutateur à glissière, mais avec
une ergonomie différente (bascule). Souvent perçu comme plus qualitatif.
Celui-ci est un modèle (On)-Off-(On) momentané, ce qui pourrait être utile pour
naviguer dans un menu simple (ex: augmenter/diminuer une consigne).

Points faibles : Le caractère momentané de ce modèle spécifique le rend inadapté
pour un simple interrupteur On/Off permanent. Il faut choisir un modèle On-On.

Pertinence : Bon choix, à condition de sélectionner une version avec des
positions stables (On-Off ou On-On) si c'est le besoin.

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

Points Forts :

Faible courant de bobine (3V DC) : La bobine du relais nécessite seulement 3V DC
pour s'activer, ce qui est très avantageux pour un système basse consommation,
car cela simplifie l'alimentation et réduit la consommation du circuit de
commande.

Pouvoir de coupure élevé (10A 250VAC) : Capable de gérer des charges CA de 10A,
ce qui est largement suffisant pour un aérateur domestique qui consomme
généralement bien moins.

Isolation diélectrique élevée (5000 VAC) : Assure une bonne sécurité entre le
circuit de commande basse tension et le circuit de puissance 230V CA.

Compact (Subminiature) : Sa petite taille est un avantage pour l'intégration
dans un système électronique embarqué.

Points Faibles :

Relais électromécanique : Implique une usure mécanique au fil du temps, un bruit
audible lors de l'activation/désactivation et un temps de commutation plus lent
par rapport aux relais statiques.

Consommation de la bobine (typ. 120mW) : Bien que faible en 3V, cette
consommation est continue tant que le relais est activé. Pour un système basse
consommation, cela peut être un facteur à considérer si l'aérateur doit
fonctionner longtemps.

Pertinence pour le besoin : Très pertinent pour la commande de l'aérateur 230V
CA en raison de son faible courant de bobine, ce qui est essentiel pour un
système basse consommation. Le principal inconvénient est la consommation
continue de la bobine et l'usure mécanique.

===== Relais de puissance AWHSH112DM00G (Amphenol Anytek)

#link(
  "https://www.digikey.fr/fr/products/detail/amphenol-anytek/AWHSH112DM00G/16721953",
)[Lien Digikey]

Points Forts :

Tension de bobine de 12V DC : Compatible avec une alimentation 12V DC, ce qui
pourrait simplifier l'architecture si d'autres composants nécessitent du 12V.

Courant de coupure de 10A 250VAC : Capable de gérer des charges CA similaires au
G5LE-14.

Température de fonctionnement étendue (-40°C à +85°C) : Permet une utilisation
dans une large gamme d'environnements.

Points Faibles :

Consommation de la bobine (typ. 360mW 12V DC) : La puissance dissipée par la
bobine est plus élevée que celle du G5LE-14 (environ 3 fois plus), ce qui est
moins idéal pour un système basse consommation.

Relais électromécanique : Mêmes inconvénients que le G5LE-14 en termes d'usure,
de bruit et de vitesse de commutation.

Moins adapté au 3V/5V direct : Nécessiterait un driver ou une alimentation 12V
distincte pour la bobine si le microcontrôleur ou le circuit logique principal
fonctionne en 3V ou 5V.

Pertinence pour le besoin : Moins pertinent que le G5LE-14 pour un système basse
consommation pur en raison de sa consommation de bobine plus élevée. Il pourrait
être envisagé si une alimentation 12V est déjà présente et facile d'accès, mais
le G5LE-14 reste préférable pour la consommation.

==== Relais statique AZ943-1AH-12DEF (American Zettler)

#link(
  "https://www.digikey.fr/fr/products/detail/american-zettler/AZ943-1AH-12DEF/14307629",
)[Lien Digikey]

Points Forts :

Relais statique (Solid State Relay - SSR) :

Pas de pièces mobiles : Durée de vie beaucoup plus longue, pas d'usure
mécanique.

Commutation silencieuse : Pas de bruit audible.

Vitesse de commutation rapide : Bien que moins critique pour un aérateur, c'est
un avantage général des SSR.

Immunité aux rebonds : Pas de rebonds de contact, ce qui peut simplifier la
conception du circuit de commande.

Tension de contrôle de 12V DC : Similaire à l'AWHSH112DM00G, compatible avec une
alimentation 12V.

Courant de charge de 2A 240VAC : Suffisant pour la plupart des aérateurs
domestiques, qui consomment généralement moins de 1A.

Points Faibles :

Chute de tension et dissipation de puissance : Les SSR ont une petite chute de
tension à l'état passant (ON-state voltage drop), ce qui entraîne une
dissipation de puissance sous forme de chaleur. Pour 2A, cela pourrait
nécessiter un dissipateur de chaleur léger, même si l'aérateur consomme moins.

Sensibilité aux surtensions : Moins robuste face aux pointes de courant et aux
surtensions que les relais électromécaniques. Une protection externe (snubber)
peut être nécessaire.

Coût généralement plus élevé : Les SSR sont souvent plus chers que les relais
électromécaniques de capacité équivalente.

Fuite à l'état bloqué (OFF-state leakage current) : Les SSR ont un faible
courant de fuite à l'état bloqué, ce qui peut être un problème pour des
applications ultra basse consommation (bien que négligeable pour un aérateur).

Pertinence pour le besoin : Très pertinent si la fiabilité à long terme, le
silence et l'absence d'usure sont des priorités. La dissipation de chaleur est
le principal point à surveiller, mais pour un aérateur de faible puissance, ce
ne devrait pas être un problème majeur. La tension de contrôle de 12V est un
facteur à prendre en compte pour la conception de l'alimentation du système.

===== Relais statique J107F1CS1212VDC.36 (CIT Relay and Switch)

#link(
  "https://www.digikey.fr/fr/products/detail/cit-relay-and-switch/J107F1CS1212VDC-36/12502789",
)[Lien Digikey]

Note : Malgré la classification "Relais Statique" sur la liste fournie, la fiche
technique et la nature du composant indiquent clairement qu'il s'agit d'un
relais électromécanique. L'information sur la page Digikey le confirme également
: "Power Relays, Over 2 Amps". Le nom du produit "J107F Series Automotive Relay"
renforce cette observation. Je l'analyserai donc comme un relais
électromécanique.

Points Forts :

Tension de bobine de 12V DC : Standard et facile à intégrer si une alimentation
12V est disponible.

Pouvoir de coupure élevé (30A 14VDC) : Bien qu'il soit spécifié pour le DC, il
peut généralement gérer des charges AC à des courants plus faibles. Cependant,
cette fiche technique est principalement orientée DC pour applications
automobiles. Il est crucial de vérifier les spécifications AC si ce relais
devait être utilisé pour du 230V CA.

Robustesse : Conçu pour des applications automobiles, il est généralement très
robuste.

Points Faibles :

Principalement conçu pour des applications DC (Automobile) : Bien qu'il puisse
potentiellement être utilisé pour le 230V CA, la fiche technique ne fournit pas
de spécifications détaillées pour le 230V CA. Utiliser ce relais pour du 230V CA
sans confirmation des spécifications CA est risqué. L'isolation et la capacité
de coupure CA ne sont pas clairement indiquées pour cette tension.

Relais électromécanique : Mêmes inconvénients d'usure, de bruit et de vitesse
que les autres relais électromécaniques.

Encombrement : Les relais automobiles sont souvent plus volumineux.

Pertinence pour le besoin : Très peu pertinent pour la commande d'un aérateur
230V CA. Sa spécification principale est pour le DC en milieu automobile. Il ne
devrait pas être utilisé pour le 230V CA sans des spécifications claires et des
tests approfondis.

==== MOSFET (nécessaire sur les relais à bobine)

===== IRLZ44NPBF

#link(
  "https://www.digikey.fr/fr/products/detail/infineon-technologies/IRLZ44NPBF/811808",
)[Lien Digikey]

Points Forts :

Simplicité : Ne nécessite que trois broches (Gate, Drain, Source) et une ou deux
résistances externes.

Efficacité : Une très faible résistance à l'état passant (Rds(on)) signifie une
dissipation de chaleur minimale et une excellente efficacité énergétique. Idéal
pour votre projet basse consommation.

Coût : Généralement très abordable.

Basse consommation de la logique de commande : La grille d'un MOSFET est
contrôlée par tension, ce qui signifie que votre microcontrôleur n'a presque pas
de courant à fournir pour le commuter.

Durée de vie : Composant électronique pur, donc pas d'usure mécanique.

Contrôle "Logic Level" : Peut être directement piloté par les signaux 3.3V ou 5V
de la plupart des microcontrôleurs (8-bit ou 16-bit).

Points Faibles :

Protection : Bien que robustes, les MOSFETs n'intègrent pas les protections des
drivers de moteur dédiés. Pour un ventilateur, cela est rarement un problème,
mais une diode de roue libre (flyback diode) en parallèle avec le ventilateur
est cruciale pour protéger le MOSFET contre les pics de tension lorsque le
ventilateur est éteint (dû à la bobine du moteur).

Polarité : Un MOSFET N-Channel doit être placé entre la charge (ventilateur) et
la masse.

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

Points forts : Excellent rapport débit/prix (240 m³/h pour ≃ 20 €). Alimentation
standard 230V.

Points faibles : La consommation et le bruit ne sont pas toujours les meilleurs
sur les modèles d'entrée de gamme.

Pertinence : Un choix très pragmatique et économique.

===== Airope Axial inline 125mm

#link(
  "https://www.manomano.fr/p/airope-inline-125-mmextracteur-dair-silencieux190-m3-h16-wconduit-en-ligneaxial-de-la-gainconome-en-nergiepour-le-bainwctoilettetenteserrecuisinebureaugaragegarantie-5-ans-66851732?model_id=70287817",
)[Lien ManoMano]

Points forts : Bon compromis débit/prix, faible consommation annoncée (16 W).

Points faibles : Débit légèrement inférieur au Sygonix.

Pertinence : Un autre excellent choix, potentiellement plus économe en énergie.

==== Alimentée en 12~V

===== Manrose SELV

#link(
  "https://www.pureventilation.com.au/buy/manrose-selv-12v-ceiling-wall-exhaust-fan-125mm",
)[Lien PureVentilation]

Points forts : Très sécurisant (très basse tension de sécurité).

Points faibles : Très cher (≃ 180 €) et nécessite un transformateur 230V -> 12V
AC, ce qui ajoute un coût et une consommation à vide. Le 12V AC est un standard
peu commun.

Pertinence : Peu pertinent en raison de son coût et de sa tension d'alimentation
atypique.

===== Ventilateur MEC0251V3-000U-A99

#link(
  "https://www.digikey.fr/fr/products/detail/sunon-fans/MEC0251V3-000U-A99/2021100",
)[Lien DigiKey]

Points forts : Simple à alimenter : 12V pour le faire tourner, 0V pour
l'arrêter.

Points faibles : Pas de contrôle de vitesse possible, sauf à faire varier la
tension d'alimentation, ce qui est peu efficace.

Pertinence : Bon pour un prototype simple avec une logique On/Off.

===== Ventilateur 603-1212-ND

#link(
  "https://www.digikey.fr/fr/products/detail/delta-electronics/AFB1212HHE-TP02/2034815",
)[Lien DigiKey]

Points forts : Le 4ème fil (PWM) permet un contrôle très précis et efficace de
la vitesse de rotation. Cela permettrait une ventilation proportionnelle à la
température, plus silencieuse et plus économique en énergie qu'un simple On/Off.
Le 3ème fil (tachymètre) permet de vérifier que le ventilateur tourne bien.

Points faibles : Légèrement plus complexe à piloter (nécessite une sortie PWM du
microcontrôleur).

Pertinence : Le meilleur choix pour un système intelligent. La régulation de
vitesse est un atout majeur.

=== Régulation de tension

==== Régulateur de tension linéaire LM1085CT-3.3/LM1086CT-3.3

#link(
  "https://www.digikey.fr/fr/products/detail/texas-instruments/LM1086CT-3-3-NOPB/363571",
)[chez DigiKey].

#link(
  "https://www.digikey.fr/fr/products/detail/analog-devices-inc/LT1085CT-3-3-PBF/889588",
)[Lien DigiKey]

Points forts : Peuvent fournir un courant très élevé (1.5A / 3A).

Points faibles : Courant de repos très élevé (typ. 5-10 mA). C'est un gaspillage
énorme pour un système basse consommation qui passe 99% de son temps en veille.
Ils sont totalement surdimensionnés.

Pertinence : Inadaptés pour un système basse consommation.

==== Régulateur de tension linéaire LE33CZ-TR

#link(
  "https://www.digikey.fr/fr/products/detail/stmicroelectronics/LE33CZ-TR/725169",
)[Lien DigiKey]

Points forts : Courant de repos très faible (Iq ≤ 5 µA en veille), ce qui est
excellent pour un appareil sur batterie ou basse consommation. Capacité en
courant (100 mA) largement suffisante pour le microcontrôleur et les capteurs.

Points faibles : Aucun pour ce projet.

Pertinence : Le choix parfait parmi les régulateurs linéaires listés.

==== Régulateur de tension linéaire MP2307

Points forts : Rendement très élevé (>90%). Si l'alimentation principale est en
12V, un régulateur linéaire dissipera (12V - 3.3V) × I en chaleur, ce qui est
très inefficace. Un régulateur à découpage ne chauffe quasiment pas.

Points faibles : Plus complexe, peut générer du bruit électronique (généralement
pas un problème ici).

Pertinence : Une excellente alternative au LE33 si la tension d'entrée est
élevée (ex: 12V) pour maximiser l'efficacité énergétique.

== Numérique

=== Microcontrôleur

==== PIC24FJ256GA702-I/SP 28 broches

#link(
  "https://www.digikey.fr/fr/products/detail/microchip-technology/PIC24FJ256GA702-I-SP/6562000",
)[Lien DigiKey]

Points forts : Très puissant pour un 16-bit. Dispose de 256 Ko de mémoire Flash
et 16 Ko de RAM, ce qui est très confortable pour gérer le code, une pile de
communication sans-fil (comme Zigbee) et des fonctionnalités futures. Famille
"XLP" (eXtreme Low Power) optimisée pour la basse consommation. Beaucoup de
périphériques (I2C, SPI, UART, ADC...).

Points faibles : Le boîtier DIP-28 est assez grand.

Pertinence : Un excellent choix. Il offre une grande flexibilité et de très
bonnes performances en basse consommation, sans violer la contrainte des 32
bits.

==== PIC24F08KL301-I/P-ND 20 broches

#link(
  "https://www.digikey.fr/fr/products/detail/microchip-technology/PIC24F08KL301-I-P/2835112ç",
)[Lien DigiKey]

Points forts : Moins cher, boîtier plus petit (DIP-20).

Points faibles : Très peu de mémoire (8 Ko de Flash, 1 Ko de RAM). Cela risque
d'être beaucoup trop juste pour intégrer une pile de communication sans-fil en
plus de la logique applicative.

Pertinence : Risqué. Probablement insuffisant en mémoire pour ce projet.

== Communication

=== Communication sans-fil (faible consommation)

==== Digi XB3-24Z8PT-J

#link(
  "https://www.digikey.fr/fr/products/detail/digi/XB3-24Z8PT-J/8130934",
)[Lien DigiKey]

Antenne intégrée, ZigBee 3, 802.15.4, I2C, SPI, UART ≃ 24~€

Points forts : Module très moderne et puissant. Supporte Zigbee 3.0, qui est
excellent pour le maillage réseau (les modules se relaient les informations).
Peut être programmé en MicroPython directement, ce qui pourrait même supprimer
le besoin d'un microcontrôleur externe pour des tâches simples.

Points faibles : Peut-être complexe à configurer pour un débutant. Assez cher.

Pertinence : Très bon mais peut-être surdimensionné en complexité.

==== Digi XB24CDMSIT-001 chez

#link(
  "https://www.mouser.fr/ProductDetail/Digi/XB24CDMSIT-001?qs=XmMZR4xR0DDHBWHJZQYv7A%3D%3D",
)[Lien]

802.15.4, Zigbee, SPI/UART ≃ 28~€

Points forts : Le standard de facto pour des réseaux Zigbee simples et robustes.
Très facile à utiliser en "mode transparent" via l'UART : ce que vous envoyez
sur l'UART d'un module sort sur l'UART de l'autre. Très bien documenté et
supporté.

Points faibles : Moins de fonctionnalités que le XBee 3.

Pertinence : Le choix le plus pragmatique et fiable pour créer un réseau de
capteurs sans-fil avec un microcontrôleur externe.

==== Digi WRL-22630

#link(
  "https://www.digikey.fr/fr/products/detail/sparkfun-electronics/WRL-22630/22321047",
)[Lien DigiKey]

Bluetooth v4.2, Bluetooth v5.0, Zigbee, SPI/UART ≃ 29~€

Points forts : Module extrêmement performant, supportant Bluetooth LE, Thread,
et Zigbee.

Points faibles : Le cœur de ce module est un ARM Cortex-M4, qui est un
microcontrôleur 32-bit. Ce composant viole donc la contrainte fondamentale de ne
pas utiliser de MCU 32-bit.

Pertinence : ❌ Inutilisable si la contrainte des 16-bit maximum doit être
respectée.

=== Affichage

==== Afficheur LCD 4411-CN0295D-ND

#link(
  "https://www.digikey.fr/fr/products/detail/sunfounder/CN0295D/18668612",
)[Lien DigiKey]

Points forts : Afficheur caractères standard (probablement 16x2 ou 20x4) avec
une interface I2C, ce qui le rend facile à piloter. Peu coûteux.

Points faibles : Consommation électrique élevée, surtout à cause du
rétroéclairage (backlight) qui peut consommer 20-30 mA à lui seul. C'est un
point critique pour un système basse consommation.

Pertinence : Mauvais choix pour la basse consommation si l'affichage doit être
permanent.

==== Afficheur FSTN NHD-C0220BIZ-FSW-FBW-3V3M-ND

#link(
  "https://www.digikey.fr/fr/products/detail/newhaven-display-international-limited/NHD-C0220BIZ-FSW-FBW-3V3M/2626407",
)[Lien Digikey]

Points forts : La technologie FSTN (un type de LCD passif) est conçue pour une
très faible consommation. Le contraste est souvent meilleur que sur les LCD
standards. Il peut fonctionner sans rétroéclairage.

Points faibles : Peut-être un peu plus cher.

Pertinence : Le choix idéal pour un afficheur dans un projet basse consommation.
Sa très faible consommation est un atout décisif.
