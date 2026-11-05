# Conditional UX review heuristics

Apply these to the user's primary task, not as a fixed scorecard that every screen must satisfy equally. Examine consequences for actual use before visual polish. Separate **demonstrated defects** from **plausible risks** and **style preferences**.

## 1. Task clarity and orientation

- Can someone tell what the screen is for and what they should do next?
- Does the dominant screen mode match the job: overview (scan/compare), focus (inspect), make (create/edit), or do (complete a task)?
- Is the current location apparent, including on deep links and after returning from details?
- Are navigation labels meaningfully distinct? Does back navigation preserve user context?
- Can a user begin without learning underlying technical concepts or answering avoidable setup questions?

**Failure examples:** prominent secondary action that visually displaces the core task; unclear icon-only destination; forced onboarding before first value.

## 2. Scanability and information hierarchy

- What is recognized in the first glance? What requires careful reading?
- Are items distinguishable by meaningful signals, not just cards of similar-looking text?
- Can repeated items be compared without hunting for fields or action controls?
- Does spacing group elements correctly? Are descriptions unnecessarily trapped in narrow columns?
- Does the screen appropriately separate overview scanning from focus evaluation?
- Are high-impact details accessible at the point of decision?

**Tradeoff:** Higher density improves scanning but may obscure essential context. Don't recommend compactness by default; identify whether users are browsing, comparing, or evaluating.

## 3. Affordances, controls, and state

- Does a clickable control look clickable, and does its label reveal its effect?
- Is 'change current state' distinguishable from 'perform default action'?
- Do options in a menu remain visible and tappable near viewport boundaries and fixed navigation?
- Does the UI communicate which options are selected, what changed, and whether it persisted?
- Can users undo or recover from routine mistakes? Is destructive action appropriately guarded?
- Are loading and disabled states clear rather than appearing broken?

**Failure examples:** a split button whose two segments have ambiguous actions; a menu clipped by bottom navigation; a saved status that changes visually but fails silently on the server.

## 4. Text and content

- Are titles and buttons written in the user's language rather than internal product vocabulary?
- Does the interface expose meaningful distinctions when two labels sound nearly synonymous?
- Is explanation concise where quick action matters and available in more detail where evaluation matters?
- Are errors specific and recoverable? Does the system avoid false claims of AI confidence or recommendation accuracy?
- Can the design accommodate missing images, long names, localization, and empty results?

## 5. Visual coherence

- Does visual emphasis track task importance or compete with it?
- Are spacing, type roles, color roles, radii, and elevation consistent?
- Is whitespace communicating grouping, or merely wasting screen area?
- Are borders and shadows justified by structure and depth?
- Are images legible and proportionate, not cropped into ambiguity?
- Does the page preserve the established visual identity without overdecorating?

**Do not** report 'outdated', 'boring', or 'not modern' as usability defects. Describe what is harder to perceive or do.

## 6. Responsive layout and accessibility

- Do long text and navigation controls fit narrow screens and increased text sizes?
- Do overlays open fully inside the viewport, remain scrollable, and avoid sticky controls?
- Are interactive targets comfortably usable by touch, pointer, and keyboard?
- Are focus order, focus visibility, accessible names, status announcements, and error associations sensible?
- Is contrast adequate for text and essential controls? Is meaning conveyed without color alone?
- Are essential interactions accessible without hover or precise pointer movement?

**Evidence distinction:** A screenshot can reveal an apparently tiny target or low contrast but usually cannot confirm keyboard accessibility. Code can reveal missing semantic controls but needs runtime verification for dynamic behavior.

## 7. User goodwill and recovery

- Is the user forced to redo work, supply redundant information, or endure avoidable steps?
- Are dangerous consequences disclosed before action?
- Are errors owned by the product with usable recovery, rather than blaming the person?
- Can common choices be deferred? Is exploratory behavior safe?
- Does the design respect privacy and avoid misleading urgency or manipulative defaults?

## 8. Fit to product and research certainty

- Does the proposed change serve a specific job, or simply follow a popular UI trend?
- Are claimed user preferences verified by actual users, or just plausible theories?
- Would the recommendation be different for a novice versus expert workflow?
- Could user interviews, observation, or a task test answer an unresolved question?
- Is the intervention reversible, cheap, and proportionate to the uncertainty?

## Failure-pattern catalog (conditional, not automatic findings)

| Pattern | What to examine | Plausible correction |
| --- | --- | --- |
| Overstuffed collection card | Does each item occupy excessive viewport space? | Compact summary plus focused details |
| Narrow prose column | Is a paragraph squeezed next to an image? | Move copy beneath identity row, use wider line length |
| Ambiguous status control | Does tapping act or open choices? | Distinct primary action or labeled status selector |
| Floating menu near footer | Is it clipped or inaccessible? | Reposition, flip, or use appropriate mobile sheet |
| Too many equal-weight actions | Is the primary job still clear? | De-emphasize secondary actions |
| Repeated bordered containers | Does depth communicate anything? | Use whitespace, alignment, or subtle surfaces |
| Bare icon navigation | Can users accurately name destinations? | Add concise text labels |
| Unnecessary early choice | Must users configure things before receiving value? | Defer nonessential settings |
| No recovery | Can users undo dismissal or status changes? | Add undo or simple reversible action |
| Empty feed dead end | Is the next useful action visible? | Explain state and provide relevant next step |

## Accessibility caution

Use automated accessibility tools when available, but do not equate a clean scan with accessible usability. Keyboard operation, zoom behavior, accessible state announcements, and assistive technology workflows often require additional checks.
