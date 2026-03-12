import SwiftUI
import UIKit

struct RestaurantDetailView: View {
    struct DataModel: Equatable {
        let id: String
        let name: String
        let description: String
        let isOpen: Bool
    }

    var data: DataModel
    var onAddToCart: ((String) -> Void)?
    var onOrderNow: ((String) -> Void)?
    
    @Environment(\.dismiss) private var dismiss

    @State private var dragOffsetX: CGFloat = 0
    @State private var didTriggerHaptic = false
    private let addThreshold: CGFloat = -80
    private let orderThreshold: CGFloat = -160
    private let impactLight = UIImpactFeedbackGenerator(style: .light)
    private let impactMedium = UIImpactFeedbackGenerator(style: .medium)

    @State private var selectedFlavor: String? = nil
    @State private var selectedDrink: String? = nil

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack(alignment: .top) {
                    ChopnowStyle.yellowGradient
                        .frame(height: 260)
                        .ignoresSafeArea(edges: .top)
                        .overlay(alignment: .topLeading) {
                            Button(action: { dismiss() }) {
                                Image(systemName: "chevron.left")
                                    .font(.title2.weight(.semibold))
                                    .foregroundStyle(.white)
                                    .padding(12)
                                    .background(.black.opacity(0.25), in: Circle())
                            }
                            .padding(.top, 48)
                            .padding(.leading, 16)
                            .contentShape(Rectangle())
                            .accessibilityLabel("Back")
                        }
                        .overlay(alignment: .top) {
                            Image("burger")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 240)
                                .padding(.top, 64)
                                .foregroundStyle(.white)
                                .opacity(0.95)
                        }
//                        .clipped()
                }
                
                VStack(alignment: .leading, spacing:    11) {
                    VStack ( alignment: .leading, spacing: 0) {
                        Text("The Burger Palace")
                            .font(.largeTitle)
                            .tint(.black)
                            .fontWeight(.bold)
                        Spacer()
                            
                        Text("A classic favorite! Indulge in crispy, thin crust topped with rich tomato sauce, layers of cheese" )
                            .font(.subheadline)
                            .opacity(0.5)
                        
                    }
                    
                    Text("Choose your preferred burger flavor")
                        .font(.headline)
                    HStack() {
                        Text("Choose 1 item")
                            .font(.subheadline)
                            .opacity(0.5)
                        ZStack() {
                            
                            RoundedRectangle(cornerRadius: 10, style:.continuous)
                                .fill(ChopnowStyle.yellowGradient)
                                .frame(width:91, height:32)
                            HStack() {
                                Text("Required")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            
                        }
                    }
                   
                    // Radio-like choices (UI only)
                    VStack(spacing: 0) {
                        ForEach(["Original", "Spicy", "Cheese"], id: \.self) { option in
                            HStack {
                                Text(option)
                                Spacer()
                                Image(systemName: selectedFlavor == option ? "largecircle.fill.circle" : "circle")
                                    .onTapGesture {
                                        selectedFlavor = option
                                    }
                            }
                            .padding()
//                            .background(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(Color.gray.opacity(0.2)))
                        }
                    }

                    Text("Please choose a drink")
                        .font(.headline)
                    HStack() {
                        Text("Choose 1 item")
                            .font(.subheadline)
                            .opacity(0.5)
                        ZStack() {
                            
                            RoundedRectangle(cornerRadius: 10, style:.continuous)
                                .fill(ChopnowStyle.yellowGradient)
                                .frame(width:91, height:32)
                            HStack() {
                                Text("Required")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            
                        }
                    }
                    VStack(spacing: -8) {
                        ForEach(["Coca-cola", "Sprite", "Fanta"], id: \.self) { option in
                            HStack {
                                Text(option)
                                Spacer()
                                Image(systemName: selectedDrink == option ? "largecircle.fill.circle" : "circle")
                                    .onTapGesture {
                                        selectedDrink = option
                                    }
                            }
                            .padding()
                            
                        }
                    }

                    let canProceed = selectedFlavor != nil && selectedDrink != nil

                    ZStack(alignment: .leading) {
                        // Track background
                        RoundedRectangle(cornerRadius: 40, style: .continuous)
                            .fill(ChopnowStyle.yellowGradient)
                            .opacity(canProceed ? 1.0 : 0.5)
                            .frame(height: 62)
                            .overlay(alignment: .trailing) {
                                // Hint labels for drag actions
                                HStack(spacing: 12) {
                                    if dragOffsetX <= addThreshold { Text("Add to cart").font(.caption).bold().foregroundStyle(.black) }
                                    if dragOffsetX <= orderThreshold { Text("Order now").font(.caption).bold().foregroundStyle(.black) }
                                }
                                .padding(.trailing, 16)
                                .animation(.easeInOut(duration: 0.15), value: dragOffsetX)
                            }

                        HStack {
                            Spacer()
                            Text("Add to cart")
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

                        // Draggable knob
                        Circle()
                            .fill(Color.black.opacity(canProceed ? 1.0 : 0.5))
                            .frame(width: 56, height: 56)
                            .overlay(
                                Image(systemName: "cart.fill")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 20, weight: .semibold))
                            )
                            .padding(4)
                            .offset(x: max(-200, min(0, dragOffsetX)))
                            .gesture(
                                DragGesture(minimumDistance: 5, coordinateSpace: .local)
                                    .onChanged { value in
                                        guard canProceed else { return }
                                        // Only allow left drag
                                        dragOffsetX = min(0, value.translation.width)
                                        // Light haptic when crossing add threshold; medium when crossing order threshold
                                        if dragOffsetX <= orderThreshold {
                                            if !didTriggerHaptic { impactMedium.impactOccurred(); didTriggerHaptic = true }
                                        } else if dragOffsetX <= addThreshold {
                                            if !didTriggerHaptic { impactLight.impactOccurred(); didTriggerHaptic = true }
                                        } else {
                                            didTriggerHaptic = false
                                        }
                                    }
                                    .onEnded { _ in
                                        defer { dragOffsetX = 0; didTriggerHaptic = false }
                                        guard canProceed, let flavor = selectedFlavor, let drink = selectedDrink else { return }
                                        let composedId = "\(data.id)|\(flavor)|\(drink)"
                                        if dragOffsetX <= orderThreshold {
                                            onOrderNow?(composedId)
                                        } else if dragOffsetX <= addThreshold {
                                            onAddToCart?(composedId)
                                        }
                                    }
                            )
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        guard canProceed, let flavor = selectedFlavor, let drink = selectedDrink else { return }
                        let composedId = "\(data.id)|\(flavor)|\(drink)"
                        onAddToCart?(composedId)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .fill(Color(.systemBackground))
                        .mask(
                            VStack(spacing: 0) {
                                RoundedRectangle(cornerRadius: 24, style: .continuous)
                                    .frame(height: 4)
                                Rectangle()
                            }
                        )
                        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: -2)
                )
                .offset(y: -24)
                .padding(.top, -24)
            }
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ChopnowStyle.yellowGradient)
        .ignoresSafeArea()
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        RestaurantDetailView(
            data: .init(
                id: "1",
                name: "Mama's Thai",
                description: "Authentic Thai food with fast delivery.",
                isOpen: true
            ),
            onAddToCart: { composed in
            },
            onOrderNow: { composed in
                print("Order now:", composed)
            }
        )
    }
}
