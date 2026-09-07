# ios-learn — Monorepo

A collection of Swift/SwiftUI learning projects, each covering a different area of iOS/macOS development.

## Projects

| # | Project | Topics |
|---|---------|--------|
| 01 | [StoreApp](./test/) | Clean Architecture, SwiftData, MapKit, Notifications |
| 02 | [AnimationsApp](./AnimationsApp/) | SwiftUI animations, transitions, Canvas, effects |

---

## 01 — StoreApp

Multi-category product store consuming FakeStore and DummyJSON REST APIs.

### Tech Stack
- **Language:** Swift
- **UI Framework:** SwiftUI
- **Persistence:** SwiftData
- **Architecture:** Clean Architecture (Domain / Data / Presentation)
- **Concurrency:** async/await
- **APIs:** [FakeStore API](https://fakestoreapi.com) · [DummyJSON](https://dummyjson.com)
- **Native APIs:** MapKit, CoreLocation, UserNotifications

### Features
- Login — email/password + Apple, Google, GitHub (mock)
- Multi-category home — 8 product categories from 2 different APIs
- Product list — real-time search, price filter, infinite scroll
- Product detail — rating, description, add to cart
- Favorites — persisted with SwiftData, tap to open detail
- Cart — in-memory with quantity controls and badge counter
- Map — store locations in Lima with user location button
- Notifications — local notification on every cart add

### Architecture
```
Domain/
├── Entities/        → Pure Swift models
└── Protocols/       → Repository interfaces

Data/
├── Auth/            → AuthRepository (mock)
├── Products/        → ProductRepository (FakeStore + DummyJSON)
├── Location/        → LocationManager (CoreLocation)
├── Network/         → NetworkClient (generic URLSession)
└── Notifications/   → NotificationService

Presentation/
├── Auth/   Home/   Products/   Favorites/
├── Cart/   Map/    Profile/    Main/
```

### Credentials (mock)
```
username: admin
password: admin
```

---

## 02 — AnimationsApp

SwiftUI animation playground covering the full animation system.

> Coming soon

---

## Learning Roadmap

- Phase 1 — Swift fundamentals + app structure ✓
- Phase 2 — Clean Architecture + multi-API ✓
- Phase 3 — SwiftData + Cart + Navigation ✓
- Phase 4 — Generics, pagination, validation, filters ✓
- Phase 5 — MapKit, CoreLocation, UserNotifications ✓
- Phase 6 — Animations deep-dive (in progress)
