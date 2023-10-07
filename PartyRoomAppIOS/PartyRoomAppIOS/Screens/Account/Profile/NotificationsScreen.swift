import SwiftUI

struct NotificationsScreen: View {
    @ObservedObject var viewModel = NotificationsViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let inviteItems = viewModel.inviteItems {
                        ForEach(inviteItems, id: \.id) { inviteItem in
                            HStack(spacing: 8) {
                                Text(inviteItem.roomName)
                                    .font(.system(size: 14)) 
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: 170)
                                    
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
                            .background(Color.gray)
                            .cornerRadius(15)
                        }
                        .padding([.leading, .bottom, .trailing],10)
                        
                    }
                }
            }
            .onAppear {
                viewModel.GetInvite()
            }
            .navigationBarTitle("Уведомления")
        }
    }
}

struct NotificationsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsScreen()
    }
}

