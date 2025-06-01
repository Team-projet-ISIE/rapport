// Simple two collumns layout
#let coll(cols: (1fr, 1fr), col1, col2) = {
  grid(columns: cols, col1, col2, gutter: .5em)
}

// Datetime less verbose shortcode, with precision growing along positional
// args from year to second, or can also be used with original named args
#let date(..args) = {
  let named = args.named()
  let pos = args.pos()
  if named.len() == 0 and pos.len() == 0 {
    return datetime.today() // Defaults to today if no args
  }
  let precision = ("year", "month", "day", "hour", "minute", "second")
  let i = 0
  for p in precision {
    if i == pos.len() { break }
    if p in named { continue }
    named.insert(p, pos.at(i))
    i += 1
  }
  datetime(..named)
}

// Smart figure shorthand
#let fig(sup: none, content, ..sink) = {
  let caption = none
  let kind = auto
  if sink.pos().len() > 0 {
    caption = sink.pos().at(0)
  }
  if sink.pos().len() > 1 {
    kind = sink.pos().at(1)
  }
  if sink.pos().len() > 2 {
    sup = sink.pos().at(2)
  }
  figure(
    caption: if caption != none {
      caption
    },
    content,
    supplement: if sup != none {
      sup
    } else {
      auto
    },
  )
}

// No header, footer and numbering page(s)
#let fullpage(content) = {
  page(header: none, footer: none, numbering: none, content)
}

// Translate `word` into contextual text language WARN lowercase required
#let i18n(word) = (
  context {
    yaml("i18n/" + text.lang + ".yml").at(word)
  }
)

// Display document info (metadata) neatly
#let info(dateFormat: "[day]/[month]/[year]", dir: "v") = {
  context {
    if document.author.len() > 0 {
      if document.author.len() == 1 {
        text(weight: "medium", i18n("author"))
        [~:~]
        text(1.15em, weight: "semibold", document.author.at(0))
      } else {
        text(weight: "medium", i18n("authors"))
        if dir == "v" {
          linebreak()
        } else if dir == "h" {
          [ ]
        }
        for a in document.author {
          list.item(text(1.15em, weight: "bold", a))
        }
      }
      if dir == "v" {
        parbreak()
      } else if dir == "h" {
        h(1fr)
      }
    }
    if type(document.date) == datetime {
      text(weight: "medium", i18n("date"))
      [~:~]
      text(1.15em, weight: "semibold", document.date.display(dateFormat))
    }
  }
}

// Rounded Corners for images
#let rc(radius: 4pt, content) = {
  block(clip: true, radius: radius, content)
}

// Boxed RESult
#let res = block.with(stroke: black, inset: .25em)

// Simple, grey rounded rectangle with title
#let sign(..sink) = {
  if sink.pos().len() > 0 {
    block(below: .8em, sink.pos().at(0))
  }
  block(
    width: 15em,
    height: 5em,
    above: 0pt,
    stroke: 2pt + luma(170),
    radius: 4pt,
  )
}
