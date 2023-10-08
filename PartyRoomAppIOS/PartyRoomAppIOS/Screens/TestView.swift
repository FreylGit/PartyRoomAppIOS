import SwiftUI

struct TestView: View {
    @State private var isExpanded = false

    var body: some View {
        ScrollView{
            navigationBar
            HStack(alignment:.center){
                AsyncImage(url: URL(string: "http://localhost:5069/api/Image/omvsqnfg.fom.jpg")) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .background(Color.gray)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Andre")
                            .font(Font.system(size: 18).weight(.semibold))
                            .foregroundColor(Color.black)
                        
                        Text("Ryabokon")
                            .font(Font.system(size: 18).weight(.semibold))
                            .foregroundColor(Color.black)
                    }
                    
                    Text("@sdqwfqw")
                        .font(Font.system(size: 16))
                        .foregroundColor(Color.blue)
                        .padding(.bottom, 7)
                    Text("О себе")
                        .font(Font.system(size: 18).weight(.semibold))
                    
                    if isExpanded {
                        Text("Привет! Я здесь, чтобы делиться и учиться. Люблю путешествия, науку и искусство. Давайте общаться и развиваться вместе! 🌍📚🎨 #СоциальнаяСеть #Личность")
                            .multilineTextAlignment(.leading)
                    } else {
                        Text("Привет! Я здесь, чтобы делиться и учиться.")
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                    }
                    
                    Button(action: {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }) {
                        Text(isExpanded ? "Свернуть" : "Развернуть")
                            .font(.system(size: 14))
                            .foregroundColor(.blue)
                    }
                }
                
                
                Spacer()
            }
            .padding()
            Spacer()
        }
    }
    
    var navigationBar: some View {
        HStack {
            Button(action: {
                // Действие, которое должно выполняться при нажатии кнопки
            }) {
                HStack {
                    Image(systemName: "arrow.left.circle.fill")
                    Text("Выйти")
                }
                .padding(7)
            }
            .frame(width: 100)
            .foregroundColor(.white)
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Spacer()
            NavigationLink(destination: ProfileEditScreen(viewModel: ProfileEditViewModel())) {
                    Image(systemName: "pencil")
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            NavigationLink(destination: NotificationsScreen()) {
                Image(systemName: "bell.fill")
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.yellow)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding(.horizontal)
    }

}



#Preview {
    TestView()
}
