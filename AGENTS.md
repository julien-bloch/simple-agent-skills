# Working agreements

Make the smallest change that satisfies the actual request, fits the repo,
and is hard to misunderstand later.

If the request is ambiguous in a way that changes the implementation, ask one
short question rather than silently building the smallest interpretation.

Before writing code, walk this order and stop at the first step that holds.

1. Does this need to exist at all? If the need is speculative, skip it and
   say so in one line.
2. Does the standard library cover it? Use it.
3. Does a native platform feature or an already-installed dependency cover
   it? Use it before adding anything new.
4. Can it be obvious without a helper or abstraction? Keep it inline.
5. Only then write the minimum code that works.

Correctness is part of "minimum." Do not simplify away validation at trust
boundaries, error handling that prevents data loss, security, accessibility,
or checks that prevent silent wrong results.

In data or scientific code, be especially suspicious of code that runs
cleanly and lies. No silent reshaping, dtype coercion, unit conversion,
broadcasting, or grouping that crosses a fold, animal, subject, batch, or
split boundary. If a shape, dtype, unit, or split assumption is not obvious
from the code, make it fail loudly.

Follow the repo's existing shape. Extend the abstraction that is already there
before adding a smaller bespoke one beside it. Edit the source of truth, not a
generated mirror or downstream copy.

Don't add abstractions nobody asked for. No interface with a single
implementation, no factory for one product, no config for a value that never
changes, no scaffolding for a future that hasn't arrived. Prefer deleting
code to adding it, and prefer boring and obvious to clever.

Keep the diff short: fewest files, fewest moving parts. If two solutions are
the same size, take the one that is correct on edge cases. Writing less code
does not mean picking the flimsier algorithm.

Make surgical changes. Every changed line should trace to the request. Don't
refactor, reformat, rename, or "improve" adjacent code unless the requested
change needs it, and don't modify code or comments you don't fully understand.
Match the existing style even if you'd choose a different one. If you notice
unrelated dead code, mention it; don't remove it unless asked.

For non-trivial changes, decide up front the smallest check that would catch
the failure: a failing repro before a bug fix, an invalid-input check before
validation, or the existing test or command that should pass before and after.
Prefer one targeted check over a new test scaffold.

If I explicitly asked for the full version, build the full version and don't
re-argue it.

When you take a deliberate shortcut, leave a short comment that names the
ceiling and the upgrade path, so it reads as intent rather than an oversight.
Example: `# shortcut: O(n^2) scan, fine under ~1k rows, index if it grows`.

Lead with the code. After it, only flag skipped work if the skip is
load-bearing. If the explanation runs longer than the code, cut the
explanation.
