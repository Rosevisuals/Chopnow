//
//  NearbyRestaurantView.swift
//  Chopnow
//
//  Created by Rose Visuals on 10/03/2026.
//

import SwiftUI

struct NearbyRestaurantView: View {
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
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack( spacing: 0) {
                // Title
                ZStack {
                    // Centered title
                    Text("Nearby restaurants")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)

                    // Leading back button
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                            
                                .font(.title2.weight(.semibold))
                                .foregroundStyle(.black)
                                .padding(12)
                                .background(.gray.opacity(0.1), in: Circle())
                        }
                        .accessibilityLabel("Back")
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
                
               
                // Search field
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    TextField("Search", text: $searchText)
                        .textFieldStyle(.plain)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 21, style: .continuous)
                        .fill(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 21, style: .continuous)
                                .stroke(.black.opacity(0.1), lineWidth: 0.5)
                        )
                )
                .padding(.horizontal, 16)
                .padding(.top, 8)

                // Cards list
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        // Replace `Image("placeholder_food")` with your actual asset names
                        RestaurantCard(
                            image: Image("burger"),
                            title: "The Pasta Corner",
                            discountBig: "10%",
                            discountSmall: "OFF",
                            tags: "Pizza . Italian . Cheese",
                            etaText: "15-20 min",
                            rating: 4.9,
                            distanceText: "0.8 km",
                            isPopular: true
                        )
                        RestaurantCard(
                            image: Image("burger"),
                            title: "Sizzle Burger",
                            discountBig: "15%",
                            discountSmall: "OFF",
                            tags: "Burger . American . Fast Food",
                            etaText: "20-25 min",
                            rating: 4.6,
                            distanceText: "1.1 km",
                            isPopular: false
                        )
                        RestaurantCard(
                            image: Image("burger"),
                            title: "Pizza Palace",
                            discountBig: "5%",
                            discountSmall: "OFF",
                            tags: "Pizza . Italian . Family",
                            etaText: "10-15 min",
                            rating: 4.9,
                            distanceText: "0.8 km",
                            isPopular: true
                        )
                        RestaurantCard(
                            image: Image("burger"),
                            title: "Cafe Aroma",
                            discountBig: "20%",
                            discountSmall: "OFF",
                            tags: "Coffee . Drinks . Bakery",
                            etaText: "10-15 min",
                            rating: 4.7,
                            distanceText: "0.8 km",
                            isPopular: false
                        )
                        RestaurantCard(
                            image: Image("burger"),
                            title: "Sweet Tooth",
                            discountBig: "12%",
                            discountSmall: "OFF",
                            tags: "Desserts . Cakes . Pastries",
                            etaText: "15-20 min",
                            rating: 4.5,
                            distanceText: "0.8 km",
                            isPopular: true
                        )
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 24) // changed from 140 to 24
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Divider().opacity(0.2)
                BottomTabBarMinimal(selectedTab: $selectedTab)
                    .padding(.top, 0)
                    .padding(.horizontal, 8)
            }
            .background(Color.white)
        }
//        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    private var safeAreaBottomInset: CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first { $0.activationState == .foregroundActive } as? UIWindowScene
        let keyWindow = windowScene?.windows.first { $0.isKeyWindow }
        return keyWindow?.safeAreaInsets.bottom ?? 0
    }
}

// MARK: - Card

private struct RestaurantCard: View {
    let image: Image
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
                // Thumbnail
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .opacity(1.0)
                    Image(systemName: "photo")
                        .font(.system(size: 34))
                        .foregroundColor(.secondary)
                        .opacity(0.0)
                }
                .frame(width: 84, height: 84)

                // Right content
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    // Discount emphasis
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

// MARK: - Minimal Tab Bar

private struct BottomTabBarMinimal: View {
    @Binding var selectedTab: NearbyRestaurantView.Tab

    var body: some View {
        HStack {
            ForEach(NearbyRestaurantView.Tab.allCases, id: \.self) { tab in
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
    NearbyRestaurantView()
}
