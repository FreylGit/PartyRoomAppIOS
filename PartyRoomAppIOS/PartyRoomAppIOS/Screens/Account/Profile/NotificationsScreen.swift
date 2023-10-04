import SwiftUI
import Alamofire

struct NotificationsScreen: View {
    @ObservedObject  var viewModel : NotificationsViewModel
    
    init(viewModel: NotificationsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                if let  inviteItems = viewModel.inviteItems{
                    ForEach(inviteItems, id: \.id) { inviteItem in
                        HStack {
                            HStack( spacing: 8) {
                                Text(inviteItem.roomName)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Button{
                                    if let index = inviteItems.firstIndex(where: { $0.id == inviteItem.id }){
                                        viewModel.ConnectToRoom(id:inviteItem.id,atIndex: index)
                                    }
                                    
                                } label:{
                                    Text("Вступить")
                                        .padding()
                                        .background(Color.green)
                                        .cornerRadius(15)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .padding(8)
                    }
                    .onDelete(perform: viewModel.deleteNotification)
                    
                }
                
            }
            .onAppear(perform: {
                viewModel.GetInvite()
            })
        }
        .navigationBarTitle("Уведомления")
    }
}


struct NotificationsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsScreen(viewModel: NotificationsViewModel())
    }
}

