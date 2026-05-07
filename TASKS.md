# Task Manager — Budget Travel Bliss

## How to Use This File
- **Before starting work**, check the Active and Backlog sections so you understand what's already planned and don't duplicate effort.
- **When a task is picked up**, move it to Active and note the date.
- **When done**, move it to Completed with a one-line note of what changed.
- **When the user asks for something new**, add it here before implementing — it keeps scope clear.
- Tasks reference `index (1).html` (the only source file). Use `offset`/`limit` when reading it; it's too large for a single Read call.

---

## Active Tasks
_None in progress. Move tasks here when work begins._

---

## Backlog

### Priority: High

#### TASK-001 — Fix duplicate Tbilisi entries in DESTINATIONS data
**What:** `DESTINATIONS` array (around line 296 in the script block) contains Tbilisi three times — ids 2, 15, and 20. Each has different taglines, bestTime, and photo IDs but the same city name and country.
**Why it matters:** Filtering and search return multiple "Tbilisi" results, which confuses users and inflates perceived destination count.
**Acceptance criteria:** De-duplicate to one Tbilisi entry (keep id 2, the highest-rated, merge the best tagline). Update ids of subsequent entries so the array stays contiguous. Verify the destinations grid still renders correctly.
**Touch:** Only the `DESTINATIONS` constant in `<script type="text/babel">`.

---

#### TASK-002 — Fix reused Unsplash photo IDs across multiple destinations
**What:** Several destinations share the same Unsplash photo ID (e.g. `1506905925346-21bda4d32df4` appears on at least 8 destinations; `1558618047-3c8c76ca7d13` on 3+). Photos render from `https://images.unsplash.com/photo-{id}?w=600&q=80`.
**Why it matters:** Cards that should show different places all display the same image, breaking trust and visual variety.
**Acceptance criteria:** Each destination in DESTINATIONS has a unique `photo` ID that visually matches the destination. Run a quick grep to confirm no photo ID appears more than once.
**Touch:** Only the `photo` fields in the `DESTINATIONS` constant.

---

#### TASK-003 — Mobile hamburger menu
**What:** Nav links are hidden at <600px (`@media(max-width:600px) { .nav-links { display: none; } }` around line 221) but no hamburger toggle is implemented. The nav CTA ("Get Deals") is also hidden.
**Why it matters:** Mobile users have no way to navigate between sections.
**Acceptance criteria:** A hamburger icon appears at <600px. Tapping it opens a full-width menu sheet showing all nav links + CTA. Tapping a link or outside the sheet closes it. Sheet uses existing CSS tokens (`--ink`, `--cream`, `--teal`). No new CSS variables introduced.
**Touch:** Nav HTML (~line 271–281), the `<style>` block for mobile nav styles, and the React script for toggle state.

---

### Priority: Medium

#### TASK-004 — Destination detail modal or panel
**What:** Destination cards imply click-through (cursor: pointer, hover effects, a "View Details →" link style) but clicking does nothing — there is no detail view.
**Why it matters:** PRD lists this as the highest-priority gap. Users expect to see visa info, cost breakdown, best time, and a deeper description per destination.
**Acceptance criteria:** Clicking a destination card opens a modal (or a right-side slide-in panel) showing: destination name + country, hero image (larger), per-day cost, best time to visit, climate, local currency, language, and a static "typical day cost breakdown" based on the destination's `dailyCost`. Modal closes on Escape key or backdrop click. All fields come from the existing DESTINATIONS data — no new data required.
**Touch:** Add modal component to the React script block; add CSS for modal overlay + panel; wire card click handler. Do not change DESTINATIONS data structure.

---

#### TASK-005 — Persist trip planner state in localStorage
**What:** The budget calculator (#calculator) resets every time the page is refreshed. Users lose their destination selection, days, and budget tier.
**Why it matters:** The planner is the product's core utility. Losing state on refresh is friction for anyone building a real trip plan.
**Acceptance criteria:** On calculator input change, save `{ destination, days, budget, tier }` to `localStorage` key `btb_planner`. On mount, read from localStorage and restore if present. No UI change needed — this is pure state persistence.
**Touch:** Only the calculator component's `useState` → `useEffect` wiring inside `<script type="text/babel">`.

---

#### TASK-006 — Add aria-labels to icon-only buttons
**What:** Several buttons use only emoji or SVG icons with no accessible label: the gallery lightbox nav arrows, the currency converter swap button, the FAQ chevron icons, and the tweaks panel toggle.
**Why it matters:** Screen readers announce these as unlabelled buttons. Basic accessibility requirement.
**Acceptance criteria:** Every icon-only button has an `aria-label` describing its action (e.g. `aria-label="Next photo"`, `aria-label="Swap currencies"`). No visual change.
**Touch:** Surgical attribute additions in the JSX. Find by searching for `<button` near icon characters.

---

#### TASK-007 — Newsletter form submit feedback
**What:** The newsletter form (#newsletter) has a submit button but no success/error state — submitting does nothing visible.
**Why it matters:** Users don't know if their email was registered. Even without a backend, a success message should appear.
**Acceptance criteria:** On submit, validate email format (basic regex). If valid, hide the form and show a "You're in! Watch your inbox." confirmation message using existing tokens (`--teal`, Cormorant Garamond). If invalid, show an inline error beneath the input. No actual API call needed.
**Touch:** Newsletter component in the React script, plus a small CSS addition for the success state.

---

#### TASK-008 — Sort/filter state reflected in URL hash
**What:** When a user selects a filter (e.g. "Asia") or sort order on the destinations grid, refreshing or sharing the URL loses that state.
**Why it matters:** Users can't share a filtered view (e.g. "all Asia destinations sorted by cost").
**Acceptance criteria:** Active filter and sort are written to the URL hash on change (e.g. `#destinations?region=Asia&sort=cost`). On page load, if hash params are present, restore filter/sort state. Use `window.location.hash` — no router library.
**Touch:** Destinations component state + a small `useEffect` for hash sync.

---

### Priority: Low

#### TASK-009 — Deduplicate reused photo URLs in Gallery section
**What:** The gallery section (#gallery, around line 235) likely reuses some of the same Unsplash IDs used in destination cards. Verify and fix.
**Acceptance criteria:** Gallery images are visually distinct from each other and from destination card images.
**Touch:** Gallery data constant in the script block.

---

#### TASK-010 — Add "Back to top" button
**What:** The page is very long (hero → destinations → pricing → calculator → converter → tips → gallery → testimonials → newsletter → faq → footer). No back-to-top affordance exists.
**Acceptance criteria:** A small circular back-to-top button appears in the bottom-left after scrolling past the hero. It smoothly scrolls to top on click. Uses `--teal` background. Fades in/out with CSS transition.
**Touch:** One new CSS rule, one React component or vanilla JS scroll listener, one button element.

---

#### TASK-011 — Currency converter: flag emoji consistency
**What:** Currency quick-list items use flag emoji (`conv-quick-flag` class). Some currencies may be missing flags or show incorrect flags depending on the OS emoji font.
**Acceptance criteria:** All currencies in the converter's quick-list have a correct and visible flag emoji. Fallback: if a flag is missing, show the 3-letter currency code instead.
**Touch:** Currency data constant in the script block.

---

#### TASK-012 — Remove or wire up Tweaks Panel
**What:** The tweaks panel (`.tweaks-panel`, around line 211 in CSS, with `display: none` by default) is a developer debug tool. It's shipped in the production HTML but hidden. Either wire it to a keyboard shortcut (Ctrl+Shift+T) for intentional dev use, or remove it before any public launch.
**Decision needed from user before implementing.**
**Acceptance criteria:** Either (a) panel is removed entirely from the HTML, or (b) panel is toggled via a keyboard shortcut only and not visible by default.
**Touch:** CSS (`.tweaks-panel` block) + React script for toggle wiring.

---

## Completed Tasks
_None yet._

---

## Decisions Log
_Record user decisions that affect scope or architecture here so future sessions don't re-litigate them._

| Date | Decision | Rationale |
|---|---|---|
| 2026-05-07 | PRD.md created as project context file | User requested "make yourself smarter" — PRD + TASKS give Claude persistent context across sessions |
| 2026-05-07 | TASKS.md created | User requested task manager to track project work |
