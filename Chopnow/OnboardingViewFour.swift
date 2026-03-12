import SwiftUI

struct OnboardingViewFour: View {
    
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
                Image("split_burger")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                    .padding(.top, 20)
                
                Spacer()
                
                VStack(spacing: 10) {
                    
                    // Headline
                    Text("Hot & Fast food at your\ndoor")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                    
                    // Subheadline
                    Text("Enjoy hot meals without the wait")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                
                // Page Indicator
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 6, height: 6)
                    
                    Circle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 6, height: 6)
                    
                    Capsule()
                        .fill(Color.yellow)
                        .frame(width: 24, height: 6)
                }
                
                // CTA Button
                Button {
                    // order action
                } label: {
                    
                    HStack(spacing: 12) {
                        
                        ZStack {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 56, height: 56)
                            
                            Image("delivery_bike")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        Spacer()
                        
                        Text("Order now")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .bold))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .bold))
                    }
                    .foregroundColor(.black)
//                    .padding(.vertical, 16)
                    .padding(.horizontal, 1)
                    .background(
                        RoundedRectangle(cornerRadius: 68)
                            .fill(Color.yellow)
                            .frame(width:370, height: 60)
                    )
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
                
            }
        }
    }
}

#Preview {
    OnboardingViewFour()
}
