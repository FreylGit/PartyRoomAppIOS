import SwiftUI

struct BottomSheet<Content: View>: View {
    @Binding var isSheetOpen: Bool
    var content: Content
    
    init(isSheetOpen: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isSheetOpen = isSheetOpen
        self.content = content()
    }

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(width: 40, height: 5)
                        .cornerRadius(5)
                        .foregroundColor(Color.gray)
                        .padding(.top, 10)

                    content
                }
                .background(Color.white)
                .cornerRadius(20)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height * 0.5)
                .offset(y: isSheetOpen ? 0 : UIScreen.main.bounds.height * 0.5)
                .animation(.spring())

                Spacer()
            }

            Button("Показать нижний лист") {
                isSheetOpen.toggle()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct TestView: View {
    @State private var isBottomSheetVisible = false

    var body: some View {
        BottomSheet(isSheetOpen: $isBottomSheetVisible) {
            VStack{
                Text("Содержимое нижнего листа")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .onTapGesture {
                        withAnimation {
                            isBottomSheetVisible.toggle()
                        }
                    }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
