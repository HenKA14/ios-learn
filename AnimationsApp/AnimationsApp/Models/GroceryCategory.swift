import Foundation

struct GroceryCategory: Identifiable {
    let id: UUID
    let name: String
    let emoji: String

    init(name: String, emoji: String) {
        self.id = UUID()
        self.name = name
        self.emoji = emoji
    }
}

extension GroceryCategory {
    static let all: [GroceryCategory] = [
        GroceryCategory(name: "Todo",      emoji: "🛒"),
        GroceryCategory(name: "Frutas",    emoji: "🍎"),
        GroceryCategory(name: "Verduras",  emoji: "🥦"),
        GroceryCategory(name: "Lácteos",   emoji: "🥛"),
        GroceryCategory(name: "Panadería", emoji: "🍞"),
    ]
}
