# Web Build Loop

Use this domain loop for public websites whose primary goal is communication,
trust, conversion, search visibility, or content discovery. Always run it after
`core-loop.md`.

## Suitable Tasks

Use for:

- Personal blog, portfolio, landing page, product intro, sale page, waitlist
  page, newsletter site, course page, service site, docs site, event page, or
  community landing page.

Do not use as the primary loop for:

- Authenticated SaaS dashboards.
- Banking, payment, or checkout flows.
- Heavy authorization or private data workflows.
- Data pipelines or ML workflows.

For those, use `web-app-loop.md`, `api-backend-loop.md`,
`data-pipeline-loop.md`, or `security-risk-loop.md`.

## Inputs

Gather or infer:

- Site type.
- Primary audience.
- Main user problem.
- Value proposition.
- Primary and secondary CTA.
- Brand tone.
- Required sections.
- Content source.
- Assets: logo, images, icons, screenshots.
- Tech stack and deployment target.
- SEO, analytics, and consent requirements.

Ask the human only when missing information changes positioning, compliance,
payment behavior, privacy, or conversion direction.

## Loop

```text
Task
  -> Core intake and lane
  -> Identify site type and audience
  -> Define page goal and CTA
  -> Create or update page contract
  -> Plan information architecture
  -> Implement smallest vertical slice
  -> Verify UX, SEO, accessibility, performance, links, forms
  -> Repair
  -> Record proof and trace
```

## Page Contracts

Create or update product docs when the page has product truth:

- `docs/product/site-brief.md`
- `docs/product/pages.md`
- `docs/product/content.md`
- `docs/product/seo.md`

Minimum page contract:

```text
Page type:
Audience:
Goal:
Primary CTA:
Secondary CTA:
Required sections:
Content constraints:
SEO metadata:
Proof required:
```

## Page Type Defaults

| Page type | Default section flow |
| --- | --- |
| Landing or product intro | Hero, problem, solution, benefits, how it works, proof, offer, FAQ, final CTA |
| Sale page | Pain/desire, offer, outcomes, included items, proof, pricing, guarantee, FAQ, checkout CTA |
| Portfolio | Hero, expertise, selected work, experience, writing, proof, contact CTA |
| Blog | Author positioning, featured posts, topics, recent posts, about, newsletter CTA |
| Docs site | Problem, quick start, concepts, guides, reference, examples, support path |

## Implementation Order

1. Route or page shell.
2. Layout container and responsive grid.
3. Hero section and CTA.
4. Required content sections.
5. SEO and social metadata.
6. Form or link behavior.
7. Visual polish.

Rules:

- Use semantic HTML.
- Do not invent fake testimonials, fake logos, fake metrics, or unsupported
  claims.
- Mark placeholder content clearly.
- Keep styling consistent with the existing design system.
- Use real or generated bitmap assets where a visual website needs assets.

## Verification

Use the strongest available proof:

| Layer | Proof examples |
| --- | --- |
| Quick | lint, typecheck, build |
| Component | CTA component, form validation, content parser |
| E2E | CTA click path, lead form, mobile menu, navigation links |
| Platform | preview server, static export, deployment preview |
| Manual UX | desktop and mobile screenshot review, link check, metadata review |

Web-specific checklist:

- Above-the-fold message is clear.
- Primary CTA is visible on desktop and mobile.
- Required sections exist.
- Links and buttons have clear behavior.
- Forms have labels, success, and error states.
- Title, description, canonical, and Open Graph metadata exist when applicable.
- Meaningful images have alt text.
- Text contrast and focus states are acceptable.
- Images are optimized and avoid layout shift.

## Stop And Escalate

Stop and ask the human when:

- Brand positioning is missing and cannot be safely inferred.
- Legal, medical, financial, or compliance claims are involved.
- Payment, checkout, or paid offer behavior is requested.
- User data collection requires privacy policy, consent, or provider setup.
- Requested copy makes unsupported claims.
- SEO migration can break existing URLs or ranking.
- The page has multiple incompatible goals and no clear CTA.

## Done Definition

- Core intake and lane are recorded.
- Page type, audience, goal, and CTA are clear.
- Required sections are implemented or blocker is documented.
- Responsive behavior was checked or limitation recorded.
- SEO metadata is present or not applicable.
- Links, CTAs, and forms were checked.
- Verifier was run when available.
- Story proof and trace are recorded for normal/high-risk work.

## Prompt Template

```text
Read docs/loops/core-loop.md and docs/loops/web-build-loop.md.

Task: <build or change this website>

Identify site type, audience, goal, CTA, required sections, and verifier.
Create/update the page contract and story when needed. Build the smallest
vertical slice, verify UX/SEO/accessibility/performance/links/forms, repair
within the attempt budget, and record proof plus trace. Do not invent fake
social proof or unsupported claims.
```
