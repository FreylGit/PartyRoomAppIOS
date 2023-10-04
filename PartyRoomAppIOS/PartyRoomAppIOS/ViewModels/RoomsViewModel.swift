import Foundation

public class RoomsViewModel: ObservableObject{
    @Published  var rooms: [RoomsModelElement] = []
    @Published  var name: String? = nil
    
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
