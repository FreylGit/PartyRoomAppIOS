import SwiftUI
import Alamofire

struct ConnectRoomScreen: View {
    @State private var roomLink: String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            TextField("Ссылка", text: $roomLink)
                .padding(.top, 100.0)
            Button(action: {
                connecttoRoom()
            }, label: {
                Text("Присоединиться")
            })
            Spacer()
        }
        .padding()
    }
    
    private func connecttoRoom(){
        let url = "http://localhost:5069/api/Room/ConnectToRoom"+"?link="+roomLink
        let parameters: Parameters = ["link" : roomLink]
        NetworkBase().sendPostRequest(url: url,method: .post){result in
            switch result{
            case .success:
                print("Получилось подключиться")
                self.presentationMode.wrappedValue.dismiss()
            case .failure(let error):
                print("Error loading post: \(error)")
            }
            
        }

    }
}

#Preview {
    ConnectRoomScreen()
}
