// LTeX: enabled=false // Désactive la correction orthographique pour ce fichier
#import "report/report.typ": * // Import all report symbols
// @typstyle off // Ugly dict addition formatting
#let meta = default_meta + (
  lang: "fr", // Français
  titles: (
    [Projet électronique 3A],
    [Déclencheur d’aération sur commande en température],
    [Informatique et Systèmes Intelligents Embarqués par apprentissage],
  ),
  authors: ("Fankam Jisèle", "Fauré Guilhem", ),
  date: date(2025, 6, 12) // Date de la soutenance
)
#show: template.with(meta) // Métadonnées (paramètres)
#let accent = rgb("#009EE0") // Bleu du logo Polytech, peut être utile

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
  coll(info(), [
    Encadrant\
    #text(1.15em)[*Chauvin Frédéric*]
  ])
})
// #include "./merci.typ" // Page de remerciements ?
// #include "./0abstract.typ" // Page de résumé ?

#show: make-glossary // Initialise le glossaire
#register-glossary(yaml("glo.yml")) // Initialise glossaire (pour le fichier)

#show heading: h => {
  if calc.rem-euclid(h.level, 2) == 0 {
    text(accent, h) // Titres de niveau pair en bleu
  } else {
    h
  }
}

#toc() // Table des matières
#tof() // Table des figures (et tableaux et codes)

#pagebreak() // Saut de page
#include "./1intro.typ"
#pagebreak() // Saut de page
#include "./2analyse.typ"
#pagebreak() // Saut de page
#include "./3etude.typ"
#pagebreak() // Saut de page
#include "./4conception.typ"
#pagebreak() // Saut de page
#include "./6test.typ"
#pagebreak() // Saut de page
// #include "./5realisation.typ" // À voir
// #pagebreak() // Saut de page
#include "./7conclusion.typ"
#pagebreak() // Saut de page
// #include "./8annexes.typ"
// #pagebreak() // Saut de page

// Glossaire et Bibliographie
#heading(numbering: none, i18n("glossary"))
#print-glossary(yaml("glo.yml")) // Glossarium glossary
#pagebreak(weak: true)
#bibliography("bib.yml") // Typst’s bibliography

// Inclut les fichiers multisim dans le PDF
// #pdf.embed(
//   "./cible.v1.ms14",
//   relationship: "data",
//   description: "Schéma multisim du module côté cible",
// )
// #pdf.embed(
//   "./reference.v1.ms14",
//   relationship: "data",
//   description: "Schéma multisim du module côté reference",
// )
