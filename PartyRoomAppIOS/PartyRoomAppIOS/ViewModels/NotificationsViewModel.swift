import Foundation
import Alamofire

public class NotificationsViewModel : ObservableObject{
    @Published  var inviteItems :[InviteItemModel]?
    
    func GetInvite(){
        NetworkBase().requestAndParse(url: "http://localhost:5069/api/Notifications", method: .get, type: [InviteItemModel].self){ result in
            switch result {
            case .success(let loadedInviteItems):
                self.inviteItems = loadedInviteItems
                print(loadedInviteItems.count)
            case .failure(let error):
                print("Error loading profile \(error)")
                
            }
        }
    }
    
    func deleteNotification(at offsets: IndexSet) {
        print("Удалить")
        for index in offsets {
            let deletedItem = self.inviteItems?[index]
            if let deletedItem = deletedItem {
                print("Удаленный элемент: \(deletedItem.roomName)")
                let url = "http://localhost:5069/api/Notifications/InviteReaction?inviteId=\(deletedItem.id)&isConnect=false"
                NetworkBase().sendPostRequest(url: url, method: .post) { result in
                    switch result {
                    case .success(let r):
                        print("Удалил")
                    case .failure(let error):
                        print("Error loading profile \(error)")
                    }
                }
                
                self.inviteItems?.remove(at: index)
            }
        }
    }
    
    func ConnectToRoom(id:String, atIndex index: Int){
        print("Вступить")
        var url = "http://localhost:5069/api/Notifications/InviteReaction"
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
