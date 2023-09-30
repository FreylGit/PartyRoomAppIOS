import SwiftUI
struct NotificationsScreen: View {
    @State private var inviteItems :[InviteItemModel] = []
    var body: some View {
        NavigationView {
            Button(action: {
                print(TokenManager.shared.getRefreshToken()!)
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
            List {
                ForEach(inviteItems, id: \.id) { inviteItem in
                    NotificationItem(inviteItem: inviteItem)
                }
                .onDelete(perform: deleteNotification)
            }
            .navigationBarTitle("Уведомления")
        }.onAppear(perform: {
            GetInvite()
        })
    }
    
    private func deleteNotification(at offsets: IndexSet) {
        for index in offsets {
               let deletedItem = inviteItems[index]
            print("Удаленный элемент: \(deletedItem.roomName)")
            var url = "http://localhost:5069/api/Notifications/InviteReaction?inviteId="+deletedItem.id+"&isConnect=false"
            // TODO: Добавить нормальный метод удаления(в нет бейс добавить метод без парсинга или добавить модель на статус код OK)
            NetworkBase().requestAndParse(url:url , method: .post,type: InviteItemModel.self){result in
                switch result{
                case .success(let r):
                    print("Удалил")
                case .failure(let error):
                    print("Error loading profile \(error)")
                }
                
            }
            
               inviteItems.remove(at: index)
           }
    }
    private func GetInvite(){
        NetworkBase().requestAndParse(url: "http://localhost:5069/api/Notifications", method: .get, type: [InviteItemModel].self){ result in
            switch result {
            case .success(let loadedInviteItems):
                self.inviteItems = loadedInviteItems
                print(inviteItems.count)
            case .failure(let error):
                print("Error loading profile \(error)")
                
            }
        }
    }
    
    struct NotificationItem: View {
        let inviteItem: InviteItemModel
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(inviteItem.roomName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Button(action: {
                        print("Реакция на уведомление: \(inviteItem.roomName)")
                        
                    }) {
                        Text("Вступить")
                            .padding()
                            .background(Color.green)
                            .cornerRadius(15)
                            .foregroundColor(.black)
                    }
                    
                }
                Spacer()
            }
            .padding(8)
        }
    }

    
    struct NotificationsScreen_Previews: PreviewProvider {
        static var previews: some View {
            NotificationsScreen()
        }
    }
}
