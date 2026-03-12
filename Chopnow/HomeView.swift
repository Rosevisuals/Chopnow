import SwiftUI

struct HomeView: View {
    struct RestaurantCard: Identifiable, Equatable {
        let id: String
        let name: String
        let tagLine: String
    }

    struct DataModel: Equatable {
        var isLoading: Bool
        var errorMessage: String?
        var recommendations: [RestaurantCard]
    }

    var data: DataModel
    var onRefresh: (() -> Void)?

    @State private var path: [String] = []

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

    @State private var selectedTab: Tab = .search
    @State private var searchText: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .top) {
                // Background gradient header
                LinearGradient(
                    colors: [Color(hex: 0xFFB300), Color(hex: 0xFF7A00)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 620)
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Header content: location pill
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.subheadline.weight(.semibold))
                            Text("Coronation Road")
                                .font(.subheadline.weight(.semibold))
                            Image(systemName: "chevron.down")
                                .font(.caption.weight(.heavy))
                        }
                        .foregroundStyle(.black)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(.white.opacity(0.9), in: Capsule())
                        .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
                        .padding(.top, 12)

                        // Quick filters grid (2 rows, 3 columns with center gap)
                        VStack(spacing: 22) {
                            HStack(spacing: 36) {
                                QuickFilter(iconName: "cake 1", title: "Mood")
                                QuickFilter(iconName: "taco 1", title: "Location")
                                QuickFilter(iconName: "macaroon_ 1", title: "Budget")
                            }
                            HStack(spacing: 36) {
                                QuickFilter(iconName: "macaroon_ 1", title: "Time")
                                QuickFilter(iconName: "burger 1", title: "Rating")
                                Spacer().frame(width: 72) // keep layout balanced
                            }
                        }
                        .padding(.top, 24)

                        // White sheet-like container
                        VStack(spacing: 16) {
                            // Section header
                            HStack {
                                Text("Nearby restaurants")
                                    .font(.title3.weight(.semibold))
                                    .foregroundStyle(.primary)
                                Spacer()
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(Color.gray)
                                        .opacity(0.1)
                                        .frame(width:90, height:30)
                                    .tint(Color.black)
                                    Button("View all") {
                                        // Navigate to full list if desired
                                    }
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.primary)
                                }
                                
                                
                            }
                            .padding(.horizontal, 6)
                            .padding(.top, 12)

                            // Cards
                            VStack(spacing: 12) {
                                HomeRestaurantRow(
                                    imageName: "burger",
                                    title: "The Pasta Corner",
                                    discountBig: "10%",
                                    discountSmall: "OFF",
                                    tags: "Pizza . Italian . Cheese",
                                    etaText: "15-20 min",
                                    rating: 4.9,
                                    distanceText: "0.8 km",
                                    isPopular: true
                                )
                                HomeRestaurantRow(
                                    imageName: "burger",
                                    title: "Sizzle Burger",
                                    discountBig: "15%",
                                    discountSmall: "OFF",
                                    tags: "Burger . American . Fast Food",
                                    etaText: "20-25 min",
                                    rating: 4.6,
                                    distanceText: "1.1 km",
                                    isPopular: false
                                )
                                HomeRestaurantRow(
                                    imageName: "burger",
                                    title: "Pizza Palace",
                                    discountBig: "5%",
                                    discountSmall: "OFF",
                                    tags: "Pizza . Italian . Family",
                                    etaText: "10-15 min",
                                    rating: 4.9,
                                    distanceText: "0.8 km",
                                    isPopular: true
                                )
                            }
                            .padding(.horizontal, 6)
                            .padding(.bottom, 16)
                        }
                       
                        .background(
                            RoundedRectangle(cornerRadius: 804, style: .continuous)
                                .fill(Color(.systemBackground))
                                .shadow(color: Color.black.opacity(0.06), radius: 10, y: -2)
                                .frame(width: 900, height:500)
                        )
                        .padding(.top, 28)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
            }
            .navigationBarHidden(true)
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 0) {
                    Divider().opacity(0.2)
                    BottomTabBarMinimal(selectedTab: $selectedTab)
                        .padding(.top, 0)
                        .padding(.horizontal, 8)
                }
                .background(Color.white)
            }
        }
    }
}

private struct QuickFilter: View {
    let iconName: String // placeholder asset name
    let title: String

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(colors: [Color.white.opacity(0.95), Color.white.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                    )
                    .frame(width: 64, height: 64)
                    .shadow(color: .black.opacity(0.08), radius: 10, y: 4)
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .opacity(1.0)
            }
            Text(title)
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.white)
        }
    }
}

private struct HomeRestaurantRow: View {
    let imageName: String
    let title: String
    let discountBig: String
    let discountSmall: String
    let tags: String
    let etaText: String
    let rating: Double
    let distanceText: String
    let isPopular: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(alignment: .center, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .opacity(1.0)
                }
                .frame(width: 84, height: 84)

                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text(discountBig)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primary)
                        Text(discountSmall)
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.secondary)
                    }
                    Text(tags)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    HStack(spacing: 14) {
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .foregroundColor(.secondary)
                                .font(.footnote)
                            Text(etaText)
                                .font(.footnote)
                                .foregroundColor(.primary)
                        }
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.footnote)
                            Text(String(format: "%.1f", rating))
                                .font(.footnote)
                                .foregroundColor(.primary)
                        }
                        HStack(spacing: 4) {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.secondary)
                                .font(.footnote)
                            Text(distanceText)
                                .font(.footnote)
                                .foregroundColor(.primary)
                        }
                    }
                }
                Spacer(minLength: 0)
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

            if isPopular {
                Text("Popular")
                    .font(.caption2.weight(.semibold))
                    .foregroundColor(.orange)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(
                        Capsule(style: .continuous)
                            .stroke(Color.orange, lineWidth: 1.2)
                    )
                    .padding(10)
            }
        }
    }
}

private extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        self = Color(red: r, green: g, blue: b, opacity: alpha)
    }
}
private struct BottomTabBarMinimal: View {
    @Binding var selectedTab: HomeView.Tab

    var body: some View {
        HStack {
            ForEach(HomeView.Tab.allCases, id: \.self) { tab in
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

#Preview("Home – Sample") {
    HomeView(
        data: .init(
            isLoading: false,
            errorMessage: nil,
            recommendations: [
                .init(id: "1", name: "Mama's Thai", tagLine: "Spicy & fast"),
                .init(id: "2", name: "Bella Italia", tagLine: "Comfort pasta")
            ]
        ),
        onRefresh: {}
    )
}

