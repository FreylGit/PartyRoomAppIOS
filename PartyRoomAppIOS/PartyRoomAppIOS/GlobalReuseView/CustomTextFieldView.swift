import SwiftUI

struct CustomTextFieldView: View {
    @Binding  var inputText: String
    let label:String
    var body: some View {
        TextField(text: $inputText, label:{
            Text(label)
                .foregroundColor(Color.gray.opacity(0.6))
        })
        .padding(.vertical,10)
        .padding(.horizontal,10)
        .background(Color("TextEdit"))
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

struct CustomTextEditView_Previews: PreviewProvider {
    @State static var text: String = ""
    
    static var previews: some View {
        CustomTextFieldView(inputText: $text, label: "Например спорт")
    }
}
