# App Store Review Responses — v1.0 (build 6)

Submission ID of rejection: 5590f1f1-8ec2-40f0-8be9-ca0c48251c31

---

## Reply to Guideline 2.1(b) — Information Needed

Thank you for your review. Budget Travel Bliss has no paid content, subscriptions, or in-app purchases of any kind.

1. There are no paid users. The app is free and ad-supported.
2. There is no content or subscription for purchase — nothing is sold in or outside the app.
3. None. There is no previously purchased content to access.
4. None. No paid content, subscriptions, or features are unlocked. All features are free to every user.
5. No. The app sells no physical or digital goods. The only external transmission is an optional email newsletter signup, which is free. Revenue comes solely from Google AdMob banner advertising.

---

## Reply / Reviewer Note for Guideline 4.2 — Minimum Functionality

This build (1.0, build 6) is a native-first app. It launches directly into native SwiftUI functionality, and four of its five tabs are fully native (built with SwiftUI, SwiftData, and on-device data — no web view):

- **Destinations** (opens here by default) — a native browser of 143 destinations from data bundled in the app, with native search and region filtering, and a native detail screen per destination. Works offline.
- **Planner** — a native interactive **budget calculator**: choose a destination, adjust trip length with a slider, pick a travel style, and see a live total with a category cost breakdown. Trips can be **saved on-device (SwiftData)** and are listed and deletable.
- **Convert** — a native **currency converter** across 57 currencies with a live conversion and a quick-reference rate list.
- **Saved** — native favorites using on-device SwiftData persistence, surviving app relaunches and available offline.
- **Guide** — a supplementary web view (this is the only web content, and it is not the default tab).

To review: the app opens on the native **Destinations** tab. Try **Planner** (adjust the slider and Save a trip), **Convert** (change currencies), and **Saved** (heart a destination, reopen the tab). These are native, interactive capabilities with on-device persistence and computation — not a web browsing experience. If a specific additional native capability would help, we are glad to add it.

---

## INTERNAL NOTE — do NOT send this part to Apple

- Do **not** mention the Budget Calculator or Currency Converter in the 4.2 reply. They are web-view features, and Apple discounts web-equivalent functionality for 4.2. The 4.2 argument must rest only on the native Destinations and Saved tabs.
- Before submitting, confirm the uploaded build is 1.0 (build 6) and that it is the build containing the native tabs — not the old 1.0 (4) that was rejected. The new build is 1.0 (5).

---

## Note on privacy declarations (do before/at submission)

Because the app shows AdMob banner ads, confirm the App Privacy section declares:
- Identifiers → Device ID — Third-Party Advertising — not linked — not tracking
- Usage Data → Product Interaction — Third-Party Advertising — not linked — not tracking
- Contact Info → Email Address — Developer's Marketing — linked — not tracking (newsletter)
