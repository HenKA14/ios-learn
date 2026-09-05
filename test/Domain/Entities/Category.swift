import SwiftUI

struct Category: Identifiable {
    let id: String
    let nombre: String
    let icono: String
    let color: Color
    let fuente: Fuente

    enum Fuente {
        case fakeStore(categoria: String)
        case dummyJSON(categoria: String)
    }

    static let all: [Category] = [
        Category(id: "mens-clothing",    nombre: "Ropa Hombre",      icono: "tshirt.fill",   color: .blue,   fuente: .fakeStore(categoria: "men's clothing")),
        Category(id: "womens-clothing",  nombre: "Ropa Mujer",       icono: "bag.fill",      color: .pink,   fuente: .fakeStore(categoria: "women's clothing")),
        Category(id: "electronics",      nombre: "Electrónica",      icono: "laptopcomputer",color: .purple, fuente: .fakeStore(categoria: "electronics")),
        Category(id: "jewelery",         nombre: "Joyería",          icono: "sparkles",      color: .yellow, fuente: .fakeStore(categoria: "jewelery")),
        Category(id: "groceries",        nombre: "Supermercado",     icono: "cart.fill",     color: .green,  fuente: .dummyJSON(categoria: "groceries")),
        Category(id: "skincare",         nombre: "Cuidado Personal", icono: "drop.fill",     color: .cyan,   fuente: .dummyJSON(categoria: "skin-care")),
        Category(id: "beauty",           nombre: "Belleza",          icono: "wand.and.stars",color: .red,    fuente: .dummyJSON(categoria: "beauty")),
        Category(id: "sports",           nombre: "Deportes",         icono: "figure.run",    color: .orange, fuente: .dummyJSON(categoria: "sports-accessories")),
    ]
}
