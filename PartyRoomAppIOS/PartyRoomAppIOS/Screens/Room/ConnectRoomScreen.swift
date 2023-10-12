import SwiftUI
import Alamofire

struct ConnectRoomScreen: View {
    @State private var roomLink: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextField("Ссылка", text: $roomLink)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.top, .leading, .trailing])

                Button(action: {
                    connecttoRoom()
                }, label: {
                    Text("Присоединиться")
                        .padding(5)
                        .foregroundColor(.white)
                        .background(Color.orange)
                })
                Spacer()
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.25, green: 0.17, blue: 0.01).opacity(0.8), Color(red: 0.04, green: 0.08, blue: 0.22).opacity(0.9)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            
        }
        
    }

    private func connecttoRoom() {
        let url = "http://localhost:5069/api/Room/ConnectToRoom" + "?link=" + roomLink
        let _: Parameters = ["link": roomLink]
        NetworkBase().sendPostRequest(url: url, method: .post) { result in
            switch result {
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
