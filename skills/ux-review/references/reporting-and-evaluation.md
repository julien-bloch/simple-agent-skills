# Review report, severity, and evaluation

Use this reference to communicate findings clearly and to evaluate whether the review improves a product rather than merely increasing the length of criticism.

## 1. Evidence categories

| Code | Evidence | Permitted claim | Example |
| --- | --- | --- | --- |
| V | Visibly present in provided image/render | A property or spatial relationship is visible | 'Synopsis text occupies a narrow column.' |
| T | Interaction personally exercised in running UI | Specific action was observed in the stated environment | 'At 375px, the last menu option cannot be reached.' |
| C | Verified from source code but not run | Implementation structure implies a risk | 'Custom div has an onClick and no keyboard handler.' |
| H | Hypothesis or inferred user effect | Potential issue that requires testing | 'Users may confuse the two reading statuses.' |
| U | Unknown; insufficient access | Need more evidence | 'Persistence after reload is unverified.' |

An interpretation of **why** a visible feature might confuse users remains a hypothesis even when the feature itself is clearly visible. Combine tags where needed, e.g., `V (layout), H (likely effect)`.

## 2. Severity descriptions

| Severity | Meaning | Typical response |
| --- | --- | --- |
| Critical | Blocks a key task, causes significant harm/data loss, or prevents essential access | Fix before release / immediately |
| High | Serious friction in a common or important flow | Prioritize in the next iteration |
| Medium | Meaningful but nonblocking cost, ambiguity, or inconsistency | Plan targeted correction or test |
| Low | Minor presentation issue without clear task impact | Fix opportunistically, or leave as is |

Prioritize using impact, exposure, reversibility, and confidence. Do not convert these into made-up objective-looking scores. If an issue is important but uncertain, say so and propose a cheap decisive check.

## 3. Finding template

```markdown
### [Severity] [Short, location-specific title]
Evidence: [V/T/C/H/U] [Exactly what is visible or was tested]
User consequence: [Specific task cost or potential risk]
Recommendation: [Concrete change; preserve relevant strengths]
Verify: [Task, state, or viewport that would validate the change]
```

Keep the opening verdict brief. Report 3-7 consequential findings unless the user requested a full audit. Include what should remain unchanged so implementation agents do not remove successful choices. Place objective issues before matters of taste.

## 4. Worked example from a static book recommendation screenshot

**Appropriately supported finding:**

> **Medium - Description is squeezed into the right column.**
> Evidence (V): The cover occupies a left column while a multi-line synopsis is restricted to the narrow right column, creating frequent line breaks and unused width below the cover.
> Consequence (H): This may slow scanning through multiple recommendations.
> Fix: Keep cover/title/author in the first row; let synopsis span the card below, optionally collapsed to a short preview.
> Verify: Compare text wrapping and item density at 375px, then observe readers browsing several cards.

**A second calibrated finding:**

> **Medium - Reading-status menu is visually awkward near bottom navigation.**
> Evidence (V): The open dropdown overlays part of the next card and approaches the fixed tab bar.
> Unknown (U): Whether the final option is actually unreachable or clipped by the tap target area.
> Fix: Confirm its popover bounds; flip the menu above the trigger or use a mobile sheet if necessary.
> Verify: Open the control at 375px near the bottom, select every option, and inspect focus behavior.

**Avoid these unsupported claims:**

- 'Users definitely don't understand the dropdown' (requires user evidence).
- 'The menu is broken' (can't be proven from one static screenshot).
- 'This redesign will boost retention by 20%' (no measurement).
- 'The whole brand should be modernized' (untethered to task).

## 5. What to keep

Provide at least one specific, grounded strength if present:

- Brand coherence across typography, palette, imagery.
- Helpful personalized recommendation explanation.
- Distinct and readable selected navigation state.
- Good content hierarchy or direct path to action.

Don't add generic praise. Name the quality that a developer should preserve during changes.

## 6. When to recommend user research

Use small, realistic task observation when the critical uncertainty is whether people understand or value the interaction:

- Test without coaching; let people attempt real tasks.
- Record actual completion, hesitations, misinterpretations, and recovery.
- Use qualitative samples to locate problems, not to estimate population preference percentages.
- For preference/behavior comparisons, consider controlled experiments or larger representative sampling when feasible.
- Distinguish a usability issue ('can they do it?') from product value ('do they want to?').
