# Déclencher d’aération sur commande en température

[Rapport PDF](./report.pdf)

## Caractérisation détaillée fonction

- Précision
- Résolution
- Vitesse
- Caractéristiques économiques
- Stock
- Caractéristiques environnementales
- Moyens de fabrication

## TODO

- [x] Bête à cornes
- [x] SFN1
- [x] SF1D (Faire apparaître commande en puissance ?)
- [x] Description des fonctions
  - [x] Classement des fonctions par nature
  - [x] Retirer les références envisagées
- [x] Description des signaux (À améliorer)
- [x] SF2D avec 5-25V entrant dans FA0, 230V secteur entrant dans FP5
  - [x] V2 avec ≃12V entrant dans FP5
  - [x] V3 avec piles ou batterie entrant dans FA0
- [ ] Justification des références de capteurs dans une autre section
- [ ] Caractérisation détaillée du capteur de température et d’humidité
- [ ] Caractérisation détaillée de l’interface humain machine
- [ ] Caractérisation détaillée de la commande en puissance
- [ ] Caractérisation détaillée de l’aérateur/ventilateur
- [ ] Caractérisation détaillée du circuit d’alimentation
- [ ] Caractérisation détaillée du module ZigBee
- [ ] Caractérisation détaillée de l’afficheur
- [ ] Validation de l’interfaçage capteur température (& humidité) / MCU
  - [ ] Validation protocole de communication
- [ ] Validation de l’interfaçage module ZigBee / MCU
- [ ] Validation à priori des fonctions
- [ ] Stratégies de validation à posteriori des fonctions
- [ ] Fiches de tests des fonctions
- [ ] Structure d’adaptation de niveau/commande en puissance
- [ ] Validation de l’interfaçage commande en puissance
- [ ] Structures d’alimentations
  - [ ] Avec un module secteur 5 V - 25 V
  - [ ] Avec des piles / une batterie
- [ ] Validation de la communication sans-fil entre les deux modules

### Ne s’applique pas au projet

- CAN/CNA
- Amplification
- Filtrage analogique
- Conditionnement de capteurs analogiques
