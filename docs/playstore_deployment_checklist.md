# Google Play Store Deployment Checklist — SubsNotifier

Working checklist for getting this app onto the Play Store and keeping it
compliant. Items marked **[BLOCKER]** will cause rejection or a broken release
if not fixed. File paths refer to this repo.

## 1. App identity & build config

- [x] Unique `applicationId` set (`com.taimoor.subsnotifier` in
      [android/app/build.gradle.kts](../android/app/build.gradle.kts)) —
      cannot be changed after first Play upload.
- [ ] **[BLOCKER]** `namespace` is still `com.example.subscription_tracker_frontend`
      in `build.gradle.kts`. Play rejects `com.example.*` application IDs; the
      applicationId is fine, but update the namespace (and Kotlin package dirs)
      to match `com.taimoor.subsnotifier` for consistency.
- [ ] **[BLOCKER]** `android:label` in
      [AndroidManifest.xml](../android/app/src/main/AndroidManifest.xml) is
      `subscription_tracker_frontend`. Change to the user-facing name
      (`SubsNotifier`) — this is the name shown under the icon.
- [ ] Replace the default Flutter launcher icon (`@mipmap/ic_launcher`) with
      the real app icon (all densities; consider `flutter_launcher_icons`).
- [ ] Set a real `version` in [pubspec.yaml](../pubspec.yaml) (currently
      `1.0.0+1`). Bump the build number (`+N`) on **every** upload — Play
      rejects duplicate `versionCode`s.

## 2. Signing

- [ ] **[BLOCKER]** Release build currently signs with the **debug** keystore
      (`signingConfig = signingConfigs.getByName("debug")` in
      `build.gradle.kts`). Play will not accept debug-signed builds:
  - [ ] Generate an upload keystore (`keytool -genkey ...`).
  - [ ] Create `android/key.properties` (never commit it — verify it's in
        `.gitignore`) and wire it into a proper `release` signing config.
  - [ ] Enroll in **Play App Signing** (default for new apps) — Google holds
        the app signing key, you keep the upload key.
  - [ ] Back up the upload keystore + passwords somewhere safe outside the repo.

## 3. Network & security

- [ ] **[BLOCKER]** `android:usesCleartextTraffic="true"` is set in the
      manifest and [lib/app_constants.dart](../lib/app_constants.dart) points
      at `http://10.0.2.2:8080` (local dev). Before release:
  - [ ] Production FastAPI backend must be served over **HTTPS**.
  - [ ] Point the app at the production URL for release builds (use
        `--dart-define` or flavor-based config rather than editing constants
        by hand).
  - [ ] Remove `usesCleartextTraffic="true"` (or scope it to debug builds via
        a debug-only manifest overlay).
- [ ] No secrets/API keys hardcoded in Dart source (they are extractable from
      the bundle).

## 4. Play policy compliance

These map to Play Console declarations — get them wrong and the release is
rejected or the app is taken down later.

- [ ] **Privacy policy URL** — required (the app collects email + password).
      Must be a live, publicly accessible page.
- [ ] **Data safety form** — declare collection of email address (account
      management), and any device identifiers your stack sends. Must match
      actual app behavior.
- [ ] **Account deletion** — apps that allow account creation must offer
      in-app account deletion **and** a web URL for deletion requests
      (declared in the Data safety form). Needs backend support — plan the
      FastAPI endpoint for this.
- [ ] **Notifications** — the core feature is reminder push notifications:
  - [ ] Request the `POST_NOTIFICATIONS` runtime permission (Android 13+) —
        without it, notifications silently fail on modern devices.
  - [ ] Notifications must be user-expected (they are — subscription
        reminders) and not used for ads/promos without opt-out.
- [ ] **Payments / subscriptions** — the planned USD 10/month multi-card
      paywall sells a digital service, so it **must** use Google Play Billing.
      RevenueCat on Android wraps Play Billing, which is compliant — do **not**
      route around it with external payment links.
  - [ ] Configure the subscription product in Play Console before shipping the
        paywall.
- [ ] **Target API level** — Play requires new apps/updates to target a recent
      Android API level (raised annually; check
      [current requirements](https://developer.android.com/google/play/requirements/target-sdk)).
      Keeping Flutter up to date generally satisfies this; verify
      `flutter.targetSdkVersion` meets the current floor before each release.
- [ ] Review permissions: currently only `INTERNET` (fine). Any new permission
      added later must be justified in the Play Console declarations.

## 5. Play Console setup (one-time)

- [ ] Google Play developer account registered ($25 one-time) and identity
      verified.
- [ ] App created in Play Console with final name, default language, and
      app/game + free/paid declarations (note: "free" cannot be changed to
      "paid" later; in-app subscriptions are fine in a free app).
- [ ] Store listing: short description (80 chars), full description
      (4000 chars), screenshots (min 2 per supported device type), app icon
      (512×512), feature graphic (1024×500).
- [ ] Content rating questionnaire completed.
- [ ] App category + contact details set.

## 6. Build & release

- [ ] Build an **App Bundle**, not an APK: `flutter build appbundle --release`
      (Play requires `.aab` for new apps).
- [ ] `flutter analyze` and `flutter test` pass.
- [ ] Test the release build on a real device (`flutter run --release`) —
      debug-only behaviors (e.g. `10.0.2.2` emulator URL) surface here.
- [ ] Upload to **internal testing** track first; verify install, login flow,
      and notifications on a Play-delivered build.
- [ ] Roll out: internal → closed/open testing → production (staged rollout
      recommended for later updates).

## 7. Every subsequent release

- [ ] Bump `version` in `pubspec.yaml` (new `versionCode`).
- [ ] Re-check the Data safety form if the app collects anything new.
- [ ] Re-check target API level floor (deadline is usually Aug 31 each year).
- [ ] Update store listing screenshots if the UI changed materially.
