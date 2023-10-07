import SwiftUI

struct RegistrationProfileDetailsScreen: View {
    @State private var bioText: String = ""
    @State private var tagName: String = ""
    @State private var tags: [String] = [] // Массив для хранения тегов
    @State private var isRegister = false
    @State  private var loginStatus = "accessToken" // Задайте начальное значение loginStatus
    
    var body: some View {
        if !isRegister{
            ScrollView{
                VStack {
                    Text("Расскажи о себе")
                        .font(.headline)
                    
                    TextEditor(text: $bioText)
                        .frame(height: 100)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(2)
                        .border(Color.black)
                    AddTagView(isLike: true)
                    
                    AddTagView(isLike: false)
                    Spacer()
                    
                    Button(action: {
                        isRegister = true
                    }){
                        Text("Зарегистрироваться")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.all)
            }
        }else{
            
            //LoginScreen()
            
             //   .navigationBarHidden(true)
        }
        
    }
}

struct RegistrationProfileDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationProfileDetailsScreen()
    }
}


struct AddTagView : View{
    var isLike = true
    @State private var tags:[Tag] = []
    @State private var tagName: String = "" //TODO: Сделать публичным чтобы можно было сохранять во внешней вью
    var body: some View{
        VStack{
            if isLike{
                Text("Твои увлечения").padding(.top,22)
                TextField("Например спорт", text: $tagName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }else{
                Text("Тебе не нравится").padding(.top,22)
                TextField("Например готовить", text: $tagName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            Button(action: {
                if !tagName.isEmpty {
                    tags.append(Tag(name:tagName))
                    tagName = ""
                    print(tags)
                }
                
            }) {
                Text("Добавить")
                    .padding()
                    .foregroundColor(Color.white)
            }
            .background(Color.green)
            .cornerRadius(10)
            ScrollView {
                ForEach(tags) { tag in
                    HStack{
                        Text("#"+tag.name)
                        Button(action: {
                            tags.removeAll { $0.id == tag.id }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(isLike ? .red : .black)
                                .padding(.trailing, 10.0)
                        }
                    }.padding()
                        .background(Color(isLike ? .green : .red))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    private struct Tag: Identifiable {
        let id = UUID()
        let name: String
    }
}

