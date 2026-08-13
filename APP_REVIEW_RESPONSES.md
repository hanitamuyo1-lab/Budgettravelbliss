# App Store Review Responses — v1.0 (build 5)

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

This build adds substantial native functionality beyond the web view. In the bottom tab bar:

- **Destinations tab** — a native SwiftUI browser of 143 destinations loaded from data bundled inside the app, with native search, region filtering, and a native detail screen for each destination. The destination data and detail screens work without a network connection (photos are fetched from the network when available).
- **Saved tab** — a native favorites feature using on-device SwiftData persistence; saved destinations remain available across app launches.

These are native capabilities not provided by a web browsing experience. To review them, please tap the **Destinations** and **Saved** tabs in the tab bar at the bottom of the app, open any destination for its native detail screen, and tap the heart to save it.

---

## INTERNAL NOTE — do NOT send this part to Apple

- Do **not** mention the Budget Calculator or Currency Converter in the 4.2 reply. They are web-view features, and Apple discounts web-equivalent functionality for 4.2. The 4.2 argument must rest only on the native Destinations and Saved tabs.
- Before submitting, confirm the uploaded build is 1.0 (build 5) and that it is the build containing the native tabs — not the old 1.0 (4) that was rejected. The new build is 1.0 (5).

---

## Note on privacy declarations (do before/at submission)

Because the app shows AdMob banner ads, confirm the App Privacy section declares:
- Identifiers → Device ID — Third-Party Advertising — not linked — not tracking
- Usage Data → Product Interaction — Third-Party Advertising — not linked — not tracking
- Contact Info → Email Address — Developer's Marketing — linked — not tracking (newsletter)
