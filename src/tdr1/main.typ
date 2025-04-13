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
    title: [Next Steps for Reproducible Testing and Deployment],
    subtitle: [
      "The attempt to rewrite the foundations of mathematics in terms of category theory is evil and wrong."
      --Walt Pohl
      #footnote[Attribution: @pohl_2005]
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

= Why Nix? Some Arguments.

== Nix as the Purely Functional, Monadic Build Tool

- Software directly controls hardware

#pause

(or so we think)

- In reality, software _can't execute itself_

#pause

- This is the purpose of a *build tool*

#pause

#v(24pt)

*We want a way to tell computers how to run software, \
and we want software to run the same way on any system, regardless of its internal state.*

#pagebreak()

#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    - This is a famously non-trivial problem

    #pause

    #block([
      #set text(size: 14pt)
      - Software has dependencies (for compilation, development, and in production), configurations, targets (supported systems), feasibility relations, and a bunch of other stuff we don't know about ("the world")
    ])

    #pause

    - Dealing with dependencies is a very serious problem (packages will require conflicting versions of the same package)
  ],
  [
    #set align(right)
    #image("assets/eelco.jpg", height: 200pt)

    Eelco Dolstra, original Nix theorist
  ],
)

#pagebreak()

- We want a function $f$ that takes a set of dependencies $X$ and maps it to a fully working implementation $F Y$
  #pause
  - $X$ represents any arbitrary list of packages, and $F$ is a transformation on the type $Y$ of package that includes "the world" generated in the process of trying to build this package
  #pause
  - $F Y$ contains both a resulting package and a bunch of metadata/configuration/dependencies created along with that package

#pause

- We have a new package $Z$ that depends on $Y$ but doesn't care about all this random junk produced in the process of building $Y$
  #pause
  - It has a build function that looks like $g : Y → F Z$

#pagebreak()

- There is an indirect relationship between $Z$ and $X$, and we want to find $h : X → F Z$
  #pause
  - $h := f >>= g$
  #pause
  - The so-called "monadic bind"

#pause

- We want a *monadic* build system @jade_2023

#pause

- We want *optimized incremental* builds (i.e. the bind operation should be fast and builds should be *pure*)
  - Same input, same output

#pagebreak()

- Some nice properties of *pure builds* \ (the formalism we've been developing for talking about software deployment): #v(12pt)
  #pause
  - Minimal recomputation
    - only the specific dependencies that are changed need to be rebuilt
  #pause
  - Distributed builds
    - all systems produce the same binaries

== Nix as the Fully Reproducible, Interpretable Build Tool

- Nix is not a dogmatic philosophy but the result of logical deliberation over the optimal dependency management scheme

#pause

- Nix is the unique existing build system satisfying both a *reproducibility criterion* and having *high interpretability*

#pagebreak()

#v(32pt)
#figure(
  [
    #image("assets/cult.png", height: 85%)
  ],
  caption: "This is absolutely not true",
)

#pagebreak()

=== Reproducibility

#v(24pt)

- We like

#pause

- Build twice. Any system, anywhere, any time, any [insert here]. \ *Same result*.

#pause

- Everything can be *built from source*
  - Critical for OPSEC

#pause

- Stuff just works.™

#pagebreak()

#v(32pt)
#figure(
  [
    #image("assets/deps.png", height: 85%)
  ],
  caption: "Other so-called \"package managers\"",
)

#pagebreak()

=== _Docker enjoyers may object to the previous discussion_ @crane_2022

#pause

There are some important differences, however (this is the *interpretability criterion*)

#v(24pt)

#pause

- Docker is *slow*, Nix is *fast*
  - About 5x faster compared to the ROS development environment @purvis_2022

#pause

- Docker comes with supply-side *bloat*, Nix comes with a *minimum package set*

#pause

- Docker is *stateful*, Nix is *stateless*

#pagebreak()

=== Docker

Reproduce, exactly, the entire system *state* of a working environment

#pause

#block([
  #set text(size: 14pt)
  For Arcturus, this isn't even the same as our deployment environment!
  This is *very bad*!
])

#pause

We don't know *why or how stuff works*, only that it works on a given system.
Equivalently, any change to the system state (Docker configuration) could lead to critical build failures.

#pagebreak()

=== Nix

Reproduce, exactly, the minimum set of *components* (packages and related configurations) that define a working environment

#pause

We can ask questions like _which packages does this module depend on?_ or _why did this new build fail?_

== Nix as as the Universal Build Tool

#quote()[
  The category of food, #smallcaps([Füd]), is a full subcategory of the category of stuff, #smallcaps([Stüf]),
  whose objects are the stuff you can eat. A morphism of this category is known
  as a recipe.
]

---Ed Morehouse @morehouse_2015

#pause

#v(24pt)

Nix is often described as a bad implementation of a good theory, mainly because it has actually been implemented and no longer exists in the minds of category theorists

#pagebreak()

=== Nix can run anywhere natively!

(Except Windows, but it can run on WSL)

#v(24pt)

- Any project, any dependency, any version

#pause

- Nix is extensible enough to describe build recipes for a wide variety of projects, and ROS is no exception

#pause

- However, ROS uses infamously bad dependency specifications and runtime environments

= The Great Nixification. An Overview.

== Non-invasive, isolated, and verifiable

Due to the severe shock that would result from hacking on Nix code in the primary codebase (as is best practice), the Nix build system has been developed completely independently.

#pause

- *Non-invasive* (using Nix does not interfere with existing working build environments)

#pause

- *Isolated* (self-contained, use it only when you want)

#pause

- *Verifiable* (benefit from safe binary caching and reproduce tests on other systems)

#pagebreak()

#v(32pt)
#figure(
  [
    #image("assets/flakes.png", width: 85%)
  ],
  caption: "tl;dr: you should be using Nix already",
)

== Where we are in relation to the literature

=== Where we are:

#v(32pt)

- Clear dependency specifications for each module in the main codebase

#pause

- A reproducible testing environment for individual nodes

#pause

- Preliminary implementation of a binary cache

#pagebreak()

=== The literature:

#v(12pt)
#figure(
  [
    #image("assets/asa.png", width: 75%)
  ],
  caption: "Grade A level trolling by Motorsports",
)

#pagebreak()

*Nix is not (only) being promoted by category theorists (and other students of abstract nonsense)*

#pause

- Presented at ROSCon 2022 @purvis_2022

#pause

- Work undergoing to rewrite #link("https://github.com/wentasah/ros2nix/")[ros2nix] in Motorsports

#pause

- Failure to keep pace with these developments reduces our research competitiveness, puts our build system in jeopardy of deprecation, and leaves our OPSEC vulnerable to upstream security issues

= Related Research Directions

== The work ahead of us

- Fully realize Nix speed benefits by *caching everything*
  #pause
  - Locally hosted, on a #link("https://github.com/arcturusnavigation/atlantic")[machine running NixOS]

#pause

- #link("https://github.com/ArcturusNavigation/all_seaing_vehicle/pull/107")[Automatic module build tests with Nix] (\#107)
  #pause
  - Will add unit testing and formal verification

#pause

- #link("https://community.gazebosim.org/t/nix-builds-coming/3668")[Gazebo/VRX simulation natively in Nix]

== The nPOV

=== Isn't there work to do outside of Nix nonsense?

Yes, here is a sampling of some interesting research directions that align with the #link("https://ncatlab.org/nlab/show/nPOV")[nPOV]:

#pause

- Work on adversarial robustness
  #pause
  - Requires an analysis and reworking of current perception algorithms
  - Docking will be a good case study

#pause

- Formal verification with #link("https://github.com/life4/deal")[Deal]
  #pause
  - Use Haskell or another functional language for rapid theorizing and testing, independent of main codebase

#pause

- Fully vision-based autonomous systems
  #pause
  - Station keeping would make a good R&D study of the feasibility of this

#focus-slide[
  R&D subteam?
]

== Further Reading

More to come on this in the future...

#pause

This report is entirely open-access and open-source.
You are welcome to contribute.
#link("https://github.com/arcturusNavigation/tdr")

#pagebreak()

#v(32pt)

#bibliography(
  "refs.bib",
  title: "References",
  full: true,
  style: "chicago-author-date",
)
