# Product Requirements Document — Budget Travel Bliss

## What This File Is For
This document gives Claude the context needed to work on this project without re-deriving it every session. Read this before touching any code.

---

## Project Overview

**Budget Travel Bliss** is a travel discovery and budgeting platform. The core promise: show budget-conscious travelers exactly what an international trip will cost, which destinations fit their wallet, and how to stretch every dollar. The audience is solo travelers, digital nomads, and couples who want to see the world on a real-world budget.

The product is a **single self-contained HTML file** — no backend, no build step, no npm. Everything runs in the browser.

---

## File Structure

| File | Role |
|---|---|
| `index (1).html` | The entire product — HTML, CSS, and React JSX in one file |
| `DESIGN.md` | Binance design system reference (imported as inspiration; **not** this project's design system) |
| `CLAUDE.md` | Behavioral guidelines for Claude |
| `PRD.md` | This file |

**Critical:** The main file has a space in its name. Always quote it: `"index (1).html"`. It is ~1,600+ lines and exceeds a single Read window — use `offset` + `limit` to read specific sections.

---

## Tech Stack

| Layer | Choice |
|---|---|
| UI framework | React 18 (CDN via unpkg, no npm install) |
| JSX compilation | Babel standalone (in-browser, also via CDN) |
| Styling | Vanilla CSS with CSS custom properties (no Tailwind, no CSS modules) |
| Fonts | Google Fonts — Cormorant Garamond (display) + DM Sans (body) |
| Data | Hardcoded JS arrays/objects inside the HTML file |
| Currency rates | Hardcoded mock rates (no live API) |
| Images | External URLs (Unsplash / similar) loaded at runtime |
| Build toolchain | None — edit the file directly |

No TypeScript. No linting config. No test suite. Changes go straight into the HTML file and are immediately testable by opening in a browser.

---

## Design System

### Color Tokens (CSS variables)
| Token | Value | Use |
|---|---|---|
| `--cream` | `#faf8f3` | Page background (warm off-white) |
| `--cream2` | `#f4efe4` | Alternate section backgrounds |
| `--ink` | `#1c1917` | Primary text, dark sections |
| `--ink-light` | `#6b6560` | Secondary text, labels, captions |
| `--teal` | `oklch(0.52 0.10 192)` | Primary brand accent — CTAs, links, active states |
| `--teal-light` | `oklch(0.92 0.04 192)` | Teal tints for backgrounds, icon backgrounds |
| `--coral` | `oklch(0.68 0.13 28)` | Secondary accent — badges, highlights, stars |
| `--coral-light` | `oklch(0.94 0.04 28)` | Coral tints |
| `--sand` | `#e8e0d0` | Borders, dividers, hairlines |

### Typography
- **Display / headings:** `Cormorant Garamond` — italic variant used for emphasis (`<em>`), light weight (300) for elegance, 600 for numbers
- **Body / UI:** `DM Sans` — 300 light for body copy, 400 regular, 500 medium for labels, buttons

### Spacing & Shape
- Section padding: `100px 5vw` (desktop) — generous vertical rhythm
- Card border radius: 14–20px on content cards
- Button border radius: `100px` (pill) for primary CTAs; `10px` for form controls
- Elevation: subtle `box-shadow` on cards, no heavy drop shadows

### Do's and Don'ts
- **Do** use `--teal` for all primary interactive elements (buttons, active filters, links)
- **Do** use Cormorant Garamond for large numbers and display headings
- **Do** use `--coral` for emotional highlights (ratings, badges, italic em text in headings)
- **Don't** mix the Binance design system from `DESIGN.md` into this project — that doc is reference material only
- **Don't** add a second primary brand color — teal + coral is the system

---

## Existing Features (Sections)

### 1. Navigation
Fixed top nav, 64px tall, cream background with blur. Logo left, nav links center, "Start Planning" CTA right. Collapses to logo-only on mobile (<600px).

### 2. Hero
Full-viewport section with a background image (low opacity), gradient overlays, animated fade-up text. Contains:
- Eyebrow label, h1 (display font, italic accent), sub-headline
- Search bar with live dropdown (keyboard navigable, filters by destination name)
- Stat counters (e.g. "150+ Destinations", "3,200 Travelers")

### 3. Destinations (`#destinations`)
Filterable, sortable grid of destination cards. Each card has:
- Hero image with badge (region label in coral)
- Destination name (Cormorant), tagline, per-day cost, star rating
- Filter buttons (continent/type), sort by cost or rating
- Cards link to a detail view (or scroll to calculator with destination pre-selected)

### 4. Pricing (`#pricing`)
Grid of pricing cards showing cost breakdowns by category (accommodation, food, transport, activities) for specific destinations. Each card has a dashed-row breakdown and a total in coral.

### 5. Budget Calculator (`#calculator`)
Interactive two-column layout:
- **Left:** Inputs — destination selector, number of days (range slider), daily budget (number input), travel tier selector (Budget / Mid-range / Luxury)
- **Right:** Dark result card showing total trip cost, animated bar breakdown by category, and an "affordability" note
- All calculation is client-side JS, reactive to input changes

### 6. Currency Converter (`#converter`)
Two-column layout:
- **Left:** Amount input + from/to currency selectors with swap button, large result display, rate note
- **Right:** Scrollable quick-reference list of major currencies with their converted values
- Rates are hardcoded mock values (not live)

### 7. Travel Tips (`#tips`)
Grid of tip cards. Each has a large Cormorant number (decorative, sand color), title, and body text. No interactivity.

### 8. Gallery (`#gallery`)
Dark-background section with a CSS grid photo mosaic (first item spans 2×2, fifth spans 2 columns). Images fade in on load. Hover reveals an overlay with destination label.

### 9. Testimonials (`#testimonials`)
Dark-background grid of quote cards. Each has a blockquote (Cormorant italic), author name, avatar (teal circle with initials), location, and coral star rating.

### 10. Newsletter (`#newsletter`)
Gradient (teal-light to coral-light) section with email input + subscribe button. Centered, max-width constrained.

### 11. FAQ (`#faq`)
Accordion list (max-width 720px). Clicking a question toggles the answer with CSS max-height animation. Uses a rotating + icon for open/closed state.

### 12. Footer
Dark (`--ink`) footer with logo, copyright, and 3–4 footer links.

### 13. Tweaks Panel
A fixed floating panel (bottom-right, hidden by default) for live design adjustments (sliders for spacing, color selectors). Used during development/demo.

---

## Data Architecture

All data is declared as JS constants inside `<script type="text/babel">` inside the HTML file. Key data shapes:

```js
// Destination
{ id, name, region, country, tagline, pricePerDay, rating, badge, imageUrl, categories: [] }

// Pricing card
{ icon, title, rows: [{ label, value }], total }

// Currency
{ code, name, flag, rate }  // rate relative to USD

// Tip
{ num, title, text }

// Testimonial
{ quote, name, location, initials, stars }

// FAQ
{ q, a }
```

To add or edit data, locate the relevant array near the top of the `<script type="text/babel">` block.

---

## Known Gaps & Future Work

| Area | Gap | Priority |
|---|---|---|
| Currency rates | Hardcoded mock rates — should integrate a real FX API (e.g. Open Exchange Rates) | Medium |
| Destination images | External URLs can 404 — should use a stable image CDN or Unsplash with stable IDs | Low |
| Mobile nav | Nav links hidden on mobile but no hamburger menu implemented | Medium |
| Destination detail view | Cards suggest clicking through but no detail page exists | High |
| Persistence | No saved trips, no localStorage — planner state resets on refresh | Medium |
| Real search | Search only filters by name substring — no fuzzy match or tag search | Low |
| Accessibility | No aria-labels on icon buttons, no focus-visible styling beyond browser default | Medium |
| Build setup | Growing file size makes the single-file approach increasingly painful to edit | Low (future) |

---

## How to Work on This Project

1. **Before editing**, read the relevant section with `offset`/`limit` — the file is too large for a single Read call
2. **All styles** live in the `<style>` block at the top of the file
3. **All React components** live in `<script type="text/babel">` at the bottom
4. **Data** is declared as `const` arrays/objects at the top of the script block, before any component definitions
5. **Test** by opening the file in a browser — no compile step needed
6. **Surgical edits only** — this file is a single source of truth; avoid duplicating CSS classes or component logic
7. **Do not rename the file** — the space in `index (1).html` is the existing name; renaming would break any existing references

---

## Out of Scope

- Server-side rendering
- User accounts / authentication
- Payment processing
- Mobile app
- Any feature not listed in this PRD without explicit user approval
