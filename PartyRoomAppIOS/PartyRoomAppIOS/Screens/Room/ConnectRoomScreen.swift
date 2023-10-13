import SwiftUI
import Alamofire

struct ConnectRoomScreen: View {
    @State private var roomLink: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                CustomTextFieldView(inputText: $roomLink, label: "Сылка")
                    .padding(.bottom)
                Button(action: {
                    connecttoRoom()
                }, label: {
                    Text("Присоединиться")
                        .padding(7)
                        .foregroundColor(.white)
                        .background(Color.orange)
                })
                Spacer()
            }
            .padding()
            .background(GradientBackgroundView())
            
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
