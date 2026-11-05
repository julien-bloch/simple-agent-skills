---
name: frontend-workflow
description: Process for building or reshaping a substantial web interface and checking it in a real browser. Use when adding a new page, screen, or flow to an app, or when asked to improve how a UI looks or works. Covers understanding users and existing patterns, design direction, rendering at desktop and mobile sizes, forcing loading, empty, populated, and error states, and a visual and accessibility critique loop using Paseo's browser tools.
---

# Frontend Workflow

This skill holds the process. Each app keeps its own look: its tokens,
`index.css`, and components. Don't carry one app's visual identity into
another.

## Before building

For anything bigger than a tweak, write down these five things in a few
lines each before you write code:

- **Users**: who uses this screen, and what they already know.
- **Primary workflows**: the two or three things they come here to do, in
  order of frequency. To shape the screen around them (screen mode; list,
  grid or table; menus and state changes; forms), read
  `references/interaction.md`.
- **Design direction**: if the app already has a look, follow it. For a
  landing or marketing page on new visual ground, use the
  `landing-page-design` skill to set the direction. For app screens, read
  `references/app-screens.md`.
- **Existing patterns**: read the app's tokens and stylesheet, its
  `components/ui/`, and one or two existing screens. Reuse what's there.
- **Success check**: one task a person should be able to do on the
  finished screen ("find yesterday's failed run and rerun it"). Mark which
  requirements are known and which are guesses. A redesign keeps every
  feature the screen already had.

Use established components over hand-built ones. In shadcn apps, look in
the registry with `npx shadcn search` / `npx shadcn view` and add a
component with `npx shadcn add`. Don't hand-copy component source.

Don't add runtime dependencies or scaffolding to support this workflow.
The browser tools run outside the app, so nothing ships in the bundle.

## Inspect the rendered UI

Start the app's dev server, then use Paseo's browser tools:

- `browser_new_tab` to open the URL and get a `browserId`.
- `browser_resize` to set the viewport. Check at least desktop (1440×900)
  and mobile (390×844).
- `browser_screenshot` to see the result. Use `fullPage: true` for long
  pages.
- `browser_snapshot` for the accessibility tree and element refs.
- `browser_click`, `browser_fill`, `browser_keypress` for interactions.
- `browser_logs` for console errors and failed requests.

If the Paseo browser tools aren't available, say so and use whatever browser
tool the session has. Don't skip inspection.

## Force each state

Look at each state the screen can be in. Don't stop at the one you happen
to land on.

- **Populated**: realistic data, including long names, many rows, and
  missing optional fields.
- **Empty**: a new account or a cleared list.
- **After an action**: run the main job end to end (act, reload the
  page, find the result) and check that the saved value shows. Leaving and
  coming back without a reload can show a cached value. A save that failed
  must not still look saved, and a double click on submit
  (`browser_click` with `doubleClick: true`) must not submit twice.
- **Menus and dialogs open**: every option is reachable and nothing sits
  under a sticky header or footer. Escape closes it and focus returns to
  the control that opened it.
- **Loading** and **error**: for requests triggered by an action on the
  page, patch `fetch` with `browser_evaluate` and then trigger the action,
  for example:

  ```js
  () => {
    const real = window.fetch;
    window.fetch = (url, opts) =>
      String(url).includes("/api/items")
        ? new Promise(r => setTimeout(() => r(new Response("{}", { status: 500 })), 3000))
        : real(url, opts);
  }
  ```

  The patch is lost on reload. For the initial page load, stop or break
  the backend instead.

Don't add debug flags or mock modes to the app just to reach a state. If a
state can't be reached, say which one.

Shortcut: patching `fetch` only reaches requests made after the page loads,
and a reload undoes it. If this keeps leaving loading or error states
unchecked, it's time to add Playwright MCP at user level for its
network interception (`page.route`). Say so in your report.

## Critique, fix, repeat

At each size and state, check the following.

Visual:
- The primary workflow is obvious, and hierarchy follows importance.
- Spacing, alignment, and type follow the app's tokens.
- Nothing overflows, gets clipped, or overlaps on mobile, or with the
  root font size doubled (`document.documentElement.style.fontSize =
  "200%"` via `browser_evaluate`).
- Images keep their intended proportions and the part that matters
  (crop only on purpose), have space reserved while loading, and show an
  honest placeholder when missing.
- Empty and error states tell the user what to do next.
- On a public-facing page or new visual ground, nothing from
  `references/tells.md` appears without a reason.
- On an app screen, `references/app-screens.md` holds.

Craft (on new visual ground; otherwise only where the app's tokens are
silent):
- The browser's own parts belong to the design: text selection, focus
  ring, scrollbars, link underline offset, tabular figures for numbers.
- The space above a heading is at least twice the space below it.
- Large display type gets tighter tracking as it grows, and headings use
  `text-wrap: balance`. No orphan word on a headline's last line.
- Secondary text is the same face in a softer colour, not a lighter
  weight or a tiny size.
- No cards nested in cards, and no coloured left border on cards, list
  items or callouts.

Taste: judge the screenshots, not the code; you wrote the code and will
read your intentions into it. Make each look on its own:
- **One second, then five.** Glance: there should be exactly one thing
  you saw. Then, as a stranger: can you say what this is, who it's for,
  and what to do next?
- **Squint.** Text blurs into bars. The screen should reduce to two or
  three masses with clear size differences, not many similar ones.
- **Cover the name.** On a landing page: could a competitor or another
  industry use this screen as is? Then it has no idea yet.
- **Edges.** Count the distinct left edges of text blocks: two or three,
  reused on purpose, not six.
- **Space.** Related things are close and unrelated things far; the gap
  between sections is clearly bigger than any gap inside one. Every empty
  region is a rest, not a hole.
- **Type and colour.** The jump from body to headline is decisive, with
  about five sizes at most. The accent covers under about 5% of the
  screen and marks the action, not headings or decoration.

Then name the three weakest things the way a designer would to a
colleague ("the card titles and body are the same weight", not "could be
cleaner"). Fix in this order, since later fixes can't rescue earlier
ones: the idea, hierarchy, composition, type, colour, details, motion. If
nothing would make a demanding designer ask for a change, say so.

Accessibility:
- In the snapshot, every control has a role and a sensible name.
- Tabbing through with `browser_keypress` reaches every control in a
  sensible order, and focus is visible.
- Text contrast and touch-target size hold up. Check computed styles with
  `browser_evaluate` when unsure.
- Actions are buttons and navigation is links, not clickable `div`s.
- Errors are text next to the field they belong to, not only a colour or a
  toast.
- Nothing essential appears only on hover. Animations have a
  `prefers-reduced-motion` rule; the browser tools can't emulate that
  setting, so report it as read from the CSS, not tested.
- No console errors in `browser_logs`.

Fix the meaningful issues, then inspect again at the same sizes and states.
Stop when another pass finds nothing worth changing, or after three rounds.
Report anything you noticed but chose not to fix, and how far each part
was checked: built, seen in screenshots, clicked through, or tried by real
people. Don't present one level as a higher one.

For substantial UI work, get an independent pass from another agent with
the `ux-review` skill (in Workbench, the UX reviewer). Give it the user's
task, the URL or screenshots with their viewport, and the routes changed,
not your reasons for the design. Fix what it justifies, and stop when a
round brings only taste changes.
