import SwiftUI

private extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        self = Color(red: r, green: g, blue: b, opacity: alpha)
    }
}

struct OrderHistoryView: View {
    enum Tab: String, CaseIterable {
        case home, search, order, profile
        var iconName: String {
            switch self {
            case .home: return "house.fill"
            case .search: return "magnifyingglass"
            case .order: return "bag.fill"
            case .profile: return "person.crop.circle"
            }
        }
        var label: String {
            switch self {
            case .home: return "Home"
            case .search: return "Search"
            case .order: return "Order"
            case .profile: return "Profile"
            }
        }
    }

    struct OrderItem: Identifiable, Equatable {
        let id = UUID()
        var title: String
        var etaText: String
        var rating: Double
        var price: String
        var imageName: String
        var distanceText: String
    }

    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab: Tab = .order

    @State private var items: [OrderItem] = [
        .init(title: "The Pasta Corner", etaText: "15-20 min", rating: 4.9, price: "UGX 15,000", imageName: "burger", distanceText: "1.2 km"),
        .init(title: "The Pasta Corner", etaText: "15-20 min", rating: 4.9, price: "UGX 15,000", imageName: "burger", distanceText: "2.4 km"),
        .init(title: "The Pasta Corner", etaText: "15-20 min", rating: 4.9, price: "UGX 15,000", imageName: "burger", distanceText: "3.1 km")
    ]

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack(spacing: 0) {
                // Title bar with centered title
                ZStack {
                    Text("Order history")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)

                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.title2.weight(.semibold))
                                .foregroundStyle(.black)
                                .padding(12)
                                .background(Color.gray.opacity(0.1), in: Circle())
                        }
                        .accessibilityLabel("Back")
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(items) { item in
                            OrderCard(item: item, onReorder: {
                                // Re-order action: currently no-op
                            })
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Divider().opacity(0.2)
                BottomTabBarMinimal(selectedTab: $selectedTab)
                    .padding(.top, 0)
                    .padding(.horizontal, 8)
                    .background(Color.white)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

private struct OrderCard: View {
    var item: OrderHistoryView.OrderItem
    var onReorder: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
                Image(item.imageName)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .frame(width: 100, height: 100)

            VStack(alignment: .leading, spacing: 16) {
                Text(item.title)
                    .font(.default)
                    .foregroundStyle(.primary)
                    .lineLimit(1)

              

                HStack(spacing: 14) {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                        Text(item.etaText)
                            .font(.footnote)
                            .foregroundColor(.primary)
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.footnote)
                        Text(String(format: "%.1f", item.rating))
                            .font(.footnote)
                            .foregroundColor(.primary)
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                        Text(item.distanceText)
                            .font(.footnote)
                            .foregroundColor(.primary)
                    }
                }
                HStack(alignment: .center, spacing: 12) {
                    Text(item.price)
                        .font(.default)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.8)
                        .truncationMode(.tail)
                    Spacer(minLength: 4)
                    Button(action: onReorder) {
                        Text("Re-order")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                ChopnowStyle.yellowGradient
                            )
                            .cornerRadius(40)
                    }
                }
            }
            Spacer(minLength: 8)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.gray.opacity(0.12), lineWidth: 1)
                )
        )
    }
}

private struct BottomTabBarMinimal: View {
    @Binding var selectedTab: OrderHistoryView.Tab

    var body: some View {
        HStack {
            ForEach(OrderHistoryView.Tab.allCases, id: \.self) { tab in
                Spacer()
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.iconName)
                            .font(.system(size: 20))
                            .foregroundStyle(selectedTab == tab ? Color.black : Color.gray.opacity(0.5))
                            .frame(height: 22)
                        Text(tab.label)
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(selectedTab == tab ? Color.black : Color.gray.opacity(0.5))
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 2)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    NavigationStack { OrderHistoryView() }
}
