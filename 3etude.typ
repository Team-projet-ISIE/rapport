// LTeX: language=fr
= Étude de l'existant

== Captage

=== Température

- Gravity AHC20 #link(
    "https://www.mouser.fr/ProductDetail/DFRobot/SEN0528?qs=Jm2GQyTW%2FbgFUSAl1tK%252BEQ%3D%3D",
  )[chez Mouser] (+ humidité).
- Seeed DHT22 #link(
    "https://www.digikey.fr/fr/products/detail/seeed-technology-co-ltd/101020932/14552870",
  )[chez DigiKey] (+ humidité).
- TC74A0-3.3VAT-ND #link(
    "https://www.digikey.fr/fr/products/detail/microchip-technology/TC74A0-3-3VAT/442720",
  )[chez DigiKey].

=== Interaction humaine

- Commutateur à glissière OS102011MS2QN1 chez #link(
    "https://www.digikey.fr/fr/products/detail/c-k/OS102011MS2QN1/411602",
  )[DigiKey].
- Commutateur à bascule A107SYCQ04 #link(
    "https://www.mouser.fr/ProductDetail/TE-Connectivity-AMP/A107SYCQ04?qs=9WkjXeXHXGz78jldEjGFKg%3D%3D",
  )[chez Mouser].

== Analogique

=== Commande en puissance

==== CA 230~V

- Relais de puissance G5LE-14 DC3 #link(
    "https://www.digikey.fr/fr/products/detail/omron-electronics-inc-emc-div/G5LE-14-DC3/1815628",
  )[chez Digikey]
- Relais de puissance AWHSH112DM00G #link(
    "https://www.digikey.fr/fr/products/detail/amphenol-anytek/AWHSH112DM00G/16721953",
  )[chez Digikey]
- Relais statique AZ943-1AH-12DEF #link(
    "https://www.digikey.fr/fr/products/detail/american-zettler/AZ943-1AH-12DEF/14307629",
  )[chez Digikey]
- Relais statique AZ943-1AH-12DEF #link(
    "https://www.digikey.fr/fr/products/detail/american-zettler/AZ943-1AH-12DEF/14307629",
  )[chez Digikey]
- Relais statique J107F1CS1212VDC.36 #link(
    "https://www.digikey.fr/fr/products/detail/cit-relay-and-switch/J107F1CS1212VDC-36/12502789",
  )[chez Digikey]

==== MOSFET (nécessaire sur les relais à bobine)

==== CC 12~V

- Driver 1528-4489-ND #link(
    "https://www.digikey.fr/fr/products/detail/adafruit-industries-llc/4489/11594498",
  )[chez DigiKey]
- Driver TB6615PG8-ND #link(
    "https://www.digikey.fr/fr/products/detail/toshiba-semiconductor-and-storage/TB6615PG-8/7809551?s=N4IgjCBcoGwJxVAYygMwIYBsDOBTANCAPZQDaIALGGABxwDsIAuoQA4AuUIAyuwE4BLAHYBzEAF9CAJnoxEIFJAw4CxMuADMFOBUYsQHLr0GiJhevSnzFyvIRKRyNAAwa4AVmchCNejQru3uAUGi4aQVIa9FoIhG4wUhRB9O4WFF7SYO4azoHSoSkZIFJgGjCezGyckDz8wmKS4DAwSdAKaFh2ao4gNBolNHJxkelF-VrONEHj6bEgM856VUZ1po1gcHTWHSr26l5MjQC0Vm2K-ACuqg7kgYeNcm0CACZcR2DOEMs1QewAnqxcFx0NgUOJxEA",
  )[chez Digikey]

=== Aération

==== Alimentée en CA 230~V

- Manrose #link(
    "https://www.pureventilation.com.au/buy/manrose-selv-12v-ceiling-wall-exhaust-fan-125mm/",
  )[SELV], AC 12~V ≃ 180~€
- Sygonix #link(
    "https://www.conrad.fr/fr/p/sygonix-sy-5233250-ventilateur-tubulaire-encastrable-230-v-ac-240-m-h-125-mm-2616625.html",
  )[SY-5233248] 240 m³/h, AC 230~V ≃ 20~€
- Airope Axial #link(
    "https://www.manomano.fr/p/airope-inline-125-mmextracteur-dair-silencieux190-m3-h16-wconduit-en-ligneaxial-de-la-gainconome-en-nergiepour-le-bainwctoilettetenteserrecuisinebureaugaragegarantie-5-ans-66851732?model_id=70287817",
  )[inline 125mm] 190 m³/h, AC 230~V ≃ 27~€

==== Alimentée en CC 12~V

- Ventilateur MEC0251V3-000U-A99 120~mm 12~V DC 2 fils #link(
    "https://www.digikey.fr/fr/products/detail/sunon-fans/MEC0251V3-000U-A99/2021100",
  )[chez DigiKey].
- Ventilateur 603-1212-ND 120~mm 12~V DC 4 fils (PWM) #link(
    "https://www.digikey.fr/fr/products/detail/delta-electronics/AFB1212HHE-TP02/2034815",
  )[chez DigiKey].

=== Régulation de tension

- Régulateur de tension linéaire LM1086CT-3.3/NOPB-ND #link(
    "https://www.digikey.fr/fr/products/detail/texas-instruments/LM1086CT-3-3-NOPB/363571",
  )[chez DigiKey].
- Régulateur de tension linéaire LE33CZ-TR #link(
    "https://www.digikey.fr/fr/products/detail/stmicroelectronics/LE33CZ-TR/725169",
  )[chez DigiKey].
- Régulateur de tension linéaire LT1085CT-3.3/PBF-ND #link(
    "https://www.digikey.fr/fr/products/detail/analog-devices-inc/LT1085CT-3-3-PBF/889588",
  )[chez DigiKey].

== Numérique

=== Microcontrôleur

- PIC24FJ256GA702-I/SP 28 broches #link(
    "https://www.digikey.fr/fr/products/detail/microchip-technology/PIC24FJ256GA702-I-SP/6562000",
  )[chez DigiKey].
- PIC24F08KL301-I/P-ND 20 broches #link(
    "https://www.digikey.fr/fr/products/detail/microchip-technology/PIC24F08KL301-I-P/2835112ç",
  )[chez DigiKey].

== Communication

=== Communication sans-fil (faible consommation)

- XB3-24Z8PT-J #link(
    "https://www.digikey.fr/fr/products/detail/digi/XB3-24Z8PT-J/8130934",
  )[chez DigiKey], antenne intégrée, ZigBee 3, 802.15.4, I2C, SPI, UART ≃ 24~€
- XB24CDMSIT-001 chez #link(
    "https://www.mouser.fr/ProductDetail/Digi/XB24CDMSIT-001?qs=XmMZR4xR0DDHBWHJZQYv7A%3D%3D",
  )[Mouser], 802.15.4, Zigbee, SPI/UART ≃ 28~€
- WRL-22630 #link(
    "https://www.digikey.fr/fr/products/detail/sparkfun-electronics/WRL-22630/22321047",
  )[chez DigiKey], Bluetooth v4.2, Bluetooth v5.0, Zigbee, SPI/UART ≃ 29~€

=== Affichage

- Afficheur LCD 4411-CN0295D-ND #link(
    "https://www.digikey.fr/fr/products/detail/sunfounder/CN0295D/18668612",
  )[chez DigiKey].
- Afficheur FSTN NHD-C0220BIZ-FSW-FBW-3V3M-ND #link(
    "https://www.digikey.fr/fr/products/detail/newhaven-display-international-limited/NHD-C0220BIZ-FSW-FBW-3V3M/2626407",
  )[chez Digikey]
