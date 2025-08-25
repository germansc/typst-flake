#set page(paper: "a4", margin: (x: 1.8cm, y: 1.5cm))
#set text(font: "New Computer Modern", size: 10pt)
#set par(justify: true, leading: 0.52em)
#set heading(numbering: "1.")

= Introduction

/* ---------------------
 * For basic markup use:
 *   _text_ for italics
 *   *text* for bold
 * --------------------- */
In this report, we will explore the various factors that influence _fluid
dynamics_ in *glaciers* and how they contribute to the formation and behaviour of
these natural structures.

#lorem(40)

/* ----------------------------------
 * For lists use
 *   + for numbered items,
 *   - for bullet points.
 *
 * Lists can be nested by indentation
 * ---------------------------------- */
+ The climate
  - Temperature
  - Precipitation
+ The topography
+ The geology


/* -------------------------------------------------------------------
 * Labeled elements (<label>) can be referenced with the @label syntax
 * ------------------------------------------------------------------- */
Glaciers as the one shown in @glaciers will cease to exist if we don't take
action soon!


/* -------------------------------------------------------------------
 * Figures are automatically centered and can have captions.
 * ------------------------------------------------------------------- */
#figure(
  image("figures/glacier.jpg", width: 70%),
  caption: [_Glaciers_ form an important part of the earth's climate system.],
) <glaciers>

= Methods

We follow the glacier melting models established in @glacier-melt.

The flow rate of a glacier is defined by the following equation:

$ Q = rho A v + "time offset" $

Total displaced soil by glacial flow:

$ 7.32 beta + sum_(i=0)^nabla (Q_i (a_i - epsilon)) / 2 $

$ v = vec(x_1, x_2, x_3) $

$ a arrow.squiggly b $

#lorem(500)

#bibliography("works.bib")

