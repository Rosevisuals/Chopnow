import SwiftUI

struct ForgotPasswordCodeView: View {
    @State private var code: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedIndex: Int?

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
                    Text("Forgot your password")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.top, 24)

                    Text("Enter the verification code sent to your email")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)

                    // Code boxes
                    HStack(spacing: 12) {
                        ForEach(0..<5, id: \.self) { idx in
                            TextField("", text: Binding(
                                get: { code[idx] },
                                set: { newValue in
                                    let filtered = newValue.filter { $0.isNumber }
                                    if filtered.count > 1 {
                                        code[idx] = String(filtered.suffix(1))
                                    } else {
                                        code[idx] = filtered
                                    }
                                    if !code[idx].isEmpty && idx < 4 {
                                        focusedIndex = idx + 1
                                    }
                                }
                            ))
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .focused($focusedIndex, equals: idx)
                            .frame(width: 48, height: 48)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.top, 8)

                    // Resend
                    HStack(spacing: 4) {
                        Text("Didn't receive code?")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Button(action: {
                            // TODO: Handle resend
                        }) {
                            Text("Resend")
                                .font(.subheadline.bold())
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.top, 8)

                    // Login button
                    Button(action: {
                        // TODO: Handle login with code
                    }) {
                        Text("Login")
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
                    .padding(.top, 8)

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
    ForgotPasswordCodeView()
}
