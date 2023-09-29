import SwiftUI
struct NotificationsScreen: View {
    var notifications = ["Уведомление 1", "Уведомление 2", "Уведомление 3"]
    @State private var inviteItems :[InviteItemModel] = []
    var body: some View {
        NavigationView {
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
                        // Добавьте вашу логику для кнопки "Вступить" здесь
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
