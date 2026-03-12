import SwiftUI

private extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        self = Color(red: r, green: g, blue: b, opacity: alpha)
    }
}

struct MyCartView: View {
    struct CartItem: Identifiable, Equatable {
        let id: UUID = UUID()
        var title: String
        var etaText: String
        var distanceText: String
        var price: String
        var rating: Double
        var imageName: String
        var quantity: Int
    }

    @Environment(\.dismiss) private var dismiss
    @State private var items: [CartItem] = [
        .init(title: "The Pasta Corner", etaText: "15-20 min", distanceText: "0.8 km", price: "UGX 15,000", rating: 4.9, imageName: "burger", quantity: 1),
        .init(title: "The Pasta Corner", etaText: "15-20 min", distanceText: "0.8 km", price: "UGX 15,000", rating: 4.9, imageName: "burger", quantity: 1)
    ]

    var body: some View {
        ZStack {
            Color(UIColor.systemBackground).ignoresSafeArea()

            VStack(spacing: 0) {
                // Title bar
                ZStack {
                    Text("My cart list")
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
                        ForEach(items.indices, id: \.self) { index in
                            CartItemCard(
                                item: $items[index],
                                onDecrement: { decrementQuantity(at: index) },
                                onIncrement: { incrementQuantity(at: index) }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            CheckoutBar()
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                .background(Color(UIColor.systemBackground))
        }
        .navigationBarBackButtonHidden(true)
    }

    private func decrementQuantity(at index: Int) { items[index].quantity = max(0, items[index].quantity - 1) }
    private func incrementQuantity(at index: Int) { items[index].quantity += 1 }
}

private struct CartItemCard: View {
    @Binding var item: MyCartView.CartItem
    var onDecrement: () -> Void
    var onIncrement: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Thumbnail
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
                Image(item.imageName)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .frame(width: 100, height: 100)

            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.default)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 5)
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
                .padding(.bottom, 20)

                HStack(alignment: .center) {
                    Text(item.price)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Button(action: onDecrement) {
                            Image(systemName: "minus")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(.black)
                                .frame(width: 28, height: 28)
                                .background(Color.gray.opacity(0.15), in: Circle())
                        }
                        Text("\(item.quantity, format: .number)")
                            .font(.subheadline.weight(.semibold))
                            .frame(minWidth: 18)
                        Button(action: onIncrement) {
                            Image(systemName: "plus")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(.black)
                                .frame(width: 28, height: 28)
                                .background(
                                    ChopnowStyle.yellowGradient,
                                    in: Circle()
                                )
                        }
                    }
                }
            }
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

private struct CheckoutBar: View {
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .fill(Color.yellow)
                .frame(height: 62)

            HStack {
                Circle()
                    .fill(Color.black)
                    .frame(width: 56, height: 56)
                    .overlay(
                        Image(systemName: "cart.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .semibold))
                    )
                    .padding(-12)

                Spacer()
                Text("Go to checkout")
                    .tint(.black)
                    .font(.headline)
                Spacer()

                HStack(spacing: 6) {
                    Image(systemName: "chevron.right")
                    Image(systemName: "chevron.right")
                }
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.black)
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    NavigationStack { MyCartView() }
}
