import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView(
                data: HomeView.DataModel(
                    isLoading: false,
                    errorMessage: nil,
                    recommendations: [
                        .init(id: "1", name: "Mama's Thai", tagLine: "Spicy & fast"),
                        .init(id: "2", name: "Bella Italia", tagLine: "Comfort pasta")
                    ]
                ),
                onRefresh: {}
            )
            .tabItem { Label("Home", systemImage: "house") }

            CartView(
                data: CartView.DataModel(
                    items: [
                        .init(id: "m1", name: "Pad Thai", quantity: 1, price: 12.0),
                        .init(id: "m2", name: "Margherita Pizza", quantity: 2, price: 10.0)
                    ]
                ),
                onRemove: { _ in },
                onCheckout: {}
            )
            .tabItem { Label("Cart", systemImage: "cart") }

            SettingsView(
                data: SettingsView.DataModel(
                    mood: "Happy",
                    budget: "20",
                    dietaryRestrictions: ["Vegan"],
                    cuisinePreferences: ["Thai", "Italian"]
                ),
                onSave: { _ in }
            )
            .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

#Preview {
    RootView()
}
