import Foundation
import Alamofire

public class RoomDetailsViewModel : ObservableObject{
    @Published  var roomDetails: RoomDetailsModel?
    @Published  var userName: String = ""
    @Published  var  copyLink: String = ""
    @Published  var roomId: String = ""
    @Published var users: [ProfileModel]? = nil
    init(roomId:String){
        self.roomId = roomId
    }
    func pushInvite(){
        let url = "http://localhost:5069/api/Notifications/PushInvite"
        let parameters: Parameters = ["roomId": roomId, "username": userName]
        
        NetworkBase().sendPostRequest(url: url,method: .post, parameters: parameters) { result in
            switch result {
            case .success:
                self.userName = ""
            case .failure(let error):
                print("Error loading post: \(error)")
            }
        }
    }
    
    func deleteRoom(){
        let url = "http://localhost:5069/api/Room"
        let parameters: Parameters = ["roomId":roomId]
        NetworkBase().sendPostRequest(url: url,method: .delete, parameters: parameters){ result in
            switch result{
            case .success:
                print("Комната удалена")
                
            case .failure(let error):
                print("Error loading post: \(error)")
            }
        }
    }
    
    func disconnectWithRoom(){
        let url = "http://localhost:5069/api/Room/DisconnectUser"
        let parameters: Parameters = ["roomId":roomId]
        NetworkBase().sendPostRequest(url: url,method: .delete, parameters: parameters){ result in
            switch result{
            case .success:
                print("Комната покинута")
                
            case .failure(let error):
                print("Error loading post: \(error)")
            }
        }
    }
    
    func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
    func loadUsers(){
        let url = URL(string: APIClient.shared.roomURL.absoluteString + "/" + "Users?roomId="+roomId)
        NetworkBase()
            .requestAndParse(
                url:url!,
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
    
    func getRoom(){
        let url = URL(string: APIClient.shared.roomURL.absoluteString + "/" + roomId)
        NetworkBase()
            .requestAndParse(
                url:url!,
                method: .get,
                type: RoomDetailsModel.self) { result in
                    switch result {
                    case .success(let loadedPost):
                        self.roomDetails = loadedPost
                        
                    case .failure(let error):
                        print("Error loading post: \(error)")
                    }
                }
    }
}
