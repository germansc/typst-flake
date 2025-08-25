#let title = [ Propper paper title for this paper propper ]
#let smalltitle = [ small title for the header ]

#set page(
  paper: "us-letter",
  header: align(right)[
    #smalltitle
  ],
  columns: 2,
  numbering: "1",
)

#set par(justify: true)
#set text(font: "Libertinus Serif", size: 11pt)

#show heading.where(level: 1): it => [
  #set align(center)
  #set text(13pt, weight: "regular")
  #block(smallcaps(it.body))
]

#show heading.where(level: 2): it => text(
  size: 11pt,
  weight: "regular",
  style: "italic",
  it.body + [.],
)

#place(top + center, float: true, scope: "parent", clearance: 2em)[
  // Title
  #text(17pt)[*#title*]

  // Authors
  #grid(
    columns: (1fr, 1fr),
    [
      First Author \
      Some Institute \
      #link("mailto:author1@some.edu")
    ],
    [
      Second Author \
      Some Other Institute \
      #link("mailto:author2@other.edu")
    ],
  )

  // Abstract
  #set par(justify: false)
  *Abstract* \
  #lorem(80)
]

= Introduction
#lorem(100)

== Motivation
#lorem(50)

== Some other subsection
#lorem(20)

= Related Work
#lorem(200)

