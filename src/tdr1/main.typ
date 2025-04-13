#import "@preview/touying:0.5.3": *
#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0"
#import themes.stargazer: *

#let date = datetime(
  year: 2025,
  month: 4,
  day: 11,
).display("[month repr:long] [day], [year]")
#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  header-right: rect(
    none,
    fill: gradient.linear(color.rgb(0, 91, 172), black),
    width: (100% + 50pt),
    height: 100pt,
  ),
  config-info(
    title: [Some Notes on Abstract Nonsense],
    subtitle: [
      "We'll only use as much category theory as is necessary.\ [_famous last words_]"
      --Roman Abramovich
      #footnote[Attribution: @model (who is this?)
      ]
    ],
    author: [Ananth Venkatesh],
    date: date,
    institution: [MIT Arcturus Autonomy],
  ),
)

#set heading(numbering: "1.1")
#show heading.where(level: 1): set heading(numbering: "1.")
#show figure.caption: emph

#let vec = sym => math.bold(math.upright(sym))
#let unit = sym => math.hat(vec(sym))

#title-slide()

= Theorems

== Nonsense

#set quote(block: true)
#quote(attribution: "Henri Poincaré")[Geometry is the art of correct reasoning from incorrectly drawn figures.]

#pause

*What is life?*

#pause

- Nix, Haskell, and the like

#pause

- That's all folks!

=== Definitions

#tblock(title: "Theorem!")[
  What??
]

== Grid

#figure(
  grid(
    columns: (auto, auto),
    rows: (auto, auto),
    gutter: 1em,
    [ Block 1 ], [ Block 2 ],
    [ Block 3 ], [ Block 4 ],
  ),
  caption: [_From left to right, top to bottom_: Blah blah blah],
) <manifolds>

#bibliography(
  "refs.bib",
  title: "References",
  full: true,
  style: "chicago-author-date",
)
