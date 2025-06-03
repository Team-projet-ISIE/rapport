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
// Initialise le glossaire (nécessaire dans chaque fichier)
#register-glossary(yaml("glo.yml"))
// LTeX: enabled=true // Réactive la correction orthographique

// #include "./0abstract.typ"

#toc() // Table des matières
#tof() // Table des figures (et tableaux et codes)

#include "./1intro.typ"

#include "./2analyse.typ"

#include "./3etude.typ"

#include "./4conception.typ"

#include "./5realisation.typ"

#include "./6test.typ"

#include "./7conclusion.typ"

#include "./8annexes.typ"

// Glossaire et Bibliographie
#fullpage({
  heading(numbering: none, i18n("glossary"))
  print-glossary(yaml("glo.yml")) // Glossarium glossary
  pagebreak(weak: true)
  bibliography("bib.yml") // Typst’s bibliography
})
