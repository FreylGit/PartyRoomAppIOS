import SwiftUI

struct RegistrationProfileDetailsScreen: View {
    
    @State private var isRegister = false
    @State  private var loginStatus = "accessToken" 
    @State private var bioText = ""
    @State private var tagGoodName = ""
    @State private var tagBeadName = ""
    @ObservedObject private var viewModel = ProfileEditViewModel()
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Text("О Себе")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                TextEditor(text: $bioText)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.white)
                    .frame(height: 100)
                    .cornerRadius(15)
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 3)
                    )
                VStack(alignment: .leading) {
                    Text("Предпочтения")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    HStack{
                        CustomTextFieldView(inputText: $tagGoodName, label: "Например готовить")
                        Button(action: {
                            viewModel.goodTag.append(Tag(id: tagGoodName, name: tagGoodName, important: true, isLike: true))
                            tagGoodName = ""
                        }){
                            Image(systemName: "plus")
                                .padding(10)
                        }
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    TagCloudView(tags:$viewModel.goodTag,isEdit: true,isGood: true)
                    Divider()
                    
                    Text("Антипатия")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    HStack{
                        CustomTextFieldView(inputText: $tagBeadName, label: "Например спорт")
                        
                        Button(action: {
                            viewModel.beadTag.append(Tag(id: tagBeadName, name: tagBeadName, important: true, isLike: false))
                            tagBeadName = ""
                        }){
                            Image(systemName: "plus")
                                .padding(10)
                        }
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    TagCloudView(tags:$viewModel.beadTag,isEdit: true,isGood: false)
                }
                HStack(){
                    Spacer()
                    Button(action: {}){
                        Text("Зарегистироваться")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(.orange)
                    .cornerRadius(10)
                    Spacer()
                }
                
                Spacer()
                
            }
        }
        .padding()
        .background(GradientBackgroundView())
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

