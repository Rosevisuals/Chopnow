import SwiftUI

struct ProfileView: View {
    enum Tab: String, CaseIterable { case home, search, order, profile
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

    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab: Tab = .profile

    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Title bar with centered title and back button
                ZStack {
                    Text("Profile")
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
                    VStack(spacing: 24) {
                        // Header avatar + name + email
                        VStack(spacing: 8) {
                            ZStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.15))
                                Image("girl")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 108, height: 108)
                                    .clipShape(Circle())
                            }
                            .frame(width: 108, height: 108)

                            Text("Julian")
                                .font(.title2.weight(.semibold))
                                .foregroundStyle(.primary)
                            Text("julian234@gmail.com")
                                .font(.subheadline)
                                .tint(Color.black)
                        }
                        .padding(.top, 8)

                        // Action list
                        VStack(spacing: 12) {
                            ProfileRow(icon: "person", title: "Personal Information")
                            ProfileRow(icon: "bag", title: "Order History")
                           
//                                .padding(.horizontal, 14)
                            ProfileRow(icon: "questionmark.circle", title: "Help & Support")
                            ProfileRow(icon: "trash", title: "Delete Account")
                           
//                                .padding(.horizontal, 14)
                            ProfileRow(icon: "gearshape", title: "Settings")
                            ProfileRow(icon: "arrow.backward.square", title: "Logout")
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 24)
                    }
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

private struct ProfileRow: View {
    var icon: String
    var title: String

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.gray.opacity(0.12))
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.primary)
            }
            .frame(width: 36, height: 36)

            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.gray.opacity(0.12), lineWidth: 1)
                )
        )
    }
}

private struct BottomTabBarMinimal: View {
    @Binding var selectedTab: ProfileView.Tab

    var body: some View {
        HStack {
            ForEach(ProfileView.Tab.allCases, id: \.self) { tab in
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
    NavigationStack { ProfileView() }
}
