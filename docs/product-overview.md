# Walfolio — Product Overview

**Document type**: Product definition
**Status**: Draft
**Last updated**: 2026-11-25
**Owner**: Waldir

---

## 1. Document Purpose and Status

This document defines *what* Walfolio is and *why* it exists. It covers product vision, audience, scope, and product-level requirements.

It deliberately does **not** cover:

- Technical architecture, frameworks, hosting, or build tooling — those belong in `constitution.md` and the technical specification.
- Agent or contributor working rules — those belong in `AGENTS.md`.
- Per-feature behavior and acceptance criteria — those belong in `/specs/*`.

### Status legend

Every substantive statement in this document carries one of these labels or sits under a section that does:

| Status | Meaning |
| --- | --- |
| **Confirmed** | Explicitly stated by the project owner and treated as a requirement. |
| **Proposed** | Suggested direction awaiting approval; may change or be dropped. |
| **Open** | Undecided. Listed in [Section 14](#14-open-decisions) with an identifier; no assumption should be made. |

Where a statement is unlabeled, the section heading defines its status.

### SDD workflow context

Walfolio is built using Spec-Driven Development. The intended flow is:

**Figma → Design Analysis → Specification → Implementation → Visual Validation**

This document is the product-level input to that flow. It precedes design analysis and feature specifications; it does not replace them.

---

## 2. Product Summary

**Confirmed**

Walfolio is a personal developer portfolio belonging to Waldir, a Senior Frontend / Web UI Developer.

The site exists to present:

- Professional experience and technical approach.
- Technical skills and frontend expertise.
- Personal projects and products from the Wal ecosystem.
- Professional journey, interests, and personality.

Walfolio is a **personal brand website**, not a commercial landing page for the Wal ecosystem. Wal products appear as work being built by the site's owner, not as offerings being marketed or sold.

---

## 3. Brand Structure

**Confirmed**

Three distinct concepts must remain visually and verbally separate:

| Level | Name | Role |
| --- | --- | --- |
| Personal brand | **Waldir** | The individual. Voice, authorship, professional identity. |
| Product ecosystem | **Wal** | The family of products built by Waldir. |
| Portfolio project | **Walfolio** | This website. The presentation layer for both of the above. |

Implications:

- The portfolio speaks in Waldir's first person.
- The Wal ecosystem is presented *within* the portfolio as a body of work, with its own subsection and detail pages.
- Walfolio must never read as the Wal ecosystem's marketing site, pricing page, or product funnel.

---

## 4. Product Vision

**Confirmed**

Walfolio should accomplish four things:

1. **Communicate professional identity** — who Waldir is as a developer, clearly and credibly.
2. **Demonstrate frontend capability** — the site itself is evidence of design-to-code skill, not merely a description of it.
3. **Present the products being built** — an honest, current view of the Wal ecosystem.
4. **Document the process** — serve as a working example of shipping a real interface through Spec-Driven Development.

The fourth point is a deliberate constraint on ambition: the project should stay small enough that the specification and validation steps are genuinely exercised rather than nominal.

---

## 5. Audience and Expectations

**Proposed** audience set, based on the target audiences identified in the project context. It is not a confirmed prioritization and does not exclude other visitors. Expected findings are **Proposed** content priorities.

| Audience | What they need | Where they should find it |
| --- | --- | --- |
| Technical recruiters | Role fit, seniority, stack relevance, location/availability, a fast way to make contact | Hero, Skills, Experience, Contact |
| Hiring managers | Evidence of ownership and delivery, scope of past work, communication quality | Hero, Experience, About |
| Engineering leads | Depth of frontend judgment, practices, trade-off reasoning, code quality signals | Experience, Skills, About, the site's own implementation |
| Software development teams | Collaboration style, working principles, reliability | About, Experience, Contact |
| Developers and peers | Interesting projects, technical curiosity, the Wal ecosystem, the SDD approach | Wal Ecosystem, About, Life Outside Code |

Cross-cutting expectation: from the opening section onward, a visitor should be able to establish **who this person is, what they do, and how to reach them** without reading through extended narrative. Identity and a contact path must not be buried deep in the page. This is a usability objective, not a viewport measurement.

---

## 6. Design Reference and Fidelity Intent

**Confirmed**

The primary visual reference is the **Airfolio** Figma Community portfolio template.

- The intention is to implement the original design **faithfully**, adapting content, imagery, and selected sections to Waldir's personal brand.
- The template is **not** loose inspiration. Proposing a different visual identity is out of scope for this project.
- Fidelity is evaluated during a dedicated Visual Validation step against the reference, not by subjective preference during implementation.

**Open**

The template's original section order, naming, and layout composition have not yet been documented here. Detailed section mapping (which template sections are kept, adapted, added, or omitted) is deferred to the dedicated Figma design analysis phase, using the Figma file, screenshots, or exported assets. See **OD-05**.

Until that analysis exists, this document describes **Walfolio's intended sections**, not a claim about what the template contains.

---

## 7. Site Structure

**Confirmed**: the one-page portfolio is the primary surface, and the subjects below correspond to confirmed product intent — professional experience, skills, the Wal ecosystem, personal journey and interests, and a way to make contact.

**Proposed**: this specific section set, its order, and its composition. No section is a confirmed design element until the Airfolio mapping is complete (OD-05).

| # | Section | Content intent | Section status | Purpose | Content expectation |
| --- | --- | --- | --- | --- | --- |
| 1 | Hero / Introduction | Confirmed | Proposed | Establish identity and value proposition immediately | Professional introduction, main value proposition, profile photograph, primary contact or navigation action |
| 2 | Professional Experience | Confirmed | Proposed | Prove seniority and delivery history | Work history, relevant projects, responsibilities, technologies, contributions |
| 3 | About Me | Confirmed | Proposed | Explain background and approach | Professional background, development philosophy, motivations |
| 4 | Skills and Capabilities | Confirmed | Proposed | Make technical breadth legible | Technical skills, frontend expertise, development practices |
| 5 | Wal Ecosystem | Confirmed | Proposed | Showcase products being built | Ecosystem introduction, product cards, product status, links to detail pages |
| 6 | Video Introductions | Proposed | Conditional | Human, spoken introduction | Spanish introduction, English introduction, subtitles for accessibility |
| 7 | Life Outside Code | Proposed | Proposed | Add personality and memorability | Personal interests; a small feature on the cat, Zelda |
| 8 | Contact | Confirmed | Proposed | Convert interest into contact | Professional contact information, professional and social links |

How to read the status columns:

- **Content intent** — the subject must be represented somewhere on the site. "Confirmed" means that obligation comes from the confirmed product context, not that this section is the approved way to satisfy it.
- **Section status** — this named section, at this position, with this composition. All are proposed or conditional; the final mapping is settled in design analysis (OD-05).

Notes:

- Section **order** is provisional pending design analysis (OD-05); the table reflects the proposed narrative sequence.
- Rows 2–4 may be consolidated or reordered if the reference design and content volume favor it. Consolidation is a design-analysis decision, not an implementation shortcut. The depth of experience and skills content is a separate open question (OD-08).
- **Video Introductions** (row 6) is conditional: it ships only if the video content and subtitles exist at build time, and it is dropped rather than stubbed if they do not (OD-10).
- **Life Outside Code** (row 7) is proposed in both content and structure: it depends on the owner's approval of personal content and imagery (OD-07).

---

## 8. Wal Product Ecosystem

**Confirmed**

The portfolio presents the Wal ecosystem as a set of products in progress, each with its own detail page.

### Structure

- The one-page portfolio contains an **ecosystem section** that introduces Wal and lists available product entries.
- Each listed product links to a **dedicated product page** with a fuller description.
- The structure must accept **additional products** in the future without redesigning the section or the page template. A new product is a new entry plus a new page, not a new layout.

### Initial products

| Product | Described as | Maturity |
| --- | --- | --- |
| **Walday** | A daily planning application | In development |
| **Walplay** | A personal streaming-related application | In development |

### Content rules

- Descriptions must reflect **actual maturity**. No feature may be presented as available, released, or usable unless it is.
- Status language must be explicit and visible on both the ecosystem section and the product page.
- No availability dates, roadmaps with committed dates, user counts, or traction claims are to be published.
- No screenshots or demos may imply finished functionality that does not exist.

**Open**: the precise status wording, and whether any product has a public destination to link to, is undecided (OD-04).

---

## 9. Product Goals

**Confirmed** as product goals, derived from the stated purpose of the project. These are directional, not measurable targets.

1. Present Waldir's professional experience and technical capabilities clearly.
2. Strengthen his professional online presence with a credible, current reference point.
3. Showcase real projects and the technical decisions behind them.
4. Demonstrate the ability to translate a Figma design into a functional, faithful interface.
5. Demonstrate Spec-Driven Development as a working practice, through this project's own artifacts.
6. Make it straightforward for recruiters and potential collaborators to make contact.
7. Establish a scalable structure for presenting future Wal products.

No quantitative targets, conversion goals, traffic expectations, or performance scores are defined here. Whether any measurement or quantitative target is adopted at all is **OD-09**.

---

## 10. MVP Scope

**Confirmed** scope boundary. Item-level classification is **Proposed** and derived from the confirmed context.

### Essential

The MVP is complete when all of the following are true:

- **E1 — Responsive one-page portfolio** served as the primary experience, usable on mobile, tablet, and desktop.
- **E2 — Core content sections** present and populated with real content: Hero, Professional Experience, About Me, Skills and Capabilities, Wal Ecosystem, Contact. Their final composition and merging follow design analysis (OD-05); content depth follows OD-08.
- **E3 — Two Wal product detail pages**, one each for Walday and Walplay, reachable from the ecosystem section, describing each product at its true maturity.
- **E4 — Contact path**: at least one working, verifiable route to reach Waldir. Professional and social profile links are confirmed content; the mechanism (link-based versus a third-party hosted form) is decided under **OD-02**, and no form is implied by this item.
- **E5 — Basic SEO**: meaningful page titles, descriptions, shareable link metadata, semantic document structure, and one indexable page per published product.
- **E6 — Accessibility baseline**: keyboard-operable navigation and controls, sufficient color contrast, alternative text for imagery, visible focus states, correct heading structure, and subtitles on any published video. These practices are the working expectation; no formal conformance level is confirmed (OD-06).
- **E7 — Honest presentation**: every claim about experience, skills, and product status is accurate, and no unfinished capability is implied to be available.
- **E8 — Language support**: supporting both English and Spanish is a **confirmed product intention**. What remains undecided is the **depth** of the Spanish experience — full content parity versus a reduced experience — recorded as **OD-01**. How much Spanish content each section carries follows that decision; this item does not by itself require parity in every section.

### Conditional

- **C1 — Bilingual video introductions** (site section 6, Video Introductions), including subtitles, shipped only if the videos and their subtitles are available before implementation of that section.
- **C2 — Life Outside Code** (site section 7), shipped only if the personal content and imagery are approved by the owner.
- **C3 — Additional Wal product entries**, only if a third product reaches a state where an honest page can be written.

### Deferred

Not part of the MVP. These are not permanent exclusions unless a section states otherwise:

- Additional Wal product detail pages beyond the two initial products.
- Languages beyond English and Spanish.
- Rich media beyond portrait photography and the optional introduction videos.
- Analytics or measurement instrumentation — none is included in the MVP unless OD-09 permits it.

### MVP readiness signals

Because no numeric targets are permitted, readiness is assessed qualitatively:

- A first-time visitor can state who Waldir is and what he does after reading the Hero and one adjacent section.
- A recruiter can reach a contact action without searching.
- Both Wal product pages accurately describe an unfinished product without overstating it.
- The rendered site can be compared side by side with the design reference and defended in a visual review.
- Every required section is populated — no placeholder marketing copy, no lorem ipsum, no "coming soon" panels standing in for missing content.

---

## 11. Out of Scope

**Confirmed** exclusions for the initial portfolio. Each is a deliberate boundary, not an oversight.

| Excluded | Reason |
| --- | --- |
| User registration and authentication | No user accounts exist in a portfolio; there is nothing to authenticate for. |
| Administrative dashboards | Content is authored by one person in the repository; an interface for editing it adds no product value. |
| Custom backend services and APIs | The initial portfolio is a presentation surface; presenting content does not require a server that this project builds or operates. This is an **MVP scope decision**, not a permanent architectural restriction — a later approved feature that genuinely needs server capability would be a change to this scope, not a workaround smuggled into implementation. |
| Content management systems | Conflicts with SDD-authored, version-controlled content for this project (see C3 in Section 10). Adopting one would be a scope change, not an implementation detail. |
| E-commerce, pricing, or checkout | Walfolio is explicitly not a commercial surface for the Wal ecosystem. |
| Complex interactive features unrelated to presentation | Motion, effects, or interactions that do not serve communication, fidelity, or navigation are excluded regardless of novelty. |
| Advertising, remarketing, and monetization scripts | Walfolio is not a commercial surface (Section 2), so ad delivery and monetization are excluded. |
| Blog, articles, or changelog | Not part of the confirmed purpose. May be reconsidered later, but not by assumption. |

Two adjacent items are deliberately **not** in this list, because they depend on open decisions:

- **Contact forms** are not excluded. A third-party hosted form requires no custom backend and remains a valid option under **OD-02**.
- **Analytics and tracking** are not excluded here. Whether any analytics or measurement is permitted at all is **OD-09**. Only advertising and monetization scripts are excluded outright, as listed above.

Any addition to this list requires explicit owner approval and should be recorded as a change to this document, not decided inside an implementation task.

---

## 12. Product Principles

**Confirmed** principles. These govern product decisions only.

1. **Design fidelity** — the reference design is implemented as designed; deviations are deliberate, documented, and justified.
2. **Responsive experience** — the portfolio is fully usable at every realistic viewport, not a desktop layout that degrades.
3. **Accessibility** — the site is usable with a keyboard, with a screen reader, and at low vision; accessibility is a requirement, not a polish pass. No formal conformance level has been approved; whether one is adopted, and whether it is externally audited, is OD-06.
4. **Performance** — pages load quickly on ordinary connections and devices; heavy media is used only where it earns its cost.
5. **Maintainability** — content and structure can be updated by one person without specialist knowledge or ceremony.
6. **Honest presentation** — no inflated titles, invented achievements, or implied product availability. Accuracy outranks impressiveness.
7. **Consistent bilingual experience** — English and Spanish are both confirmed as intended experiences, not an afterthought bolted on at the end. The depth of the Spanish experience is set by OD-01.
8. **Simple navigation** — a visitor always knows where they are and how to move or make contact.
9. **Reusable product structure** — adding a Wal product is a content exercise, never a redesign.
10. **The site is the proof** — because the portfolio claims frontend skill, its own quality is part of the product, not a separate concern.

How these principles are technically satisfied is defined in `constitution.md` and the technical specification, not here.

---

## 13. Assumptions

**Proposed** — defaults carried in this document. Each is falsifiable; if any is wrong, the affected section must be revised.

- **A1** — English is the primary language of this document and the default site experience; Spanish is supported. Supporting both languages is confirmed; the depth of Spanish content is not, and follows OD-01.
- **A2** — Walday and Walplay detail pages are internal pages of Walfolio. No external product URLs are assumed to exist.
- **A3** — Contact is link-based (email and professional/social profiles) by default, and no contact form is assumed. This is a proposed default, not a requirement; the mechanism is OD-02.
- **A4** — All copy, photography, video, subtitles, and personal imagery are supplied by the owner. They are content dependencies, not deliverables of this document.
- **A5** — The one-page portfolio is the entry point; product detail pages are shallow, content-only pages reached from it.
- **A6** — No analytics or tracking is included in the MVP by default. This is a proposed default, not a confirmed exclusion: whether measurement is permitted at all is OD-09, and video hosting is OD-03. Advertising and monetization scripts remain excluded outright (Section 11).
- **A7** — All content is authored in the repository and version-controlled. There is no editorial interface (consistent with Section 11).
- **A8** — The site is publicly accessible and indexable; there is no gated or private area.

---

## 14. Open Decisions

**Open** — no assumption should be made about any of these. Each is listed with its impact so it can be closed before the relevant specification work begins.

| ID | Decision | Options | Blocks |
| --- | --- | --- | --- |
| **OD-01** | Depth of the Spanish experience | Bilingual support is already confirmed; the open question is how far Spanish content goes: (a) full content parity in both languages; (b) English-first site with a reduced Spanish experience plus Spanish media; (c) Spanish limited to the video introductions only | All section content models; the language requirement in the specification |
| **OD-02** | Contact mechanism | (a) Links only — email plus professional/social profiles; (b) links plus a third-party hosted form | Contact section scope; the contact-form question left open in Section 11 |
| **OD-03** | Video hosting | (a) External platform embed; (b) self-hosted files; (c) no video in MVP | Conditional item C1; privacy and performance trade-offs |
| **OD-04** | Walday and Walplay status wording | Exact status label and description per product; whether any public destination exists to link to | Ecosystem section copy and both product pages |
| **OD-05** | Airfolio section mapping | Which template sections are kept, adapted, added, or omitted, and in what order | Design analysis phase; final section order and layout |
| **OD-06** | Accessibility conformance target | Whether a formal conformance level is adopted and whether it is externally audited | E6 acceptance criteria |
| **OD-07** | Inclusion of "Life Outside Code" | (a) In MVP; (b) deferred until personal content is ready; (c) omitted | Conditional item C2 |
| **OD-08** | Depth of experience and skills content | Per-role detailed history versus a summarized senior-level narrative | Site sections 2 and 4 (Professional Experience, Skills and Capabilities) |
| **OD-09** | Measurement | Whether any analytics or success measurement is permitted at all; if permitted, which signals are acceptable and whether a third-party service is involved | Privacy posture; E5 and Section 9; the deferred analytics item in Section 10 |
| **OD-10** | Availability of introduction videos and subtitles | Which language versions exist, and in what subtitle format | Conditional item C1 |

---

## 15. Related Documents

| Document | Relationship |
| --- | --- |
| `constitution.md` | Defines engineering principles and non-negotiables. This document defers all technical expression to it. |
| `AGENTS.md` | Defines how contributors and agents work in this repository. Not duplicated here. |
| `/specs/*` | Feature-level specifications and acceptance criteria derived from this overview. |
| Figma reference (Airfolio) | Visual source of truth for layout and styling. Mapping captured during design analysis (OD-05). |

### Change policy

This document is the product source of truth. Changes to vision, audience, scope, or the out-of-scope list should be made here first, with the owner's approval, before appearing in a feature specification.
