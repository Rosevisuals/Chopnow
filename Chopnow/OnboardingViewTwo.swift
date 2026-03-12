import SwiftUI

struct OnboardingViewTwo: View {
    
    var body: some View {
        ZStack {
            
            // Background Gradient
            LinearGradient(
                colors: [Color.white, Color.yellow.opacity(0.2)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                Spacer()
                
                // Illustration
                Image("chef")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                    .padding(.top, 20)
                
                Spacer()
                
                VStack(spacing: 10) {
                    
                    // Headline
                    (
                        Text("Exceptional ")
                            .fontWeight(.semibold)
                        +
                        Text("Food")
                            .fontWeight(.bold)
                        +
                        Text(", delivered effortlessly")
                            .fontWeight(.semibold)
                    )
                    .font(.system(size: 28, design: .rounded))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    
                    Text("Order from your favorite place anytime, anywhere")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                
                // Page Indicators
                HStack(spacing: 8) {
                    Capsule()
                        .fill(Color.yellow)
                        .frame(width: 24, height: 6)
                    
                    Circle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 6, height: 6)
                    
                    Circle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 6, height: 6)
                }
                
                // Next Button
                Button {
                    // next action
                } label: {
                    Text("Next")
                        .font(.headline.weight(.semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            Capsule()
                                .fill(Color.yellow)
                        )
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
                
            }
        }
    }
}

#Preview {
    OnboardingViewTwo()
}
