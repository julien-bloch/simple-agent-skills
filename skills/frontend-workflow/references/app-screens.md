# App screens

For dashboards, settings, editors, admin views, and other screens where someone comes to get a job
done. Quality here is consistency and clarity, not identity. A regular user of similar tools
should find their way around first and register the style only later. An existing app look overrides
everything below.

Distilled from [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill)@12af471
(`references/app-screens.md`).

## What the screen is for

- **One question.** Write the question the screen answers first, in one line ("Which deploy broke?",
  "Who is waiting for a reply?"). The biggest thing on the screen answers it and is read first.
- **One finding.** If the data has a fact that needs attention, put it under the title or the
  headline figure, next to the action it drives, not in a caption at the bottom of a card.
- **Every block answers a next question.** A block with no question is deleted. This avoids the stock
  KPI row, big chart, two small charts, table.
- **The most frequent job is one click away**, with its control where the answer shows: a primary
  button in the title row, or an action on the row that needs it.

## Layout

- **One left edge and one right edge** from the header to the last row. Title, card titles, numbers
  and charts start on the same line. Content reaches the right edge; no dead strip.
- **The grid fits the items.** Choose the column count from the number of items. Four tiles in a
  three-column grid orphans one; a lone card spans the row.
- **Cards in a row share a bottom edge.** Balance by content first. Don't stretch a card over empty
  space: let it keep its height, or pin only an action or a total to its foot.
- **Narrow blocks don't span the canvas.** A short table or list stretched across a wide screen
  leaves voids between a name and its figures; pair it with the next block.
- **Group, don't box.** A set of KPIs is one panel split by dividers, not four cards. No cards
  nested in cards.

## Surfaces and tokens

- **A border or a shadow, never both.** Real shadows are for what floats: menus, popovers, tooltips.
- **Radius is tight (4–8px) or soft (16–24px)**, chosen once. Controls follow the cards; nested
  radii step down.
- **Spacing on a 4px base**, from a scale, not one-off values.
- **About five type sizes, far apart.** If two sizes look almost the same, make them the same.
- **Colour only on data, status, and the one primary action.** The main data element carries the
  one hue. Status colours appear only where they mean something.
- **Icons from one library**, outline, one stroke weight, grey. Never in a saturated circle or
  tinted square.
- **Controls are the standard ones** the platform and the app's component library provide. Never a
  costume of some other interface (a terminal prompt, an instrument bezel).

## Data

- Figures use tabular numbers and are right-aligned in tables. Numbers that appear twice agree, and
  totals add up from the values shown.
- A zero looks like a zero; a missing value is a dash. Every relative figure says what it's relative
  to.

## Density

Density is three settings moved together: row height, padding, and type size. Don't shrink the type
and keep the padding. Sparse screens (homes, settings, one object) get generous rows and padding;
dense ones (monitoring, research, long sessions) get tight rows framed by generous gutters.

Placed space reads as calm; leftover space reads as unfinished. Emptiness from a fixed grid and
repeated gaps is fine. Emptiness from a grid that doesn't fit the data is a hole.
