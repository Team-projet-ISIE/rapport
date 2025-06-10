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
- [x] Description des signaux
- [x] SF2D avec 5-25V entrant dans FA0, 230V secteur entrant dans FP5
  - [x] V2 avec ≃12V alimentant la commande en puissance de l’aération
  - [x] V3 avec piles ou batterie alimentant module cible

- [x] Description FA2 (alim 12V)
- [x] Description FA3 (alim autonome)
- [x] Mettre à jour nom fonctions (FA0->FA1…)

- [ ] SF3D avec les connections I²C, les bons signaux

- [ ] Corriger, vérifier description des signaux

- Étude de l’existant
  - [ ] Intro
  - [ ] Comparaison des capteurs de température
  - [ ] Comparaison des bouttons/interrupteurs
  - [ ] Comparaison des MOSFET/drivers… (FP6)
  - [ ] Comparaison des aérateurs
  - [ ] Comparaison des aérateurs (alt 12V)
  - [ ] Comparaison des modules ZigBee
  - [ ] Comparaison des afficheurs
  - [ ] Comparaison des régulateurs de tension (FA1)
  - [ ] Comparaison des régulateurs de tension (FA2)
  - [ ] Comparaison des MCUs

- Validation à priori PLACER AVANT OU APRÈS CONCEPTION ?
  - [ ] Validation à priori capteur température (& humidité) / MCU
    - [ ] Validation de l’interfaçage avec MCU
    - [ ] Description et validation protocole de communication
  - [ ] Validation à priori boutons/interrupteurs
    - [ ] Validation de l’interfaçage avec MCU
  - [ ] Validation à priori commande en puissance
    - [ ] Validation de l’interfaçage avec MCU
    - [ ] Validation de l’interfaçage avec aérateur
  - [ ] Validation à priori commande en puissance (alt 12V)
    - [ ] Validation de l’interfaçage avec MCU
  - [ ] Validation à priori aérateurs
    - [ ] Validation de l’interfaçage avec commande en puissance
  - [ ] Validation à priori module ZigBee
    - [ ] Validation de l’interfaçage avec MCU
  - [ ] Validation à priori afficheur
    - [ ] Validation de l’interfaçage avec MCU
  - [ ] Validation à priori circuit alim
    - [ ] Validation de l’interfaçage avec MCU
    - [ ] Validation de l’interfaçage avec tout
  - [ ] Validation à priori circuit alim (alt batterie)
    - [ ] Validation de l’interfaçage avec MCU
    - [ ] Validation de l’interfaçage avec tout

- Conception
  - [ ] Intro, architecture globale
  - [ ] Caractérisation détaillée du capteur de température et d’humidité
    - [ ] Justification du choix
  - [ ] Caractérisation détaillée de l’interface humain machine
    - [ ] Justification du choix
  - [ ] Caractérisation détaillée de la commande en puissance
    - [ ] Justification du choix
  - [ ] Caractérisation détaillée de la commande en puissance (alt 12V)
    - [ ] Justification du choix
  - [ ] Caractérisation détaillée de l’aérateur/ventilateur
    - [ ] Justification du choix
  - [ ] Caractérisation détaillée du module ZigBee
    - [ ] Justification du choix
  - [ ] Caractérisation détaillée de l’afficheur
    - [ ] Justification du choix
  - [ ] Caractérisation détaillée du circuit d’alimentation
    - [ ] Justification du choix
  - [ ] Caractérisation détaillée du circuit d’alimentation (alt batterie)
    - [ ] Justification du choix
  - [ ] Caractérisation détaillée du MCU
    - [ ] Justification du choix

- Validation à posteriori (Test)
  - [ ] Stratégies de validation à posteriori des fonctions
  - [ ] Fiche de test du captage température
  - [ ] Fiche de test du captage entrée humain
  - [ ] Fiche de test structure commande en puissance
  - [ ] Fiche de test adaptation de niveau/commande en puissance (alt)
  - [ ] Fiche de test aération
  - [ ] Fiche de test aération (alt 12V)
  - [ ] Fiche de test alimentation secteur 5 V - 25 V
  - [ ] Fiche de test alimentation piles / batterie (alt)
  - [ ] Fiche de test communication sans-fil entre les deux modules

### Ne s’applique pas au projet

- CAN/CNA
- Amplification
- Filtrage analogique
- Conditionnement de capteurs analogiques
