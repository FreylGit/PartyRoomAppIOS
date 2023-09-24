import SwiftUI

struct ProfileEditView: View {
    @State private var bioText = ""
    @State private var tagName = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(alignment: .leading) {
            Text("О Себе")
                .font(.headline)
            
            TextEditor(text: $bioText)
                .frame(height: 100)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(2)
                .border(Color.black)
          
                
            Spacer()
            
            
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
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}


