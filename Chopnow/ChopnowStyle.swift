import SwiftUI

enum ChopnowStyle {
    static var yellowGradient: LinearGradient {
        LinearGradient(
            colors: [Color(red: 1.0, green: 0.85, blue: 0.3), Color(red: 1.0, green: 0.67, blue: 0.0)],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    static var capsuleBackground: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(.ultraThinMaterial)
    }

    static func primaryCTA(_ title: String, systemImage: String? = nil) -> some View {
        Group {
            if let systemImage {
                Label(title, systemImage: systemImage)
            } else {
                Text(title)
            }
        }
        .font(.headline)
        .padding(.vertical, 14)
        .frame(width: 100, height: 100)
        .ignoresSafeArea()
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.orange)
        )
        .foregroundStyle(.white)
    }
}
