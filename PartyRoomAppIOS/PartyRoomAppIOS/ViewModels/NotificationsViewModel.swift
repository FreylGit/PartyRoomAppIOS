import Foundation
import Alamofire

public class NotificationsViewModel : ObservableObject{
    @Published  var inviteItems :[InviteItemModel]?
    
    func GetInvite(){
        NetworkBase().requestAndParse(url: "http://localhost:5069/api/Notifications", method: .get, type: [InviteItemModel].self){ result in
            switch result {
            case .success(let loadedInviteItems):
                self.inviteItems = loadedInviteItems
                print("Уведомлений"+String(loadedInviteItems.count))
            case .failure(let error):
                print("Error loading profile \(error)")
                
            }
        }
    }
    
    func deleteNotification(id:String, atIndex index: Int) {
       
                let url = "http://localhost:5069/api/Notifications/InviteReaction?inviteId=\(id)&isConnect=false"
                NetworkBase().sendPostRequest(url: url, method: .post) { result in
                    switch result {
                    case .success(_):
                        print("Удалил")
                        if let deletedItem = self.inviteItems?[index] {
                                        print("Удаленный элемент: \(deletedItem.roomName)")
                                        self.inviteItems?.remove(at: index)
                                    }
                    case .failure(let error):
                        print("Error loading profile \(error)")
                    }
                }
                
            
    }
    
    func ConnectToRoom(id:String, atIndex index: Int){
        print("Вступить")
        let url = "http://localhost:5069/api/Notifications/InviteReaction"
        let parameters: Parameters = ["inviteId": id, "isConnect": "true"]
        
        NetworkBase().sendPostRequest(url: url,method: .post, parameters: parameters) { result in
            switch result {
            case .success:
                print("Принято")
                if let deletedItem = self.inviteItems?[index] {
                                print("Удаленный элемент: \(deletedItem.roomName)")
                                self.inviteItems?.remove(at: index)
                            }
            case .failure(let error):
                print("Error loading post: \(error)")
            }
        }
    }
}
