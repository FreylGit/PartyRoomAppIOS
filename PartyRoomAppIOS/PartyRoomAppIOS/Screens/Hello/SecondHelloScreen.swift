import SwiftUI

struct SecondHelloScreen: View {
    var body: some View
    {
        VStack {
            Spacer()
            Text("Привет")
                .font(.title)
                .padding(.bottom, 20)
            HStack {
                
                Text("Ваше многострочное описание здесь. Можете использовать столько текста, сколько вам нужно для описания этого экрана.")
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                Spacer()
                Image(ImageResource.image2)
                    .resizable()
                    .frame(width: 200,height: 250)
                    .background(Color.clear)
            }
            NavigationLink(destination: LoginScreen()){
                Text("Далее")
                    .padding()
            }
            .isDetailLink(false)
            .background(Color.primary)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .foregroundColor(.white)
        .background(GradientBackgroundView())
    }
    
    
}

#Preview {
    SecondHelloScreen()
}
