#set page(paper: "a4", margin: (x: 2cm, y: 2cm))
#set text(font: "New Computer Modern", size: 10pt)
#set par(justify: true, leading: 0.55em)
#set heading(numbering: "1.")

#show heading.where(level: 1): it => [
  #set text(18pt, weight: "bold")
  #block(above: 1.5em, below: 0.5em, it)
]

#show heading.where(level: 2): it => [
  #set text(14pt, weight: "bold")
  #block(above: 1em, below: 0.3em, it)
]

#show heading.where(level: 3): it => [
  #set text(11pt, weight: "bold", style: "italic")
  #block(above: 0.8em, below: 0.2em, it)
]

#align(center)[
  #text(24pt, weight: "bold")[Typst Cheat Sheet]

  A quick reference for common Typst constructs \
  #link("https://typst.app")[typst.app]
]

#line(length: 100%)

= Text Formatting

== Inline styles
// *Bold*  _Italic_  `Code`
*Bold*, _Italic_, `Code`, #underline[Underline], #strike[Strikethrough], #smallcaps[Small Caps]

// Subscript ~ and ^superscript^
H#sub[2]O and E = mc#super[2]

== Line breaks and spacing
// Line break with \ backslash
First line \
Second line

// Thin space #h(1pt)  em space #h(1em)
A#h(1pt)B A#h(1em)B

== Alignment
// #align(center)[...], #align(right)[...]
#align(center)[Centered text]
#align(right)[Right-aligned]

= Headings & Structure

// = Level 1 (h1)
// == Level 2 (h2)
// === Level 3 (h3)

= Level 1 Heading
== Level 2 Heading
=== Level 3 Heading

// Numbering controlled by #set heading(numbering: "1.") at top
// Use "1.1" for "1.1", "I." for Roman, "a)" for letters

= Lists

== Unordered
// - for bullets
- Item
- Another
  - Nested item
    - Deeper

== Ordered
// + for numbered
+ First
+ Second
  + Sub-item
  + Sub-item

== Description (terms)
// / Term: Description
/ Term: Definition of the term
/ Another term: Its definition

= Math

== Inline math
// $ ... $ for inline
Maxwell's equations: $nabla dot D = rho$

== Display math
// $$ ... $$ or $ ... $ on its own line
$ Phi(x) = 1 / sqrt(2 pi) integral_(-infinity)^x e^(-t^2 / 2) dif t $

== Common constructs
// Fractions, subscripts, superscripts, sums, integrals
$ (a + b)^2 = a^2 + 2 a b + b^2 $
$ sum_(i=1)^n i = (n(n+1)) / 2 $
$ integral_0^(2 pi) sin(theta) dif theta = 0 $

// Vectors, matrices, cases
$ v = vec(x_1, x_2, x_3) $
$ A = mat(1, 2; 3, 4) $
$ f(x) = cases(1 "if" x > 0, 0 "otherwise") $

// Spacing: quad, qquad, and thin spaces
$ x quad y quad quad z $

// Text inside math with "
$ a + b " for all " a,b in RR $

= Tables

== Basic table
// columns with relative lengths (1fr = 1 fraction)
#table(
  columns: (1fr, 2fr, 1fr),
  align: (center, left, right),
  [*Qty*], [*Item*], [*Price*],
  [1], [Typst book], [#sym.dollar 15],
  [2], [Coffee mug], [#sym.dollar 12],
  [3], [Stickers], [#sym.dollar 5],
)

== Table with stroke and fill
#table(
  columns: (1fr, 1fr),
  stroke: 0.5pt + black,
  fill: (row, col) => if calc.even(row) { luma(230) } else { white },
  [Name], [Value],
  [Alpha], [1.0],
  [Beta], [2.5],
  [Gamma], [0.8],
)

= Figures

== Image
#figure(
  image("figures/glacier.jpg", width: 60%),
  caption: [A glacier in the Swiss Alps.],
) <fig:glacier>

== Custom figure
#figure(
  rect(width: 40%, height: 1.5cm, fill: teal),
  caption: [A styled rectangle as a figure.],
)

// Referencing: @fig:glacier

= Code Blocks

== Raw inline
Use `typst compile file.typ` in the terminal.

== Fenced block with syntax highlighting
```rust
fn greet(name: &str) -> String {
    format!("Hello, {}!", name)
}
```

```python
def factorial(n: int) -> int:
    return 1 if n == 0 else n * factorial(n - 1)
```

```typ
#let make-title(body) = {
  text(20pt, weight: "bold", body)
}
```

= Boxes & Blocks

== Box (inline)
// #box with ... for inline containers
This is a #box(fill: yellow)[highlighted] word.

== Block (paragraph-level)
#block(fill: luma(240), stroke: 0.5pt + gray, inset: 8pt, radius: 4pt)[
  This is a styled block with background and border.
  It can span multiple paragraphs.
]

== Rect / Square (arbitrary shapes)
#rect(width: 100%, height: 2em, fill: teal)
#circle(radius: 1cm, fill: orange)
#ellipse(width: 3cm, height: 1.5cm, fill: purple)

= Layout

== Grid
#grid(
  columns: (1fr, 1fr, 1fr),
  rows: (auto, auto),
  fill: (x, y) => if calc.rem(x + y, 2) == 0 { luma(230) } else { white },
  [A1], [B1], [C1],
  [A2], [B2], [C2],
)

== Columns
// #set page(columns: 2) for document-level
// #set page(columns: 2) switches to two-column layout

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    == Left column
    #lorem(40)
  ],
  [
    == Right column
    #lorem(40)
  ],
)

= Links & Cross-references

== External links
#link("https://typst.app")[Typst website]
Or bare URLs: https://typst.app

== Internal references
See @fig:glacier for the glacier image.

Table @tbl:prices shows pricing.

#figure(
  table(
    columns: (1fr, 1fr),
    [Item], [Cost],
    [A], [#sym.dollar 10],
    [B], [20],
  ),
  caption: [Pricing overview],
) <tbl:prices>

= Styling

== Custom show rules
// Show rules let you redefine how elements look

// Make all bold text red
#show strong: set text(fill: red)

// Make all level-1 headings centered
#show heading.where(level: 1): set align(center)

== Colors
// Named: red, blue, green, teal, purple, ...
// RGB: rgb("#ff6600")
// Luma: luma(200) — grayscale
#text(fill: rgb("#e63e3e"))[Red text]
#text(fill: teal)[Teal text]
#rect(fill: rgb("#ffd700"), width: 2cm, height: 1cm)

= Custom Functions

== Simple function
#let emphasize(body) = {
  text(fill: red, weight: "bold", body)
}

This is #emphasize[important].

== Named arguments
#let warning(body, level: "info") = {
  let bg = if level == "error" { red.transparentize(80%) } else {
    blue.transparentize(80%)
  }
  block(fill: bg, inset: 8pt, radius: 4pt, body)
}

#warning[*Info:* Something noteworthy happened.]

#warning(level: "error")[*Error:* Something went wrong!]

= Bibliography

Use `#bibliography("works.bib")` to include references.
Cite with \@key syntax. See \@works.bib for entries.

#bibliography("works.bib")

= Setup Reference

Below are common set rules for document configuration.

// Page
// #set page(paper: "a4", margin: (x: 2cm, y: 2cm), numbering: "1")
// #set page(columns: 2, header: [Header text])

// Text
// #set text(font: "New Computer Modern", size: 11pt, fill: black)
// #set text(lang: "en", region: "US")

// Paragraph
// #set par(justify: true, leading: 0.65em, first-line-indent: 0pt)

// Heading
// #set heading(numbering: "1.1", outline: (indent: auto))
