import SwiftUI

struct OnboardingView: View {
    
    var body: some View {
        ZStack {
            
            // Background Gradient
            LinearGradient(
                colors: [Color.white, Color.yellow],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Content
            HStack(spacing: 12) {
                Image("logo_chop_now")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                Text("Chop now")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
