// LTeX: enabled=false // Disable grammar and spelling checking in this file
// Shortcodes (to use when writing the report inside the main file)
#import "lib/lib.typ": coll, date, fig, fullpage, i18n, info, rc, res, sign
// Glossary (initialization)
#import "@preview/glossarium:0.5.4": (
  gls,
  glspl,
  make-glossary,
  print-glossary,
  register-glossary,
)
// Diagrams drawing
#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1": chart, plot // TODO add examples
#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node
// #import "@preview/physica:0.9.5" // Engineering

// Default global metadata passed around
// WARN there may be a better way to do this
#let default_meta = (
  lang: "en", // Language, important for hyphens, some titles (like toc’s)…
  // Titles, by order of importance
  titles: (
    [A report],
    [Written with Typst],
    [Using Guilhem Fauré’s report template],
  ),
  authors: ("Guilhem Fauré",), // Author(s) of the document
  date: date(2025, 5, 31), // Date of the document (last template update)
  // Fonts
  sans: ("Nacelle",), // "Inter", "FiraGO", "sans-serif"
  serif: ("Libre Baskerville",), // "Vollkorn", "Merriweather", "serif"
  mono: ("JetBrainsMono NF",), // "FiraCode Nerd Font", "mono"
  // Assets (simpler to use them in body directly)
  // glossary: "glossary.yml",
  // bibliography: "bibliography.yml",
  // logo: "logo.png",
)

// ToC’s and ToF’s codes may be factorizable
// Wrapper around outline to make a Table of Contents
#let toc(toc: none) = {
  if type(toc) == content or type(toc) == str {
    context {
      if counter(heading).final().at(0) > 0 {
        outline(title: toc, depth: 3, indent: auto)
      }
    }
  } else {
    context {
      if counter(heading).final().at(0) > 0 {
        outline(depth: 3, indent: auto)
      }
    }
  }
}
// Wrapper around outline to make an internationalized Table of Figures
#let tof(tof: none) = {
  let figTitles = (
    table: i18n("tables"),
    raw: i18n("codes"),
    image: i18n("figures"),
  )
  if type(tof) == dictionary {
    // pagebreak(weak: true) // TODO break page if ToC + ToF don’t fit in one
    context {
      for (title, kind) in tof {
        if counter(figure.where(kind: kind)).final().at(0) > 0 {
          outline(title: title, target: figure.where(kind: kind))
        }
      }
    }
  } else if type(tof) == str and (tof == "mix" or tof == "mixed") {
    outline(
      title: [#i18n("tables"), #i18n("codes"), #i18n("figures")],
      target: figure,
    )
  } else {
    for kind in (table, raw, image) {
      context {
        if counter(figure.where(kind: kind)).final().at(0) > 0 {
          outline(title: figTitles.at(repr(kind)), target: figure.where(
            kind: kind,
          ))
        }
      }
    }
  }
}

// Main body pages’ header and footer
#let header(meta) = {
  set text(size: .9em)
  set grid(gutter: 1fr)
  if meta.titles.len() == 1 {
    meta.titles.at(0)
  } else {
    grid(
      columns: 2,
      {
        meta.titles.at(0)
        [, ]
        meta.titles.at(1)
      },
    )
  }
  line(length: 100%)
}
#let footer(meta) = {
  set text(size: .9em)
  line(length: 100%)
  grid(
    columns: 2,
    gutter: 1fr,
    {
      let last = meta.authors.pop()
      for a in meta.authors {
        a
        [, ]
      }
      last
    },
    context counter(page).display("1 / 1", both: true),
  )
}
