import SwiftUI
import Alamofire

struct RoomDetailsPageView: View {
    let roomId: String
    @EnvironmentObject var user: ApplicationUser
    @State  var roomDetails: RoomDetailsModel?
    @State private var userName: String = ""
    var body: some View {
        
        VStack {
            if let room = roomDetails{
                Section(header: Text(room.name)
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .padding(.top, 21.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                )
                {
                    HStack {
                        Text("Тип:")
                        Spacer()
                        Text(room.type)
                        
                    }
                    HStack {
                        Text("Бюджет:")
                        Spacer()
                        Text(String(room.price))
                    }
                    NavigationLink(destination: {}){
                        HStack {
                            Text("Кому подарить:")
                                .foregroundColor(Color.black)
                            Spacer()
                            Text(room.destinationUserID)
                        }
                    }
                    HStack {
                        Text("Дата начала:")
                        Spacer()
                        Text(room.startDate)
                    }
                    HStack {
                        Text("Дата конца:")
                        Spacer()
                        Text(room.finishDate)
                    }
                    VStack {
                        TextField("Введите имя пользователя", text: $userName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Button(action: {
                            print(roomId)
                            pushInvite()
                        }, label: {
                            Text("Отправить приглашение")
                                .padding()
                                .background(Color.orange)
                        })
                        Spacer()
                    }
                }
                .padding(.top, 21.0)
            }
            Spacer()
        }
        .padding()
        .onAppear(perform: getRoom)
        .navigationBarTitle("Информация о комнате", displayMode: .inline)
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
        var url = "http://localhost:5069/api/Notifications/PushInvite"+"?roomId="+roomId+"&username="+userName
        NetworkBase()
            .requestAndParse(url: url, method: .post, type: RoomDetailsModel.self){result in
                switch result {
                case .success(let loadedPost):
                    self.roomDetails = loadedPost
                    userName = ""
                    
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
                                           destinationUserID: "123",
                                           startDate: "2023-09-17T12:00:00.000Z",
                                           finishDate: "2023-09-18T12:00:00.000Z")
        RoomDetailsPageView(roomId: "1",roomDetails: roomDetails)
            .environmentObject(ApplicationUser())
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Room Details Preview")
        
    }
}
