import SwiftUI

struct SettingsView: View {
    struct DataModel: Equatable {
        var mood: String
        var budget: String
        var dietaryRestrictions: [String]
        var cuisinePreferences: [String]
    }

    @State var data: DataModel
    var onSave: ((DataModel) -> Void)?

    var body: some View {
        Form {
            Section {
                Button("Go to Home (example)") { /* parent TabView handles actual switching */ }
            }
            Section("Mood") {
                TextField("Mood", text: $data.mood)
            }
            Section("Budget") {
                TextField("Max per meal", text: $data.budget)
                    .keyboardType(.decimalPad)
            }
            Section("Dietary Restrictions") {
                Text(data.dietaryRestrictions.joined(separator: ", "))
                    .foregroundStyle(.secondary)
            }
            Section("Cuisine Preferences") {
                Text(data.cuisinePreferences.joined(separator: ", "))
                    .foregroundStyle(.secondary)
            }
            Section {
                Button("Save") { onSave?(data) }
                    .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView(
        data: .init(
            mood: "Happy",
            budget: "20",
            dietaryRestrictions: ["Vegan"],
            cuisinePreferences: ["Thai", "Italian"]
        ),
        onSave: { _ in }
    )
}
