

import SwiftUI

struct TestView: View {
    @State private var isShowingToast = false
    @State private var toastMessage = ""
    
    func showToast(message: String) {
        toastMessage = message
        isShowingToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                isShowingToast = false
            }
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    showToast(message: "Ваше сообщение здесь")
                }) {
                    Text("Показать сообщение")
                }
                Spacer()
                Text("test")
                Text("test")
                Text("test")
            }
            
            if isShowingToast {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.black)
                                .opacity(0.7)
                                .cornerRadius(10)
                                .frame(width: geometry.size.width, height: 60)
                            
                            Text(toastMessage)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
        }
    }
}

#Preview {
    TestView()
}
