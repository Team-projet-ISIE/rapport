#import "report/report.typ": * // Import all report symbols
// Set global metadata (merge with default one) and apply template
// @typstyle off // Ugly dict addition formatting
#let meta = default_meta + (
  lang: "fr",
  titles: (
    [Projet déclencheur d’aération],
    [Informatique et Systèmes Intelligents Embarqués par apprentissage],
  ),
  date: date(), // Set date of the document to today
)
#show: template.with(
  meta, // Global metadata
)

#let accent = "#009EE0" // TODO apply color (h1, h2, table headers…)

// Title (and cover) pages
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
  // coll[
  //   #meta.authors.at(0)
  //   / Promotion : 2024 - 2027
  // ][
  //   / Entreprise: ...
  //   / Tuteur universitaire: ...
  //   / Tuteur professionnel: ...
  // ]
})
// #fullpage([]) // Empty page

#show: make-glossary // Initialise glossary
#register-glossary(yaml("glo.yml")) // Initialise glossary

#lorem(50)

= Rapport d’électronique

#coll(lorem(42), fig(image("polytech.png", width: 50%))[Une figure])

== Liens

#link("https://gitlab.com/gfauredev/typst-lib")[Dépôt GitLab].

Documentation @typst @typst-doc.

== Un #strike[tableau]

#fig(table(
  columns: 3, // Number of columns
  table.header[*#lorem(3)*][*#lorem(4)*][*#lorem(2)*], // Columns headers
  [#lorem(8)], [#lorem(4)], [], // First row
  [#lorem(6)], none, [#lorem(8)], // Second row
  [#lorem(5)], [#lorem(4)], [Great table isn’t it ?], // Third row
))[A #lorem(2) table]

== Bloc de code

#fig()[```Python
  my_string = """
  Hello, world !
  My Python is better than yours.
  """
  for i in range(42):
      print("{} - Hello, world !".format(i))
  ```][Python]

== Un graphique

#align(center, cetz.canvas({
  import cetz.draw: *
  plot.plot(size: (6, 6), x-tick-step: none, y-tick-step: none, {
    plot.add(((0, 0), (3, 3), (6, 1.5), (12, 9)))
  })
}))

// Glossary and bibliography without header and footer
#fullpage({
  align(center, text(font: meta.sans, 2em, weight: "bold", i18n("glossary")))
  print-glossary(yaml("glo.yml")) // Glossarium glossary
  pagebreak(weak: true) // TODO Fit them in one page if possible
  bibliography("bib.yml") // Typst’s bibliography
})
