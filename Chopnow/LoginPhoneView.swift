import SwiftUI

struct LoginPhoneView: View {
    @State private var countryCode: String = "+256"
    @State private var phoneNumber: String = ""

    var body: some View {
        ZStack(alignment: .top) {
            // Background gradient header
            LinearGradient(
                colors: [Color.yellow.opacity(0.35), Color.white],
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Top logo and title
                HStack(spacing: 12) {
                    Image("logo_chop_now")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)

                    Text("Chop now")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                }
                .padding(.vertical, 30)
                .padding(.bottom, 26)

                // Card-like white section with rounded top
                VStack(spacing: 20) {
                    Text("Welcome")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.top, 24)

                    Text("Let's start with your phone number")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)

                    // Phone inputs
                    HStack(spacing: 12) {
                        TextField("+256", text: $countryCode)
                            .keyboardType(.phonePad)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 12)
                            .frame(width: 90)
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
                            )

                        TextField("Phone number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal, 24)

                    // Continue button
                    Button(action: {
                        // TODO: Handle continue with phone number
                    }) {
                        Text("Continue")
                            .font(.headline.weight(.semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                Capsule()
                                    .fill(ChopnowStyle.yellowGradient)
                            )
                    }
                    .padding(.horizontal, 24)

                    // Divider 'or with'
                    HStack(spacing: 12) {
                        Rectangle().fill(Color.black.opacity(0.1)).frame(height: 1)
                        Text("or with")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Rectangle().fill(Color.black.opacity(0.1)).frame(height: 1)
                    }
                    .padding(.horizontal, 24)

                    // Social buttons
                    VStack(spacing: 14) {
                        SocialButton(title: "Google", systemImage: nil, imageName: "Google", tint: .black, background: .white, border: Color.black.opacity(0.1)) {
                            // TODO: Handle Google sign in
                        }

                        SocialButton(title: "Apple", systemImage: "apple.logo", imageName: nil, tint: .black, background: .white, border: Color.black.opacity(0.1)) {
                            // TODO: Handle Apple sign in
                        }

                        SocialButton(title: "Facebook", systemImage: nil, imageName: "Facebook", tint: .black, background: .white, border: Color.black.opacity(0.1)) {
                            // TODO: Handle Facebook sign in
                        }

                        SocialButton(title: "Email", systemImage: "envelope", imageName: nil, tint: .black, background: .white, border: Color.black.opacity(0.1)) {
                            // TODO: Handle Email sign in
                        }
                    }
                    .padding(.horizontal, 24)

                    Spacer(minLength: 0)

                    // Terms and Conditions footer
                    VStack(spacing: 4) {
                        Text("By using this application, you agree to the")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        HStack(spacing: 4) {
                            Button(action: {}) {
                                Text("Terms")
                                    .font(.footnote.bold())
                                    .foregroundColor(.black)
                            }
                            Text("and")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            Button(action: {}) {
                                Text("Conditions")
                                    .font(.footnote.bold())
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.bottom, 24)
                }
                .frame(maxWidth: .infinity)
                .background(
                    ZStack(alignment: .top) {
                        Color.white
                        RoundedRectangle(cornerRadius: 36, style: .continuous)
                            .fill(Color.white)
                            .frame(height: 36)
                            .offset(y: -18)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: -2)
            }
        }
    }
}

// Reuse social button from LoginView by copying its definition here for standalone use
fileprivate struct SocialButton: View {
    let title: String
    let systemImage: String?
    let imageName: String?
    let tint: Color
    let background: Color
    let border: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                // Centered icon + title
                HStack(spacing: 12) {
                    if let imageName = imageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    } else if let systemImage = systemImage {
                        Image(systemName: systemImage)
                            .font(.system(size: 18, weight: .semibold))
                    }

                    Text(title)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            }
            .foregroundColor(tint)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(background)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(border, lineWidth: 1)
            )
        }
    }
}

#Preview {
    LoginPhoneView()
}
