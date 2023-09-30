import SwiftUI

struct ConnectRoomScreen: View {
    @State private var roomLink: String = ""
    var body: some View {
        VStack{
            TextField("Ссылка", text: $roomLink)
                .padding(.top, 100.0)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Присоединиться")
            })
            Spacer()
        }
        .padding()
    }
        
}

#Preview {
    ConnectRoomScreen()
}
