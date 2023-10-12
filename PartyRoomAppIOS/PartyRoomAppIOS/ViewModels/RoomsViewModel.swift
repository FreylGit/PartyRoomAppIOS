import Foundation

public class RoomsViewModel: ObservableObject{
    @Published  var rooms: [RoomsModelElement] = []
    @Published  var name: String? = nil
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
            formatter.locale = Locale(identifier: "ru") // Установка локализации на русский
            return formatter
        }()
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
