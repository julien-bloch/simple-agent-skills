# Browser and implementation review protocol

Follow when the review includes a running website or locally runnable app and the necessary tools are accessible. Do not invent browser output, screenshots, metrics, or user behavior.

## 1. Scope and safety

- Obtain or infer the primary user task, supported devices, and relevant route/state.
- Use a test account and non-sensitive fixtures where possible. Do not mutate real customer data, send messages, purchase things, or delete important content without explicit authorization.
- Identify the app build/route and current data state so observations can be reproduced.
- Avoid unnecessarily changing configuration or adding dependencies merely to perform a critique.

## 2. Representative walkthrough

Use the core path for the screen. For each task:

1. Start from a defined state (not from an accidental leftover state).
2. Record the action the user is trying to perform.
3. Capture the initial screen, relevant control state, and result using available tooling.
4. Click/tap through the flow, including one common alternative or correction.
5. Verify not only appearance but outcome: updated label, navigation, persistence or explicit failure message when relevant.
6. Record the actual outcome as passed/failed/not tested, with viewport and any runtime evidence.

A typical book-feed workflow: open a recommendation, save it, change reading status, return to recommendations, and locate the saved book. Don't infer that status persists simply because its button label changed once.

## 3. Viewport matrix

Choose at least two representative viewports if time permits:

- Narrow phone: 390×844, as in `frontend-workflow`.
- Desktop: 1440×900, or the product's widest supported layout.

Add intermediate width, orientation change, and increased text size if the design is responsive at those breakpoints or the layout appears fragile. Avoid reporting universal coverage from two viewport tests.

Inspect at least:

- Header and bottom navigation: no obstruction of main content.
- Repeated items: stable alignment, readable wrapping, image handling.
- Long content: no clipped title, overflow, or unreadable column width.
- Overlays: anchored correctly, fully reachable, above/below sticky bars as intended.
- Scrolling: no unintended horizontal scroll; context retained after returning.
- Empty, loading, failed fetch, and disabled states where reachable.

## 4. Interaction and keyboard checks

- Tab to major controls and confirm visible focus and meaningful order.
- Activate primary buttons with keyboard when applicable; trigger menus and dialogs without a mouse.
- Check escape / close, focus restoration, and accessibility names of icon-only controls.
- Confirm selected states are announced/represented accessibly when tooling permits.
- Check error messages near fields, not only generic toast text.
- Avoid relying solely on screenshots for keyboard or semantic conclusions.

## 5. Implementation-specific inspection

If source is available, inspect relevant handlers, conditional states, and component semantics. Check for:

- Separate menu toggling vs direct status-change handlers.
- Proper state update and error recovery around network requests.
- Keyboard handling in custom controls rather than inaccessible clickable divs.
- Responsive overflow or fixed-position layout traps.
- Controlled inputs that stay synchronized with server state.
- Duplicate submission and unexpected double-click behavior.

Reading code verifies only implementation intent/structure (**C** evidence). Running the app verifies particular observable behavior (**T** evidence). Neither proves real-user comprehension.

## 6. Tools

Use the Paseo browser tools as described in `frontend-workflow` under "Inspect the rendered UI", and its `fetch` patch under "Force each state" to reach loading and error states. If they aren't available, use whatever browser tool the session has and say which.

- Prefer the accessibility snapshot's roles and names over CSS structure when locating controls.
- Capture screenshots only when they materially support a finding.
- Check console errors and failed requests when they clarify a failure.

If no browser tool is available, write a short **manual verification plan** instead of pretending to have executed it.

## 7. Evidence ledger template

```markdown
Task: [Specific user outcome]
Environment: [Route, viewport, data state]
Action: [What was tried]
Expected: [What should happen]
Observed: [What actually happened]
Evidence class: T / C / V / H / U
Result: Pass / Fail / Not tested
Supporting artifact: [Screenshot, selector, console line, or route if available]
```
