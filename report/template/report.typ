#import "@local/report:0.0.0": * // Import all report symbols
// Set global metadata (merge with default one) and apply template
// @typstyle off // Ugly dict addition formatting
#let meta = default_meta + (
  date: date(), // Set date of the document to today
)
#show: template.with(
  meta, // Global metadata
)

// Title (and cover) pages
#fullpage({
  info()
  parbreak()
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
})
#fullpage([]) // Empty page
#fullpage({
  coll(cols: (1fr, auto), info(), image("logo.png", height: 8em))
  parbreak()
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
  parbreak()
  align(center, image("logo.png", height: 18em))
  sign[Stamp]
  parbreak()
  text(1.5em)[Reviewer~: *John Doe*]
  parbreak()
  sign[Signature]
})

#show: make-glossary // Initialise glossary
#register-glossary(yaml("glo.yml")) // Initialise glossary

// Thanks page
#fullpage({
  heading(numbering: none, level: 2, i18n("thanks"))
  // align(center, text(font: meta.sans, 2em, weight: "bold", i18n("thanks")))
  [
    Many thanks to Jane and John Doe, #lorem(8)

    Also, #lorem(18)
  ]
})

Abstract, #lorem(50).

#lorem(50), abstract.

= #lorem(5) (H1)

#coll(lorem(42), fig(image("logo.png", width: 50%))[A figure for your pleasure])

== Very important links (H2)

A _very_ *important* #link("https://gitlab.com/gfauredev/typst-lib")[link] to
this template’s #strike[GitHub]
#link("https://gitlab.com/gfauredev/typst-lib")[GitLab repository], #lorem(2)

Don’t hesitate to refer to the @typst documentation @typst-doc, it’s great #super[DO IT].
However, it won’t explain you the reason of all this @lorem stuff, please refer
to Wikipedia @lorem-wiki #sub[OK].

=== Packages shiped with this template (H3)

- @glossarium, see the generated glossary at the next page
- @codly, see below for a pretty code block
- @fletcher, not currently used in this example document

Retrieve them on Typst Universe @typst-univ.

== A #strike[useful] table (second H2)

#fig(table(
  columns: 3, // Number of columns
  table.header[*#lorem(3)*][*#lorem(4)*][*#lorem(2)*], // Columns headers
  [#lorem(8)], [#lorem(4)], [], // First row
  [#lorem(6)], none, [#lorem(8)], // Second row
  [#lorem(5)], [#lorem(4)], [Great table isn’t it ?], // Third row
))[A #lorem(2) table]

#lorem(6)

== A code block (third H2)

A _Python_ `code` block, formatted with the *@codly* package, for your pleasure.

#fig()[```Python
  my_string = """
  Hello, world !
  My Python is better than yours.
  """
  for i in range(42):
      print("{} - Hello, world !".format(i))
  ```][A Python example]

== A plot

#cetz.canvas({
  import cetz.draw: *
  plot.plot(size: (6, 6), x-tick-step: none, y-tick-step: none, {
    plot.add(((0, 0), (3, 3), (6, 1.5), (12, 9)))
  })
})

// Glossary and bibliography without header and footer
#fullpage({
  align(center, text(font: meta.sans, 2em, weight: "bold", i18n("glossary")))
  print-glossary(yaml("glo.yml")) // Glossarium glossary
  pagebreak(weak: true) // TODO Fit them in one page if possible
  bibliography("bib.yml") // Typst’s bibliography
})
