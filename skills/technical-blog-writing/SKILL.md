---
name: technical-blog-writing
description: Writes and edits evidence-backed technical blog posts for engineering audiences. Use when drafting a technical article, turning project notes or code into a post, restructuring an engineering write-up, or reviewing a technical blog for clarity and credibility. Covers content and editorial quality only; excludes blog frontend, CMS, hosting, analytics, and SEO implementation.
---

# Technical Blog Writing

Produce useful engineering writing from verified source material. Optimize for a
reader learning something concrete, not for sounding impressive.

## Scope

Use this skill for:

- implementation deep dives
- architecture and migration stories
- performance investigations and case studies
- incident reviews and engineering lessons
- tutorials grounded in a working system
- research-to-product explanations

Do not use it to design or implement a blog, CMS, frontend, publishing pipeline,
analytics, or SEO infrastructure. Do not turn product marketing into a
technical post by adding code-shaped decoration.

## 1. Establish the editorial contract

Infer answers from the user's material first. Ask only for missing decisions
that materially change the article:

1. Who is the primary reader, and what can they already be expected to know?
2. What should that reader understand or be able to do afterward?
3. What is the article's single-sentence claim or promise?
4. Which post type above best fits the material?
5. What evidence is available: code, benchmarks, profiles, traces, diagrams,
   experiments, incident timelines, screenshots, or external sources?
6. What must remain private, anonymized, or explicitly disclosed?
7. Is there a target publication, length, or voice sample?

When the user supplies voice examples, infer sentence rhythm, formality,
technical density, use of humor, and formatting habits. Otherwise use a direct,
practitioner voice: precise, calm, and low on hype.

## 2. Build from sources, not memory

Read the available notes, code, tests, issue history, measurements, and prior
drafts. Extract:

- the concrete problem and why it mattered
- the constraint that made the obvious solution insufficient
- attempted approaches and why they failed
- the key design decisions and trade-offs
- the surprising discoveries
- how each important claim was validated
- the result, including limitations and unresolved questions

Separate verified facts from interpretation. Mark unsupported claims and ask
for evidence; never invent metrics, dates, customer stories, quotations,
biographical facts, implementation details, or causal explanations.

For changing external facts, prefer primary sources and record links while
researching. Distinguish measured results from estimates.

## 3. Choose a narrative spine

Write a one-sentence spine:

> Because [constraint/problem], we [decision or method], which produced
> [verified result] and taught us [transferable insight].

Every major section must advance this spine. Remove interesting details that do
not support it, or move them to a clearly useful appendix.

Organize the body by reader questions, concepts, system layers, or discoveries.
Do not replay a chronological work log unless sequence itself explains the
result, as in an incident timeline.

## 4. Design the outline

Use the smallest structure that fits the article:

1. **Lede:** Start with the concrete problem, result, contradiction, or artifact.
   Give the reader the payoff and scope early.
2. **Context and constraints:** Explain only the background needed to understand
   the decisions.
3. **Approach:** State the model, methodology, or architecture before details.
4. **Technical body:** Walk through the important decisions in a logical order.
5. **Validation:** Show how the result was measured or cross-checked.
6. **Implications:** Explain what transfers to other systems and what does not.
7. **Conclusion:** Restate the durable lesson and remaining limitations without
   repeating the whole article.

For each section, write its purpose and evidence before drafting prose. Combine
or delete sections with the same purpose.

## 5. Draft with an evidence cadence

Attach important claims to the most appropriate artifact:

- architecture or data flow → a diagram
- behavior or API usage → a short, runnable code example
- performance → benchmark method, workload, environment, and results
- operational behavior → logs, traces, profiles, or an incident timeline
- design choice → alternatives considered and explicit trade-offs
- research claim → a primary source or reproducible experiment

Introduce concepts before using them. Explain why a snippet or figure matters;
do not make the reader reverse-engineer the point. Prefer a focused excerpt over
a wall of code.

Use exact nouns, versions, units, and numbers when verified. State uncertainty
directly. Distinguish correlation from causation and local observations from
general conclusions.

## 6. Edit in passes

Run these passes separately:

### Structural pass

- Does the opening state a real problem or payoff?
- Does each section answer one reader question and add new information?
- Are concepts ordered from prerequisite to consequence?
- Is the result visible early rather than buried?
- Are failures included only when they teach something?

### Technical pass

- Can every factual claim be traced to supplied evidence or a cited source?
- Are benchmark comparisons fair and reproducible?
- Are alternatives and trade-offs represented accurately?
- Do code and diagrams agree with the prose?
- Are limitations, security concerns, and disclosure boundaries explicit?

### Language pass

- Replace generic openings such as "In today's rapidly evolving landscape."
- Delete filler transitions, throat-clearing, hype, and self-congratulation.
- Prefer short, direct sentences, then vary rhythm naturally.
- Replace vague scale words with sourced numbers or honest qualitative language.
- Remove rhetorical questions that delay an answer.
- Expand acronyms and define specialized terms on first use.

### Reader pass

- Can the intended reader explain the main idea after one read?
- Can they tell which parts are facts, measurements, and opinions?
- Do they know when the approach applies and when it does not?
- Is there a concrete next step or takeaway?

## Delivery

Unless the user asks for another format, provide:

1. the working title
2. the one-sentence narrative spine
3. the outline
4. evidence gaps or claims requiring confirmation
5. the draft
6. a short pre-publication checklist

If critical evidence is missing, produce the outline and targeted questions
instead of laundering assumptions into polished prose.

## Influences

This workflow synthesizes useful content-writing ideas from:

- [technical-blog-post](https://github.com/sam-dumont/claude-skills/blob/HEAD/plugins/technical-blog-post/skills/technical-blog-post/SKILL.md)
- [writing-tech-post](https://github.com/pedronauck/skills/blob/main/skills/mine/writing-tech-post/SKILL.md)
- [article-writing](https://github.com/affaan-m/everything-claude-code/blob/main/.cursor/skills/article-writing/SKILL.md)
- [building-blog](https://github.com/BuildShipGrowRepeat/nextjs-sanity-blog-skill/tree/main/skills/building-blog), with its frontend and CMS concerns intentionally excluded

## Maintenance note

These repositories were reviewed in August 2026 and are research inputs, not
dependencies or authoritative upstreams. Before a substantial revision, search
GitHub again for technical-blog-writing `SKILL.md` files and compare newer
skills for evidence handling, engineering-post structure, editing checks, and
source verification. Keep this skill content-only even if a better reference
also contains CMS, frontend, SEO, or publishing implementation.
