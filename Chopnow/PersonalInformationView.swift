import SwiftUI

struct PersonalInformationView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = "Julian"
    @State private var email: String = "julian234@gmail.com"
    @State private var phone: String = "+256 743121047"
    @State private var address: String = "Coronation road"

    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Title bar with centered title and back button
                ZStack {
                    Text("Personal information")
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
                    VStack(spacing: 24) {
                        // Header avatar + name + email
                        VStack(spacing: 18) {
                            ZStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.15))
                                Image("girl")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 108, height: 108)
                                    .clipShape(Circle())
                            }
                            .frame(width: 108, height: 108)

                            Text("Julian")
                                .font(.title2.weight(.semibold))
                                .foregroundStyle(.primary)
                            Text("julian234@gmail.com")
                                .font(.subheadline)
                                .tint(Color.black)
                        }
                        .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 16) {
                            // Name
                            LabeledField(label: "Name") {
                                
                                TextField("Name", text: $name)
                                    .textContentType(.name)
                                    .autocapitalization(.words)
                                    .font(.subheadline)
                                    .tint(Color.gray)
                                    .opacity(0.5)
                            }

                            // Email + Phone in two columns
                            HStack(spacing: 12) {
                                LabeledField(label: "Email") {
                                    TextField("Email", text: $email)
                                        .textContentType(.emailAddress)
                                        .keyboardType(.emailAddress)
                                        .autocapitalization(.none)
                                        .font(.subheadline)
                                        .tint(Color.gray)
                                        .opacity(0.5)
                                }
                                LabeledField(label: "Phone number") {
                                    TextField("Phone number", text: $phone)
                                        .textContentType(.telephoneNumber)
                                        .keyboardType(.phonePad)
                                        .font(.subheadline)
                                        .tint(Color.gray)
                                        .opacity(0.5)
                                }
                            }

                            // Delivery address (multiline)
                            LabeledField(label: "Delivery address") {
                                TextEditor(text: $address)
                                    .frame(minHeight: 80, maxHeight: 120)
                                    .padding(8)
                                    .font(.subheadline)
                                    .tint(Color.gray)
                                    .opacity(0.5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                                            .fill(Color(.systemBackground))
//                                            .overlay(
//                                                RoundedRectangle(cornerRadius: 12, style: .continuous)
//                                                    .stroke(Color.gray.opacity(0.15), lineWidth: 1)
//                                            )
                                    )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 80) // leave space for bottom button
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Button(action: { /* save changes action */ }) {
                    Text("Save changes")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            Capsule(style: .continuous)
                                .fill(ChopnowStyle.yellowGradient)
                        )
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
//                .background(Color(.systemBackground).opacity(0.9))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

private struct LabeledField<Content: View>: View {
    var label: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.secondary)
            HStack(spacing: 0) {
                content()
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
            }
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                    )
            )
        }
    }
}

#Preview {
    NavigationStack { PersonalInformationView() }
}
