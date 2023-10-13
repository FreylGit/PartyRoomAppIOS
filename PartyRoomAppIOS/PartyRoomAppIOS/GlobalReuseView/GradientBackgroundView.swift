import SwiftUI

struct GradientBackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.25, green: 0.17, blue: 0.01).opacity(0.8),
                Color(red: 0.04, green: 0.08, blue: 0.22).opacity(0.9)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
