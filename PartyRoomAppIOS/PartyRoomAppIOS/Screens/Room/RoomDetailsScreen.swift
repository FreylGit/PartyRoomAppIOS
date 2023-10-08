import SwiftUI
import Alamofire

struct RoomDetailsScreen: View {
    let roomId: String
    @EnvironmentObject var user: ApplicationUser
    @State  var roomDetails: RoomDetailsModel?
    @State private var userName: String = ""
    @State private var  copyLink: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let room = roomDetails {
                    VStack(alignment: .leading, spacing: 16) {
                        if room.isAuthor {
                            Button(action: {
                                deleteRoom()
                            }) {
                                Text("Удалить")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 12)
                                    .background(Color.red)
                                    .cornerRadius(12)
                            }
                        } else {
                            Button(action: {
                                disconnectWithRoom()
                            }) {
                                Text("Выйти")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 12)
                                    .background(Color.red)
                                    .cornerRadius(12)
                            }
                        }
                        
                        Section(header:
                            Text(room.name)
                                .font(.title)
                                .foregroundColor(.blue)
                                .padding(.top, 21)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        ) {
                            RoomInfoView(type: room.type, price: room.price, userName: room.destinationUserName, startDate: room.startDate, finishDate: room.finishDate, isAuthor: room.isAuthor, isStarted: room.isStarted, link: room.link)
                            
                            if room.isAuthor && !room.isStarted {
                                VStack(spacing: 16) {
                                    TextField("Введите имя пользователя", text: $userName)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding()
                                    
                                    Button(action: {
                                        pushInvite()
                                    }) {
                                        Text("Отправить приглашение")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 12)
                                            .background(Color.orange)
                                            .cornerRadius(12)
                                    }
                                }
                            }
                            
                            UsersInRoomView(roomId: roomId)
                        }
                        .padding(.top, 21)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 4)
                }
                Spacer()
            }
            .onAppear(perform: getRoom)
            .navigationBarTitle("Информация о комнате", displayMode: .inline)
        }
    }
    
    private func getRoom(){
        let token = "Bearer " + (user.jwtAccess?.token ?? "")
        let headers: HTTPHeaders = ["Authorization": token]
        
        NetworkBase()
            .requestAndParse(
                url:"http://localhost:5069/api/Room/"+roomId,
                method: .get,
                parameters:nil,
                headers: headers,
                type: RoomDetailsModel.self) { result in
                    switch result {
                    case .success(let loadedPost):
                        self.roomDetails = loadedPost
                        
                    case .failure(let error):
                        print("Error loading post: \(error)")
                    }
                }
        
    }
    
    private func pushInvite(){
        var url = "http://localhost:5069/api/Notifications/PushInvite"
        let parameters: Parameters = ["roomId": roomId, "username": userName]
        
        NetworkBase().sendPostRequest(url: url,method: .post, parameters: parameters) { result in
            switch result {
            case .success:
                userName = ""
            case .failure(let error):
                print("Error loading post: \(error)")
            }
        }
    }
    
    private func deleteRoom(){
        var url = "http://localhost:5069/api/Room"
        let parameters: Parameters = ["roomId":roomId]
        NetworkBase().sendPostRequest(url: url,method: .delete, parameters: parameters){ result in
            switch result{
            case .success:
                print("Комната удалена")
                self.presentationMode.wrappedValue.dismiss()
            case .failure(let error):
                print("Error loading post: \(error)")
            }
        }
    }
    
    private func disconnectWithRoom(){
        let url = "http://localhost:5069/api/Room/DisconnectUser"
        let parameters: Parameters = ["roomId":roomId]
        NetworkBase().sendPostRequest(url: url,method: .delete, parameters: parameters){ result in
            switch result{
            case .success:
                print("Комната покинута")
                self.presentationMode.wrappedValue.dismiss()
            case .failure(let error):
                print("Error loading post: \(error)")
            }
        }
    }
    
    private func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
}

struct KeyValueView: View {
    let key: String
    let value: String
    
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Text(value)
                .foregroundColor(.blue)
        }
    }
}

struct RoomDetailsPageView_Previews: PreviewProvider {
    static var previews: some View {
        let roomDetails = RoomDetailsModel(name: "Sample Room",
                                           type: "Sample Type",
                                           price: 100,
                                           isAuthor: true,
                                           isStarted: false,
                                           link: "qwdqw",
                                           destinationUserID: "123",
                                           startDate: "2023-09-17T12:00:00.000Z",
                                           finishDate: "2023-09-18T12:00:00.000Z")
        RoomDetailsScreen(roomId: "1",roomDetails: roomDetails)
            .environmentObject(ApplicationUser())
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Room Details Preview")
        
    }
}
