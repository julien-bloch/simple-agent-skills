# Interaction patterns and task-based choices

Use this reference when deciding how a feature should be structured or how the user should move through it. Patterns are conditional choices, not a catalog to include by default.

## 1. Classify the dominant screen mode

| Dominant mode | Main user question | Typical components | Failure to avoid |
| --- | --- | --- | --- |
| Overview | What is here, and which item matters? | List, compact cards, grid, search, sort, filters | Making every item a full detail page |
| Focus | Is this item right for me, and what can I do with it? | Detail page, evidence, images, contextual actions | Hiding crucial facts behind decorative sections |
| Make | How do I create or edit this accurately? | Editor, form, preview, autosave, history | Losing work or forcing all decisions upfront |
| Do | How do I complete this task? | Clear steps, defaults, progress, validation, result | Long unstructured forms or unclear completion |

Mixed screens are fine. Choose which mode has priority. Design a transition to another mode rather than trying to give every mode equal space.

## 2. Pick collection patterns from the comparison task

| Primary task | Prefer | Reconsider |
| --- | --- | --- |
| Rapid scan of many text-heavy items | Compact vertical list with consistent title, metadata, and action placement | Full paragraphs and tall cards |
| Scan visually recognizable items | Thumbnail grid with visible names/states | Tight text-only list if images are the primary discriminator |
| Compare several attributes across items | Table or aligned rows on wide screens; focused comparison presentation on mobile | Visually varied cards with attributes in different places |
| Explore recommendations with short explanations | Compact cards with a concise why-this-item note; detail on demand | Endless carousels or full descriptions inside narrow columns |
| Examine one object in depth | Detail/focus view with evidence and persistent relevant actions | Repeating that entire focus view for every list item |
| Navigate a long known dataset | Search, filters, sort, and visible result count | Infinite scroll with no retrieval or position cue |
| Browse serendipitously | Continuous feed may fit; preserve scroll position and show progress when useful | Forced pagination that interrupts discovery |

A carousel is a valid secondary feature when the item set is small and curation matters. It is usually weaker for scanning/comparing a large collection because items are concealed.

## 3. Progressive disclosure with safeguards

Reveal information at the point of need while retaining access to it. Prioritize content in three levels:

1. **Identity and decision trigger:** enough to recognize or shortlist an item.
2. **Decision evidence:** enough to evaluate it responsibly.
3. **Deep reference:** optional explanation, history, advanced settings, and supporting detail.

Put level 1 directly in overviews. Provide level 2 inline or one unmistakable action away, based on how consequential the decision is. Place level 3 in an expanded or focus view. Never hide high-risk warnings, prices, irreversible consequences, or critical eligibility details behind optional disclosure.

Do not equate reduced word count with better comprehension. Preserve information that materially changes a decision.

## 4. Navigation and orientation

- For a few equally important top-level destinations, a stable tab bar can work. Use recognizable, distinct labels and visible current-location cues.
- For large content structures, provide a clear path from collection to item and a predictable return without losing scroll position or selections.
- A user arriving at a deep link must still understand the object, location, and available actions.
- Keep navigation stable across screens; avoid moving frequent actions without reason.
- Prefer ordinary labeled navigation over icon-only controls when meaning is ambiguous.
- Preserve user context when they change direction mid-task. Returning from details should not unexpectedly reset search/filter state.
- Do not manufacture a new global navigation system to solve a single local screen problem.

## 5. Actions, menus, and state changes

Before choosing a control, answer:

- Does this tap immediately perform an action, or open a set of options?
- Is there a current state? How is it represented in text and visually?
- How does the user know the action succeeded? What changes elsewhere?
- Could they accidentally trigger it? Can they undo or correct it?
- Is the action common enough to deserve direct access?

**Direct action:** Use a button labeled with a verb that matches its effect (e.g., `Save book`).

**Select among statuses:** Use a select/list/menu with a clearly labeled trigger (e.g., `Reading status: Want to read`), show the selected option, and update the trigger after selection. Use native controls when appropriate.

**Split button:** Use only when the primary segment performs an explicit, unsurprising default action and the adjacent segment opens alternatives. Do not create a split button with two areas whose differing behavior must be guessed.

**Context menu:** Anchor it near the trigger, keep all options reachable, prevent clipping by sticky headers/footers, support escape and outside dismissal, and restore focus after closing. On mobile, a sheet can be better if a popover would be cramped; do not automatically use a sheet for every menu.

**Destructive action:** Prefer undo when feasible; use confirmation for genuinely irreversible or high-cost actions. Avoid confirmation fatigue for routine reversible actions.

## 6. Forms and complex flows

- Ask only for information required now; defer optional decisions.
- Accept forgiving input formats when feasible; offer autocomplete where high-confidence data exists.
- Prefill reliable known values without hiding the ability to edit them.
- Validate near the relevant field, using instructions that tell users how to recover.
- Preserve work across navigation, temporary network errors, and back actions when appropriate.
- Separate task completion feedback from background synchronization if the latter can fail.
- Prefer a small number of clear steps over either one massive form or excessive wizard steps.

## 7. Patterns for user behavior

- **Safe exploration:** Make experimenting reversible and clearly communicate consequences.
- **Instant feedback:** Show a result or progress indicator soon after meaningful actions.
- **Satisficing:** Make promising options recognizable without careful reading.
- **Deferred choice:** Don't force unimportant settings or categorizations upfront.
- **Change of direction:** Let people backtrack or switch tasks without losing work.
- **Incremental construction:** Make partial progress worthwhile and recoverable.
- **Habituation:** Keep repeated interactions visually and behaviorally consistent.

## 8. Quick tradeoff questions

1. What is the user likely trying to accomplish within the next 10 seconds?
2. What is the smallest amount of information needed to act responsibly?
3. What might they reasonably misunderstand about the primary control?
4. What happens if content is missing, unexpectedly long, or the list is empty?
5. What is a common failure path, and how do they recover?
6. Is the selected pattern justified by behavior, or is it simply fashionable?
