import SwiftUI

struct CartView: View {
    struct Item: Identifiable, Equatable {
        let id: String
        let name: String
        var quantity: Int
        let price: Decimal
    }

    struct DataModel: Equatable {
        var items: [Item]
        var total: Decimal {
            items.reduce(0) { $0 + ($1.price * Decimal($1.quantity)) }
        }
    }

    var data: DataModel
    var onRemove: ((String) -> Void)?
    var onCheckout: (() -> Void)?

    var body: some View {
        NavigationStack {
            List {
                ForEach(data.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            Text("Qty: \(item.quantity)").font(.subheadline).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text("$\(NSDecimalNumber(decimal: item.price))")
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { idx in onRemove?(data.items[idx].id) }
                }

                HStack {
                    Text("Total").bold()
                    Spacer()
                    Text("$\(NSDecimalNumber(decimal: data.total))").bold()
                }
            }
            .navigationTitle("Cart")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Checkout") { onCheckout?() }
                        .disabled(data.items.isEmpty)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Settings") {
                        // No action for now
                    }
                }
            }
        }
    }
}

#Preview {
    CartView(
        data: .init(items: [
            .init(id: "m1", name: "Pad Thai", quantity: 1, price: 12.0),
            .init(id: "m2", name: "Pizza", quantity: 2, price: 10.0)
        ]),
        onRemove: { _ in },
        onCheckout: {}
    )
}
