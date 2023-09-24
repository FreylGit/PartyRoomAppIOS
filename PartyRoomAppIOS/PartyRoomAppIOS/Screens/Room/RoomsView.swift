import SwiftUI

struct RoomsView: View {
    @EnvironmentObject var user: ApplicationUser
    @State private var refreshToken: String? = nil
    @State  var rooms: [RoomsModelElement] = []
    @State private var name: String? = nil
    
    var body: some View {
        
        NavigationView {
            VStack {
                AsyncImage(url: URL(string: "https://play-lh.googleusercontent.com/GOOLgMYEhq8eZkOZ-MDEtRyze_wWuJ_mKayh7eV-VX_z2oVdYJaFPBiZ3qCuDN8k4w")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .cornerRadius(50)
                }placeholder: {
                    ProgressView()
                }
                Text(name ?? "пустой акк")
                Button(action: {
                    TokenManager.shared.clearTokens()
                    user.loginStatus = ""
                }){
                    Text("DELETE TOKEN")
                }
                if user.loginStatus != ""{
                    
                    
                    NavigationLink(destination: RoomCreateView().environmentObject(user)){
                        
                        Text("Создать комнату")
                            .padding(.all, 8.0)
                            .background(Color.green)
                            .cornerRadius(5)
                            .foregroundColor(.white)
                        
                            .padding()
                    }
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(rooms, id: \.id) { room in
                                NavigationLink(destination: RoomDetailsPageView(roomId: room.id).environmentObject(user)) {
                                    ItemRoomView(room: room)
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                    
                                        .padding(.vertical, 5)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                    }
                    .onAppear(perform: loadData)
                    .onAppear(perform: loadProfile)
                }
                Spacer()
                
            }
            
            
        }
    }
    
    func loadData() {
        NetworkBase()
            .requestAndParse(
                url:"http://localhost:5069/api/Room",
                method: .get,
                parameters:nil,
                type: [RoomsModelElement].self) { result in
                    switch result {
                    case .success(let loadedRooms):
                        self.rooms = loadedRooms
                    case .failure(let error):
                        print("Error loading post: \(error)")
                    }
                }
    }
    
    func loadProfile() {
        NetworkBase().requestAndParse(url: "http://localhost:5069/api/Profile", method: .get, type: ProfileModel.self){result in
            switch result{
            case .success(let loadedProfile):
                self.name = loadedProfile.firtsName
            case .failure(let error):
                print("Error loading profile \(error)")
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let testRoom1 = RoomsModelElement(id: "1", name: "Комната 1", type: "Тип 1", price: 100, isStarted: true, startDate: "2023-09-17", finishDate: "2023-09-18")
        let testRoom2 = RoomsModelElement(id: "2", name: "Комната 2", type: "Тип 2", price: 200, isStarted: false, startDate: "2023-09-18", finishDate: "2023-09-19")
        
        let testRooms: [RoomsModelElement] = [testRoom1, testRoom2]
        RoomsView(rooms: testRooms).environmentObject(ApplicationUser())
    }
}
