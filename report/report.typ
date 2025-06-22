// LTeX: enabled=false // Désactive la correction orthographique
#import "lib.typ": * // Functions’ library
#let template(
  meta, // Global metadata REQUIRED
  // Front and back matter outputting functions (each taking meta arg)
  // front: (
  //   toc, // Table of Contents
  //   tof, // Table of Figures (Tables, Codes)
  // ),
  // back: (
  //   glo, // Glossary (Glossarium)
  //   bib, // Typst’s bibliography
  // ),
  // Main body pages’ header and footer outputting functions (taking meta arg)
  header: header,
  footer: footer,
  nb: "I.A.a.1", // Headings numbering template
  paper: "a4", // Page geometry
  margin: 2cm,
  body, // Main content
) = {
  // Set PDF file metadata
  set document(author: meta.authors, title: meta.titles.at(0), date: meta.date)
  set page(paper: paper, margin: margin) //, footer-descent: 0%) // Geometry

  set text(font: meta.serif, lang: meta.lang) // Text font and language
  set par(justify: true) // Justify paragraphs by default
  show link: underline // Underline links
  show math.equation: set text(size: 1.1em) // Increase inline equations size

  set heading(numbering: nb) // Number headings
  show heading: set text(font: meta.sans) // Write headings with sans font
  show heading.where(level: 1): h => align(center, h) // Center top headings

  // Emphasizes tables title cells TODO when possible
  // show table.header.cell: c => align(center, strong(c))
  // Emphasizes tables first line TODO remove when above is done
  show table.cell.where(y: 0): c => align(center, c)

  show raw: set text(font: meta.mono, 10pt) // Use a proper font for code
  import "@preview/codly:1.3.0": * // Code formatting package
  import "@preview/codly-languages:0.1.1": * // Languages coloring library
  show: codly-init.with() // Neat code blocks formatting
  // codly() // Left with default parameters
  // Style Code/Raw inline boxes (light grey, padding, rounded corners)
  show raw.where(block: false): box.with(
    fill: luma(220),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  set page(header: header(meta), footer: footer(meta), numbering: "1 / 1")
  body // Main content
}
