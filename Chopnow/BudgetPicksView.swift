import SwiftUI

struct BudgetPicksView: View {
    @State private var searchText: String = ""

    // Inject items and selection callback from parent (MainTabsView/AppRootView)
    var items: [RestaurantItem] = Array(repeating: RestaurantItem(title: "The Burger Palace", price: "UGX 15,000", items: "Burger · Fries · Chicken", eta: "15-20 min", imageName: "burger"), count: 6)
    var onSelectItem: ((RestaurantItem) -> Void)?

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Spacer()
                Text("Your budget picks")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                Spacer()
                Button(action: {}) {
                    Image(systemName: "ellipsis.circle")
                        .font(.title3)
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 8)

            // Search bar
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("Search", text: $searchText)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(.systemGray6))
            )
            .padding(.horizontal, 16)

            // List of budget cards
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(items, id: \.id) { item in
                        BudgetCardView(item: item) {
                            onSelectItem?(item)
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .background(Color.white)
    }
}

// Temporary model (can be moved to a shared Models file)
struct RestaurantItem: Hashable, Identifiable {
    let id: UUID = UUID()
    let title: String
    let price: String
    let items: String
    let eta: String
    let imageName: String
}

private struct BudgetCardView: View {
    let item: RestaurantItem
    var onTap: (() -> Void)?

    var body: some View {
        Button(action: { onTap?() }) {
            HStack(alignment: .top, spacing: 12) {
                // Food image
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.systemGray5))
                    .frame(width: 84, height: 84)
                    .overlay(
                        Image(item.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 84, height: 84)
                            .clipped()
                    )

                VStack(alignment: .leading, spacing: 6) {
                    Text(item.title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.primary)

                    Text(item.price)
                        .font(.headline.weight(.bold))
                        .foregroundColor(.primary)

                    Text(item.items)
                        .font(.footnote)
                        .foregroundColor(.secondary)

                    HStack {
                        Text("Order now")
                            .font(.footnote.weight(.semibold))
                            .foregroundColor(.black)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(
                                Capsule().fill(Color.yellow)
                            )

                        Spacer()

                        HStack(spacing: 6) {
                            Image(systemName: "clock")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            Text(item.eta)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(
                            Capsule().fill(Color(.systemGray6))
                        )
                    }
                    .padding(.top, 2)
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    BudgetPicksView()
}
