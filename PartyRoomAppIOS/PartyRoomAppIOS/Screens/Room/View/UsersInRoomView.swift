import SwiftUI
import Alamofire
/*
struct UsersInRoomView: View {
    var roomId:String
    @State private var users: [ProfileModel]? = nil
    var body: some View {
        VStack{
            if let users = users{
                ForEach(users, id: \.userName) { user in
                    UserInRoomItem(username: user.userName, imagePath: user.details.imagePath,id: user.id,roomId: roomId)
                }
            }
            Spacer()
        }.onAppear(perform: {
            loadUsers()
        })
    }
    
    func loadUsers(){
        NetworkBase()
            .requestAndParse(
                url:"http://localhost:5069/api/Room/Users?roomId="+roomId,
                method: .get,
                type: [ProfileModel].self) { result in
                    switch result {
                    case .success(let loadedPost):
                        self.users = loadedPost
                    case .failure(let error):
                        print("Error loading post: \(error)")
                    }
                }
    }
}

#Preview {
    UsersInRoomView(roomId: "2")
}

private struct UserInRoomItem : View{
    let username:String
    let imagePath: String
    let id: String?
    let roomId: String
    var body: some View{
        HStack{
            AsyncImage(url: URL(string: imagePath)) { image in
                image
                    .resizable()
                    .frame(width: 40, height: 40)
                    .background(Color.gray)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            Text(username)
            Spacer()
            Button(action: {
                disconnectUser()
            }) {
                Image(systemName: "trash")
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
        }.padding()
            
    }
    func disconnectUser(){
        var url = "http://localhost:5069/api/Room/DisconnectUser?roomId="+roomId+"&participantId="+id!
        NetworkBase().sendPostRequest(url: url,method: .delete){ result in
            switch result{
            case .success:
                print("Пользователь отключен")
            case .failure(let error):
                print("Error loading post: \(error)")
            }
        }
    }
}
*/
