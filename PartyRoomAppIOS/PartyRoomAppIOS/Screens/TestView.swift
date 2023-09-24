import SwiftUI
import Alamofire

struct TestView: View {
    @State var post: Post? // Изменим тип на Post?
    @State var room: RoomDetailsModel?
    @EnvironmentObject var user: ApplicationUser
    var body: some View {
        
        VStack {
            if let room = room { // Проверяем, есть ли данные
                Text(room.name)
                    .font(.headline)
                Text(String(room.price))
                    .font(.subheadline)
            } else {
                Text("Loading...") // Отобразим загрузку, пока данные не загружены
            }
        }
        .onAppear {
   
            NetworkBase()
                .requestAndParse(
                    url:"http://localhost:5069/api/Room/55fd2731-7b7d-41cc-b630-abfac58e8f0f",
                    method: .get,
                    parameters:nil,
                    type: RoomDetailsModel.self) { result in
                switch result {
                case .success(let loadedPost):
                    self.room = loadedPost
                case .failure(let error):
                    print("Error loading post: \(error)")
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView().environmentObject(ApplicationUser())
    }
}

struct Post: Decodable {
    let name: String
    let age: Int
}
