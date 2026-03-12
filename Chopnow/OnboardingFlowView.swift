import SwiftUI

struct OnboardingFlowView: View {
    @State private var step: Int = 1
    @State private var isActive: Bool = false
    @State private var timerTask: DispatchWorkItem?

    var body: some View {
        NavigationStack {
            Group {
                switch step {
                case 1:
                    OnboardingView()
                case 2:
                    OnboardingViewTwo()
                case 3:
                    OnboardingViewThree()
                case 4:
                    OnboardingViewFour()
                default:
                    OnboardingView()
                }
            }
            .navigationDestination(isPresented: $isActive) {
                LoginView()
            }
            .onAppear {
                startTimer()
            }
            .onChange(of: step) { _, _ in
                startTimer()
            }
            .onDisappear {
                timerTask?.cancel()
            }
        }
    }

    private func startTimer() {
        timerTask?.cancel()
        let task = DispatchWorkItem { advance() }
        timerTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: task)
    }

    private func advance() {
        if step < 4 {
            step += 1
        } else {
            isActive = true
        }
    }
}

#Preview {
    OnboardingFlowView()
}
