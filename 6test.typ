#import "report/report.typ": * // Import all report symbols
#set par(justify: false)

= Validation et test

== Traitements numériques pièce référence (FP0)

#xlsx-parser(
  read("test.xlsx", encoding: none),
  sheet-index: 0,
  parse-table-style: false,
)

#xlsx-parser(
  read("test.xlsx", encoding: none),
  sheet-index: 1,
  parse-table-style: false,
)

== Captage température (FP2)

#xlsx-parser(
  read("test.xlsx", encoding: none),
  sheet-index: 2,
  parse-table-style: false,
)

== Interfaçage RF (FP3)

#xlsx-parser(
  read("test.xlsx", encoding: none),
  sheet-index: 3,
  parse-table-style: false,
)

#pagebreak()
== Interfaçage humain-machine (FP4)

#xlsx-parser(
  read("test.xlsx", encoding: none),
  sheet-index: 4,
  parse-table-style: false,
)

#pagebreak()
== Commande en puissance (FP5)

#xlsx-parser(
  read("test.xlsx", encoding: none),
  sheet-index: 5,
  parse-table-style: false,
)

#pagebreak()
== Interfaçage machine humain (FP7)

#xlsx-parser(
  read("test.xlsx", encoding: none),
  sheet-index: 6,
  parse-table-style: false,
)

== Programmation in-situ (FA0)

#xlsx-parser(
  read("test.xlsx", encoding: none),
  sheet-index: 7,
  parse-table-style: false,
)

== Alimentation (FA1)

#xlsx-parser(
  read("test.xlsx", encoding: none),
  sheet-index: 8,
  parse-table-style: false,
)
