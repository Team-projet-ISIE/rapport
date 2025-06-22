#import "report/report.typ": * // Import all report symbols
// TODO Architecture globale ?
// TODO Schéma bloc ?

= Conception

== Conception matérielle

=== Interfaçage

==== Bus standard I#super[2]C

Afin d’assurer une communication fiable, nous avons étudié les niveaux logiques
à respecter sur les lignes SDA (données) et SCL (horloge). Voici les plages de
tension que nous avons prises en compte pour une tension d'alimentation de
VDD~=~3,3~V~:

De l’esclave au maitre :

- *Tension de sortie basse (VOL)* : entre 0~V et 0,4~V, pour que le signal soit
  reconnu comme un ‘0’ logique par le @mcu.
- *Tension de sortie haute (VOH)* : entre 2,31~V et 3,3~V (soit 70~% à 100~% de
  VDD), assurant un ‘1’ logique fiable au @mcu.

Du maitre a l’esclave :

- *Tension d’entrée basse (VIL)* : inférieure à 0,99~V (30~% de VDD), pour un
  niveau bas valide.
- *Tension d’entrée haute (VIH)* : supérieure ou égale à 2,31~V (70~% de VDD),
  pour un niveau haut correctement interprété.

Nous avons vérifié que notre microcontrôleur respecte bien ces seuils, ce qui
garantit une compatibilité totale avec le module LCD et une communication
I#super[2]C sans erreurs.

#fig(image("datasheet/startStopI2C.png", height: 20em))[Extrait de la datasheet
  @dht20-ds du DHT20 : Conditions de Start et Stop I#super[2]C]

De plus, la documentation rappelle que chaque communication I#super[2]C débute
par une condition Start (la ligne SDA passe de l’état haut à bas pendant que SCL
est haut) et se termine par une condition Stop (la ligne SDA repasse de bas à
haut alors que SCL est haut). Ces transitions sont essentielles pour que les
périphériques détectent correctement le début et la fin d’une transmission, et
au repos ces lignes doivent être à 0, il faut donc fixer leurs tensions à 3,3~V
avec des résistances de pull-up, et également éviter des flottements et donc
indécisions de la tension.

==== Capteur de température (DHT20) en I#super[2]C

// WARNING
#align(center, text(size: 16pt, fill: red)[C’est pas chelou sorties du MCU et
  entrées du capteur ?])

===== Sorties du @mcu (vers le capteur de température)

- *Tension de sortie basse (VOL)* : Les broches I/O peuvent descendre jusqu’à
  0,4 V maximum, ce qui est conforme à la spécification I#super[2]C (< 0,4 V
  pour un niveau logique bas). Le signal sera bien interprété comme un ‘0’
  logique.
- *Tension de sortie haute (VOH)* : Les lignes SDA et SCL sont de type
  open-drain, ce qui signifie que le microcontrôleur ne force pas le niveau
  haut. Ce sont les résistances de pull-up qui ramènent la ligne à VDD = 3,3~V
  quand personne ne la tire vers le bas. Cela respecte la condition VOH ≥ 2,31~V
  (70~% de VDD) imposée par le protocole I2C.

#fig(image("datasheet/pic24OutSpecs.png", height: 25em))[Extrait de la datasheet
  @pic24-ds du PIC24 : Spécifications des sorties]

===== Entrées du capteur (depuis le @mcu)

- *Tension d’entrée basse (VIL)* : L’écran reconnaît un niveau bas tant que la
  tension est inférieure à 0,99 V (30 % de VDD). Le microcontrôleur, qui émet
  jusqu’à 0,4 V au niveau bas, respecte donc bien cette limite.
- *Tension d’entrée haute (VIH)* : Le capteur interprète un niveau haut dès que
  la tension dépasse 2,31 V (70 % de VDD). Grâce aux résistances de pull-up
  ramenant la ligne à 3,3 V, ce seuil est largement atteint.

#fig(image("datasheet/dht20OutSpecs.png", height: 20em))[Extrait de la datasheet
  @dht20-ds du DHT20 : Spécifications des entrées/sorties]

===== Conclusion

Les niveaux logiques d’entrée et de sortie sont parfaitement compatibles entre
le microcontrôleur et le capteur.

==== Écran LCD

// WARNING
#align(center, text(size: 16pt, fill: red)[Pareil, pourquoi *sorties* de l’écran
  ?])

===== Entrées de l’écran LCD

Les caractéristiques d'entrée correspondent aux niveaux de tension acceptés par
les broches d'entrée de l’écran LCD :

- *Niveau logique "H" en entrée (VIH)* : au moins 0,7 × VDD, soit 2,31~V pour
  une alimentation VDD = 3,3~V.
- *Niveau logique "L" en entrée (VIL)* : de 0~V (VSS) jusqu’à 0,8 × VDD, soit
  2,64~V pour VDD = 3,3~V.

Le microcontrôleur doit fournir des signaux compatibles avec les niveaux
logiques d’entrée de l’écran LCD :

- *Niveau logique "H"* : le microcontrôleur doit fournir une tension de sortie
  haute (VOH) d’au moins 2,31~V, ce qui est respecté puisque sa tension de
  sortie haute minimale est de 3~V.
- *Niveau logique "L"* : la tension de sortie basse maximale (VOL) du
  microcontrôleur est de 0,4~V, compatible avec la tension d’entrée basse
  maximale de l’écran LCD qui est de 2,64~V.

===== Sorties de l’écran LCD

Les caractéristiques de sortie correspondent aux niveaux de tension fournis par
les broches de sortie de l’écran LCD :

- *Niveau logique "H" en sortie (VOH)* : au moins 0,7 × VDD, soit 2,31~V pour
  VDD = 3,3~V.
- *Niveau logique "L" en sortie (VOL)* : de 0~V (VSS) jusqu’à 0,8~V.

Le microcontrôleur doit être capable de lire correctement les signaux en
provenance de l’écran LCD :

- *Niveau logique "H"* : l’écran LCD délivre une tension de sortie haute (VOH)
  de 2,31~V, ce qui correspond à la tension d’entrée haute minimale du
  microcontrôleur.
- *Niveau logique "L"* : l’écran LCD produit une tension de sortie basse
  maximale (VOL) de 0,8~V, légèrement supérieure à la tension d’entrée basse
  maximale tolérée par le microcontrôleur (0,66~V). Cette différence est
  généralement tolérée en pratique grâce aux résistances de pull-up présentes
  sur le bus I2C.

===== Conclusion

#fig(image("datasheet/lcdInOutSpecs.png", height: 16em))[Extrait de la datasheet
  @lcd-ds de l’écran LCD : Spécifications des entrées/sorties]

Les caractéristiques électriques d’entrée et de sortie de l’écran LCD sont
globalement compatibles avec celles du microcontrôleur, ce qui assure une
interface fiable pour la communication I2C. Il est important d’utiliser des
résistances de pull-up adaptées sur les lignes SDA et SCL pour garantir la
stabilité des signaux.

==== @mcu

#coll(
  align(horizon)[
    "Recommended Minimum Connections" @pic24-ds illustre les connexions
    minimales nécessaires pour assurer le bon fonctionnement du @mcu
    `PIC24FV16KM204`. Voici une explication des principaux composants et de leur
    rôle :
  ],
  fig(image("datasheet/miniConnPic24.png"))[Extrait de la datasheet @pic24-ds du
    PIC24~: Connexions minimales recommandées],
)

*Résistances (R1 et R2)*

- *R1* : Cette résistance relie la broche MCLR (Master Clear) à la tension
  d’alimentation VDD afin d’éviter des réinitialisations intempestives du
  microcontrôleur. Une valeur typique pour R1 est 10 kΩ.
- *R2* : Placée en série avec la broche MCLR, cette résistance limite le courant
  en cas de décharge électrostatique ou de surtension. Sa valeur recommandée est
  généralement de 470 Ω ou moins.

*Condensateurs (C1 à C7)*
- *C1* : Connecté entre la broche MCLR et la masse, ce condensateur filtre les
  perturbations et stabilise la tension appliquée sur MCLR.
- *C2* et *C3* : Ces condensateurs sont placés entre VDD et VSS pour découpler
  l’alimentation et réduire le bruit électrique sur la ligne d’alimentation.
- *C6* et *C7* : Ces condensateurs assurent un filtrage supplémentaire pour
  améliorer la stabilité globale de l’alimentation.

*Connexions pour la programmation*

La programmation du @mcu s’effectue via l’interface ICSP (In-Circuit Serial
Programming). Les broches principales utilisées sont :
- *PGC* (Programming Clock) : Broche fournissant le signal d’horloge pour
  synchroniser la communication entre le programmeur et le microcontrôleur.
- *PGD* (Programming Data) : Broche servant au transfert bidirectionnel des
  données entre le programmeur et le microcontrôleur.

Ces broches PGC et PGD sont connectées aux broches correspondantes du
programmeur, ce qui permet d’envoyer les instructions et les données nécessaires
à la programmation et au débogage.

=== Écoconception

// WARNING
#align(center, text(size: 16pt, fill: red)[Rien à ajouter ?])

==== Alimentation

- Remplacement du régulateur de tension linéaire par un modèle au meilleur
  rendement. Par exemple, LM2574 (rendement 75–80 %) par un #link(
    "https://www.mouser.fr/c/?q=MP1584&srsltid=AfmBOoomZs3Ve2X_ggsdSyUf4NPJ5ALkqRL-gmh70By6GHsim0H8emv",
  )[MP1584] (rendement 90–95 %) pour un gain de rendement de 15 à 20~%.

- Ajout d’un MOSFET pour couper l’alimentation des périphériques (LCD,
  XBee)lorsqu’ils ne sont pas utilisés.

==== Microcontrôleur

- Utilisation des modes Sleep du PIC24.

- Réduction de fréquence d’horloge via PLL/OSCCON.

==== Passifs

- Remplacement pull-up 4,7 kΩ par 10–47 kΩ, suppression de condensateurs
  "superflus".

=== Schémas structurels

#fig(image("./cible.png"))[Schéma structurel du module
  @cible]

#fig(image("./reference.ventilateur.png"))[Schéma structurel du module @réf avec
  un ventilateur 12~V]

#fig(image("./reference.relais.png"))[Schéma structurel du module
  @réf]

== Conception logicielle

=== Algorithme d’aération

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
