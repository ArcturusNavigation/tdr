#import "@preview/charged-ieee:0.1.3": ieee

#show: ieee.with(
  title: [Proposal for an Arcturus Research and Development Subteam],
  abstract: [
    Arcturus has always been at the frontier of research and development efforts among MIT's build teams, pursuing ideas and projects that have at times seemed unlikely to bear fruit.
    Our approach has emphasized rapid prototyping and careful analysis of both well tested and novel methods.
    In this whitepaper, we propose the establishment of a research and development subteam to pursue what we see as the highest priority long-term goals, including many topics in theoretical computer science, applied mathematics, and related subjects.
    Many of our proposals may seem at present unreasonable at best and, in most cases, nearly impossible.
    We expect that, given the scope and fundamental restructuring necessary to achieve these goals, a separate subteam devoted to research and development is needed.
    We outline further reasons and major benefits of this approach in the following sections.
  ],
  authors: (
    (
      name: "Ananth Venkatesh",
      department: [Autonomy Subteam],
      organization: [MIT Arcturus],
      location: [Cambridge, MA],
      email: "ananthv@mit.edu",
    ),
  ),
  bibliography: bibliography("refs.bib"),
)

#let tiny = it => smallcaps(lower(it))

#show "'n": [\u{2019}n]
#show "ROS": tiny
#show "XML": tiny
#show "VRX": tiny
#show "CI": tiny
#show "ASV": tiny
#show "R&D": tiny

= Introduction

From its very inception, Arcturus has been grounded in fundamental research.
Much of our team's initial developmental success was due to a rethinking of the standard model of an autonomous surface vehicle (ASV).
We can trace these origins to the team's seminal modern restructuring in @chen_2023, which laid the groundwork for later developments in autonomous navigation and perception systems and future mechanical advancements.

Technical design reports (@chen_2022, @chen_tdr_2023, and most recently @bolte_2025), though significantly less novel than @chen_2023, mark critical milestones in the team's development and global competitiveness.
Discussions of autonomous navigation and perception in these reports highlight impressive work in this space, but with few fundamentally novel or previously untested approaches.
Thus, the state of development of these systems has remained relevatively stable over the years, lagging state of the art apprroaches in several ways, which we will detail in later sections.

In this whitepaper, we propose the creation of an autonomous subteam devoted solely to research and development operations, unburdened with competition-specific deadlines and goals and free to work on impractical, often absurd, projects with the end goal of producing accessible research output with broad applications to other subteams on Arcturus and even to areas beyond the scope of a marine robotics team.
Such a subteam is, to the best of our knowledge, unlike anything that currently exists at Arcturus or other build teams in the Edgerton Center.
It would also have an unparalleled degree of academic freedom compared to other subteams with fundamentally different goals and management structures.

Somewhat counterintuitively, we believe that such a subteam will have not only far-reaching long-term benefits but immediate, practical, and actionable advice.
We claim that this will almost certainly be the case even taking into account the fact that such a team would not be driven to pursue these goals.
Additionally, we claim that the establishment of a research and development (R&D) subteam will drive innovation in all three of Arcturus's currently existing subteams and potentially spur the creation of new ones due to its interdisciplinary and scholarly nature.

For an R&D subteam to be viable and successful, we would need to invest heavily in fundamental research, especially in highly theoretical subjects with broad application domains.
Sustained investment in specific projects, regardless of viability, will be critical to ensuring that a diverse and broadly applicable set of ideas can thrive and make their way into prototyping and projects carried out by other subteams.
We estimate that the R&D subteam would have a research output on par with a specialized research group.

The guiding philosophy of the R&D subteam is quite the opposite of the standard principles underlying most "build teams."
These ideas can best be summarized as the tendency to avoid low-hanging fruit in favor of pursuing what are at present practically unreachable objectives.
The myth of "low hanging fruit" as a means to enable sustained development has long been demonstrated and pondered by numerous authors @kaminska_2017; we claim that Arcturus and other build teams would greatly benefit from a shift to R&D operations.

= Related Work

== Build Teams at MIT

== RoboNation and Njord Challenge Teams

== Other Contexts

= Motivations

== Practical Reasons

== Philosophical Differences

== Economic Concerns

= Research Directions

== Software Deployment Model

== Adversarial Robustness

== Formal Verification

== Applied Mathematics

== Cryptography and Security

== Optimization and Navigation Systems

== Intelligent Perception Systems

= Development and Applications

== Immediate Applications

== Long-term Developments

== Anticipated Applicability of Future Developments

= Guiding Philosophy

== In Research

1. Far-fetched
2. Rigorous
3. Approachable

== In Development

1. Non-invasive
2. Isolated
3. Verifiable

= Conclusion

// Your content goes below.
