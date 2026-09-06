# iOS Learn — FakeStore App

A Swift/SwiftUI learning project built with Clean Architecture, consuming multiple public REST APIs.

## Tech Stack

- **Language:** Swift 6
- **UI Framework:** SwiftUI
- **Persistence:** SwiftData
- **Architecture:** Clean Architecture (Domain / Data / Presentation)
- **Concurrency:** async/await
- **APIs:** [FakeStore API](https://fakestoreapi.com) · [DummyJSON](https://dummyjson.com)

## Features

- **Login** — email/password + Apple, Google, GitHub (mock)
- **Multi-category home** — 8 product categories from 2 different APIs
- **Product list** — real-time search with `.searchable`
- **Product detail** — rating, description, price
- **Favorites** — persisted locally with SwiftData
- **Cart** — in-memory cart with quantity controls and badge counter

## Architecture

```
Domain/
├── Entities/        → Pure Swift models (Product, Category, FavoriteProduct)
└── Protocols/       → Repository interfaces (no framework dependencies)

Data/
├── Auth/            → AuthRepository (mock login, social login stubs)
└── Products/        → ProductRepository (FakeStore + DummyJSON), DTOs + mappers

Presentation/
├── Auth/            → AuthViewModel + LoginView
├── Home/            → HomeView + CategoryCardView
├── Products/        → ProductsViewModel + List/Detail/Row views
├── Favorites/       → FavoritesView (@Query + SwiftData)
├── Cart/            → CartViewModel + CartView + CartItemRowView
├── Profile/         → ProfileView
└── Main/            → MainTabView (root navigation)

App/
└── testApp.swift    → Entry point, routes Login ↔ MainTabView
```

## Credentials (mock)

```
username: admin
password: admin
```

## Learning Goals

This project covers Swift/SwiftUI Phases 1–3 of a self-taught iOS roadmap:

- Swift fundamentals: optionals, structs, protocols, enums, closures
- SwiftUI: state management, navigation, async image, TabView, LazyVGrid
- Clean Architecture: separation of concerns, protocol-based dependency injection
- SwiftData: @Model, @Query, ModelContext
- Networking: URLSession async/await, JSONDecoder, multi-API DTOs
