// LTeX: enabled=false // Désactive la correction orthographique
#import "report/report.typ": * // Import all report symbols
// Set global metadata (merge with default one) and apply template
// @typstyle off // Ugly dict addition formatting
#let meta = default_meta + (
  lang: "fr", // Français
  titles: (
    [Projet électronique 3A],
    [Déclencheur d’aération sur commande en température],
    [Informatique et Systèmes Intelligents Embarqués par apprentissage],
  ),
  authors: ("Fankam Jisèle", "Fauré Guilhem", ),
  date: date(2025, 6, 12), // Date de la soutenance
)
#show: template.with(
  meta, // Métadonnées (paramètres)
)
#let accent = "#009EE0" // Bleu du logo Polytech, peut être utile

// Page de titre
#fullpage({
  set image(height: 6em)
  set par(justify: false)
  grid(
    columns: 3,
    gutter: 1fr,
    align(horizon, image("./polytech.png")),
    align(horizon, image("./universitéTours.svg")),
    align(horizon, image("./itii.png")),
  )
  v(1fr)
  align(center, {
    let size = 2.25em
    let weight = 800
    for t in meta.titles {
      text(font: meta.sans, size, weight: weight, t)
      size -= .25em
      weight -= 200
      parbreak()
    }
  })
  v(1fr)
  info()
})
// #fullpage([]) // Page vide
// Page de remerciements ?
// #fullpage({
//   heading(numbering: none, level: 2, i18n("thanks"))
//   [Nous remercions…]
// })

#show: make-glossary // Initialise le glossaire
#register-glossary(yaml("glo.yml")) // Initialise le glossaire
// LTeX: enabled=true // Réactive la correction orthographique

Résumé…

= Exemples Typst

#fig(image("polytech.png", width: 50%))[Une figure avec légende]

#link("https://gitlab.com/gfauredev/typst-lib")[Lien] du dépôt GitLab.

#fig(table(
  columns: 2,
  table.header[Un][tableau],
  [Gras], [*gras*],
  [Italique], [_italique_],
  [Barré], strike[texte],
))[Légende]

Référence glossaire @typst et bibliographie @typst-doc (définitions dans fichier YAML).

#fig()[```Python
  my_string = """
    Bloc de code (Python)
  """
  for i in range(42):
      print("{} - Hello, world !".format(i))
  ```][Python]

#fig(cetz.canvas({
  import cetz.draw: *
  plot.plot(size: (6, 6), x-tick-step: none, y-tick-step: none, {
    plot.add(((0, 0), (3, 3), (6, 1.5), (12, 9)))
  })
}))[Légende du graphique]

// Glossaire et Bibliographie
#fullpage({
  align(center, text(font: meta.sans, 2em, weight: "bold", i18n("glossary")))
  print-glossary(yaml("glo.yml")) // Glossarium glossary
  pagebreak(weak: true)
  bibliography("bib.yml") // Typst’s bibliography
})

= Introduction

== Contexte général

== Problématiques à résoudre

== Objectifs du projet

== Plan

= Analyse Fonctionnelle et Cahier des Charges

== Analyse du besoin

Bête à cornes, matrice MOSCOW.

== Schémas fonctionnels

SFN1, SF1D, SF2D…

== Description des fonctions

== Description des signaux

== Cahier des Charges Fonctionnel ?

== Performances attendues ?

== Contraintes

= Étude de l'Existant et Veille Technologique

== Solutions existantes

== Veille technologique

== Capteurs

== Microcontrôleurs

== Actionneurs

== Protocoles de communication

= Conception du Système

== Architecture globale

Schéma bloc

== Conception matérielle

Hard

=== Choix des composants

=== Schéma électronique

=== Conception du circuit imprimé

== Conception logicielle

Soft

=== Algorithme de régulation

=== Logique de programmation temporelle

=== Architecture logicielle

=== Interface Homme-Machine

= Réalisation et Intégration

== Prototypage

== Développement du code

== Intégration

= Test et Validation

== Protocoles de test

=== Tests unitaires

Test fonctions code

=== Test d’intégration

Test de l’ensemble du système

=== Test de performance

Efficacité

== Résultats

== Analyse et Interprétation

= Conclusion

== Bilan

== Synthèse des résultats

== Perspectives et améliorations futures

#heading(numbering: none)[Annexes]

Code source.

Datasheets ?

…
