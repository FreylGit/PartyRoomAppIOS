import SwiftUI

struct RoomsScreen: View {
    @EnvironmentObject var user: ApplicationUser
    @State private var refreshToken: String? = nil
    @ObservedObject  var viewModel = RoomsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.name ?? "пустой акк")
                Button(action: {
                    TokenManager.shared.clearTokens()
                }){
                    Text("DELETE TOKEN")
                }
                HStack{
                    NavigationLink(destination: RoomCreateScreen()){
                        Text("Создать комнату")
                            .padding(.all, 8.0)
                            .background(Color.green)
                            .cornerRadius(5)
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                    NavigationLink(destination: ConnectRoomScreen()){
                        Text("Присоединиться")
                            .padding(.all, 8.0)
                            .background(Color.orange)
                            .cornerRadius(5)
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .padding()
                    }
                }
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.rooms, id: \.id) { room in
                            NavigationLink(destination: RoomDetailsScreen(viewModel: RoomDetailsViewModel(roomId: room.id))) {
                                ItemRoomView(room: room)
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal,10)
                                    .cornerRadius(10)
                                    .padding(.vertical, 5)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .onAppear(perform: viewModel.loadData)
                .onAppear(perform: viewModel.loadProfile)
                Spacer()
            }
            .background(GradientBackgroundView())
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let testRoom1 = RoomsModelElement(id: "1", name: "Комната 1", type: "Тип 1", price: 100,quantityParticipant: 1, isStarted: true, startDate: "2023-09-17", finishDate: "2023-10-01T13:14:03.36")
        let testRoom2 = RoomsModelElement(id: "2", name: "Комната 2", type: "Тип 2", price: 200,quantityParticipant: 2, isStarted: false, startDate: "2023-09-18", finishDate: "2023-09-19")
        
        let rooms: [RoomsModelElement] = [testRoom1, testRoom2]
        
        let viewModel = RoomsViewModel()
        viewModel.rooms = rooms
        viewModel.name = "Имя пользователя"
        
        return RoomsScreen().environmentObject(ApplicationUser())
    }
}
