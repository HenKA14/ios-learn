import Foundation

struct Product: Identifiable, Hashable {
    let id: UUID
    let name: String
    let emoji: String
    let price: Double
    let weight: String
    let category: String
    let description: String
    let rating: Double
    let reviewCount: Int

    init(
        name: String, emoji: String, price: Double, weight: String,
        category: String, description: String = "",
        rating: Double = 4.5, reviewCount: Int = 128
    ) {
        self.id = UUID()
        self.name = name
        self.emoji = emoji
        self.price = price
        self.weight = weight
        self.category = category
        self.description = description
        self.rating = rating
        self.reviewCount = reviewCount
    }
}

extension Product {
    static let sampleData: [Product] = [
        Product(name: "Aguacate",  emoji: "🥑", price: 1.49, weight: "150g", category: "Frutas",
                description: "Aguacate fresco y cremoso, perfecto para guacamole o tostadas.", rating: 4.8, reviewCount: 312),
        Product(name: "Manzana",   emoji: "🍎", price: 0.99, weight: "200g", category: "Frutas",
                description: "Manzana roja dulce y crujiente, cosecha de temporada.", rating: 4.5, reviewCount: 198),
        Product(name: "Limón",     emoji: "🍋", price: 0.59, weight: "80g",  category: "Frutas",
                description: "Limón jugoso y aromático, ideal para aderezos y bebidas.", rating: 4.3, reviewCount: 89),
        Product(name: "Uvas",      emoji: "🍇", price: 2.49, weight: "400g", category: "Frutas",
                description: "Uvas moradas sin semilla, dulces y carnosas.", rating: 4.7, reviewCount: 245),
        Product(name: "Frutilla",  emoji: "🍓", price: 2.99, weight: "300g", category: "Frutas",
                description: "Frutillas frescas y maduras, recogidas esta mañana.", rating: 4.9, reviewCount: 401),
        Product(name: "Naranja",   emoji: "🍊", price: 0.99, weight: "180g", category: "Frutas",
                description: "Naranja jugosa llena de vitamina C, perfecta para jugo.", rating: 4.6, reviewCount: 167),
        Product(name: "Brócoli",   emoji: "🥦", price: 1.29, weight: "300g", category: "Verduras",
                description: "Brócoli verde fresco, rico en fibra y antioxidantes.", rating: 4.4, reviewCount: 143),
        Product(name: "Zanahoria", emoji: "🥕", price: 0.79, weight: "150g", category: "Verduras",
                description: "Zanahoria orgánica, dulce y crujiente. Excelente para ensaladas.", rating: 4.5, reviewCount: 112),
        Product(name: "Tomate",    emoji: "🍅", price: 0.89, weight: "200g", category: "Verduras",
                description: "Tomate perita maduro, sabor intenso para salsas y ensaladas.", rating: 4.3, reviewCount: 205),
        Product(name: "Maíz",      emoji: "🌽", price: 1.19, weight: "250g", category: "Verduras",
                description: "Choclo tierno y dulce, ideal para asados y guisos.", rating: 4.6, reviewCount: 78),
    ]
}
