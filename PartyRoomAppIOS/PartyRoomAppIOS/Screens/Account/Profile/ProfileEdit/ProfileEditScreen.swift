import SwiftUI

struct ProfileEditScreen: View {
    @State private var bioText = ""
    @State private var tagName = ""
    @ObservedObject private var viewModel = ProfileEditViewModel()
    init(viewModel: ProfileEditViewModel) {
        _bioText = State(initialValue: viewModel.bioText)
    }
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
            AddTagView(isLike: true)
            AddTagView(isLike: false)
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

struct ProfileEditScreen_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProfileEditViewModel()
        viewModel.bioText = "wqfqwf'wqfqwf wfqwlfw fqwf qwfwq "
        return ProfileEditScreen(viewModel: viewModel)
    }
}


