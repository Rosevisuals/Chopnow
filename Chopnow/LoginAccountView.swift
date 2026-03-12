import SwiftUI

struct LoginAccountView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false

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
                    Text("Login to your account")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.top, 24)

                    Text("Enter your email and password")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)

                    // Email field
                    HStack(spacing: 12) {
                        Image(systemName: "envelope")
                            .foregroundColor(.secondary)
                        TextField("Email", text: $email)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                    }
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
                    .padding(.horizontal, 24)

                    // Password field
                    HStack(spacing: 12) {
                        Image(systemName: "lock")
                            .foregroundColor(.secondary)
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                        } else {
                            SecureField("Password", text: $password)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                        }
                        Button(action: { isPasswordVisible.toggle() }) {
                            Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.secondary)
                        }
                    }
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
                    .padding(.horizontal, 24)

                    // Forgot password link
                    HStack {
                        Spacer()
                        Button(action: {
                            // TODO: Navigate to forgot password
                        }) {
                            Text("Forgot password?")
                                .font(.footnote.bold())
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 24)

                    // Login button
                    Button(action: {
                        // TODO: Handle login
                    }) {
                        Text("Login")
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

#Preview {
    LoginAccountView()
}
