import SwiftUI

struct NotificationsScreen: View {
    @ObservedObject var viewModel = NotificationsViewModel()
    var body: some View {
        VStack{
            HStack{
                Text("Уведомления")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal,20)
                Spacer()
            }
           
            Spacer()
            ScrollView {
                if let inviteItems = viewModel.inviteItems {
                    ForEach(inviteItems, id: \.id) { inviteItem in
                        HStack(spacing: 8) {
                            Text(inviteItem.roomName)
                                .font(.system(size: 14))
                                .foregroundColor(.primary)
                            Spacer()
                            Button(action: {
                                if let index = inviteItems.firstIndex(where: { $0.id == inviteItem.id }) {
                                    viewModel.ConnectToRoom(id: inviteItem.id, atIndex: index)
                                }
                            }) {
                                Text("Вступить")
                                    .padding(.all, 7.0)
                                    .background(Color.green)
                                    .cornerRadius(5)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                            }
                            Button(action: {
                                if let index = inviteItems.firstIndex(where: { $0.id == inviteItem.id }) {
                                    viewModel.deleteNotification(id: inviteItem.id, atIndex: index)
                                }
                            }) {
                                Text("Отклонить")
                                    .padding(.all, 7.0)
                                    .background(Color.red)
                                    .cornerRadius(5)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                            }
                        }
                        .padding()
                        .background(Color.mint)
                        .cornerRadius(15)
                    }
                    .padding([.leading, .bottom, .trailing],10)
                }
                
            }
            .onAppear {
                viewModel.GetInvite()
            }
            
        }
        .frame(width: .infinity)
        .background(GradientBackgroundView())
    }
    
}

struct NotificationsScreen_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = NotificationsViewModel()

        // Create some test data for inviteItems
        let testInviteItem = InviteItemModel(id: "1", userId: "user1", roomId: "room1", roomName: "Test Room")

        // Assign the test data to the viewModel
        viewModel.inviteItems = [testInviteItem]

        return NotificationsScreen(viewModel: viewModel)
    }
}

