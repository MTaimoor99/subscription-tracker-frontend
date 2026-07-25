# AGENTS.md

Guidance for AI coding agents working in this repository.

## Project overview

SubsNotifier — a Flutter/Dart mobile app that tracks recurring subscriptions and
pushes reminder notifications before each charge date so the user can make
sure funds are available. The reminder window is a hardcoded 3 days before
the charge date (e.g. a subscription charged on the 23rd triggers reminders
on the 20th, 21st, and 22nd) — not user-configurable. Backend will be a
separate FastAPI service (not in this repo, not yet built); this repo is the
Flutter client only. See [README.md](README.md) for product details.

Planned monetization: multi-card support behind a paywall via RevenueCat
(not yet implemented).

## Tech stack

- **Language/framework**: Dart + Flutter (SDK `^3.8.1`)
- **State management**: Riverpod (`flutter_riverpod`) — `StateNotifierProvider` pattern
- **Routing**: `go_router`
- **HTTP client**: `dio`
- **Lints**: `flutter_lints` via [analysis_options.yaml](analysis_options.yaml)

## Architecture

Code lives under `lib/core/features/<feature_name>/`, split into three layers:

```
<feature>/
  data/datasources/remote/   # raw API calls (e.g. auth_remote_datasource.dart)
  domain/repositories/       # abstract repository + impl, talks to datasources
  domain/services/           # business logic consumed by presentation
  presentation/providers/    # Riverpod providers wiring services/repos/notifiers together
  presentation/state_notifiers/  # StateNotifier classes holding form controllers + state
  presentation/states/       # immutable state classes for notifiers
  presentation/views/        # widgets/pages
```

Existing features: `authentication` (login/register), `subscription_listing`,
`generic`.

Follow the existing layering when adding functionality: datasource -> repository
-> service -> provider -> notifier -> view. Don't call datasources or
repositories directly from views.

Routes are centrally defined in [lib/routes.dart](lib/routes.dart) using
`go_router`; add new pages there rather than pushing raw routes from widgets.

App-wide constants (e.g. backend base URL) live in
[lib/app_constants.dart](lib/app_constants.dart).

## Commands

```
flutter pub get        # install dependencies
flutter analyze         # static analysis / lints
flutter test             # run tests (test/)
flutter run               # run the app on a connected device/emulator
```

There is currently only one test file ([test/widget_test.dart](test/widget_test.dart)).
Run `flutter analyze` and `flutter test` before considering a change done.

## Conventions

- Match existing naming: `snake_case.dart` filenames, `PascalCase` classes,
  provider variables named `xxxProvider`.
- Riverpod providers for a feature live in `presentation/providers/` as one
  provider per file, mirroring the class they expose
  (e.g. `auth_service_provider.dart` -> `authServiceProvider`).
- Repositories are defined as an abstract class (`auth_repository.dart`) plus
  an `Impl` class (`auth_repository_impl.dart`); keep this split for new
  repositories.
- No dedicated `.env`/secrets handling yet — the local backend URL is a plain
  constant in `app_constants.dart`. Don't hardcode secrets into source.

## Google Play Store compliance

This app ships to the Google Play Store. The deployment checklist lives at
[docs/playstore_deployment_checklist.md](docs/playstore_deployment_checklist.md)
— read it before touching Android config, permissions, networking, auth,
notifications, or payments.

**Every change must be checked against Google Play deployment guidelines
before it is considered done.** Concretely, verify the change does not:

- add a permission, identifier, or data collection not declared in the Data
  safety form (or note that the form must be updated);
- introduce cleartext HTTP, hardcoded secrets, or other security issues in
  release builds;
- route digital purchases outside Google Play Billing (RevenueCat wrapping
  Play Billing is fine; external payment links are not);
- break signing, `applicationId`, or `versionCode` expectations;
- conflict with notification, account-deletion, or target-API-level policies.

If a change is potentially policy-affecting, say so explicitly in your summary
and update the checklist if it adds a new deployment task.

## Notes for agents

- This is a small, early-stage codebase — prefer minimal, consistent changes
  over introducing new architectural patterns.
- The backend (FastAPI) is external and not yet built; when adding API calls,
  match the shape already used in `auth_remote_datasource.dart`.
- Platform folders (`android/`, `ios/`, `linux/`, `macos/`, `windows/`,
  `web/`) are mostly Flutter-generated boilerplate — avoid editing generated
  files under `.dart_tool/`, `build/`, or platform `Runner`/`gradle` internals
  unless the task specifically requires a platform-level change.

## Full agent instructions

See [CLAUDE.md](CLAUDE.md) (symlinked to this file) for Claude Code specifically —
the same instructions apply to any agent reading this file.
