import SwiftUI

struct ProfileEditScreen: View {
    @State private var bioText = ""
    @State private var tagGoodName = ""
    @State private var tagBeadName = ""
    @ObservedObject private var viewModel = ProfileEditViewModel()
    init(viewModel: ProfileEditViewModel) {
        _bioText = State(initialValue: viewModel.bioText)
        self.viewModel = viewModel  
    }
    @Environment(\.presentationMode) var presentationMode
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
                    
                    TagCloudView(tags:$viewModel.goodTag,isCurrentProfile: true,isGood: true)
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
                    TagCloudView(tags:$viewModel.beadTag,isCurrentProfile: true,isGood: false)
                }
                Spacer()
                
            }
        }
        .padding()
        .navigationBarItems(trailing:
                                Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Готово")
                .foregroundColor(.blue)
            
        }
        )
        .background(GradientBackgroundView()) 
    }
}

struct ProfileEditScreen_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProfileEditViewModel()
        viewModel.bioText = "wqfqwf'wqfqwf wfqwlfw fqwf qwfwq "
        viewModel.tags = [Tag(id: "1", name: "tag1", important: true, isLike: false), Tag(id: "2", name: "Спорт", important: true, isLike: true), Tag(id: "3", name: "Искусство", important: true, isLike: false), Tag(id: "4", name: "1dqwd2у1", important: true, isLike: true),
                          Tag(id: "5", name: "12у1", important: true, isLike: true),
                          Tag(id: "6", name: "12уdwqdwq1", important: true, isLike: true),
                          Tag(id: "7", name: "12у1", important: true, isLike: true)]
        return ProfileEditScreen(viewModel: viewModel)
    }
}


