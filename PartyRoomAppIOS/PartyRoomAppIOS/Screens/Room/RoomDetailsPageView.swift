import SwiftUI
import Alamofire

struct RoomDetailsPageView: View {
    let roomId: String
    @EnvironmentObject var user: ApplicationUser
    @State  var roomDetails: RoomDetailsModel?
    
    
    var body: some View {
            Form {
                Section(header: Text("Room Details")) {
                    if let name = roomDetails?.name {
                        HStack {
                            Text("Name:")
                            Spacer()
                            Text(name)
                        }
                    }
                    if let type = roomDetails?.type {
                        HStack {
                            Text("Type:")
                            Spacer()
                            Text(type)
                        }
                    }
                    if let price = roomDetails?.price {
                        HStack {
                            Text("Price:")
                            Spacer()
                            Text(String(price))
                        }
                    }
                    if let destinationUser = roomDetails?.destinationUserID {
                        NavigationLink(destination: {}){
                            HStack {
                                Text("Destination User:").foregroundColor(Color.black)
                                Spacer()
                                Text(destinationUser)
                            }
                        }
                        
                    }
                    if let startDate = roomDetails?.startDate {
                        HStack {
                            Text("Start Date:")
                            Spacer()
                            Text(startDate)
                        }
                    }
                    if let finishDate = roomDetails?.finishDate {
                        HStack {
                            Text("Finish Date:")
                            Spacer()
                            Text(finishDate)
                        }
                    }
                }
            }.onAppear(perform: getRoom)
            .navigationBarTitle("Room Details", displayMode: .inline)
        }
    
    private func getRoom(){
        let token = "Bearer " + (user.jwtAccess?.token ?? "")
        let headers: HTTPHeaders = ["Authorization": token]
        
        NetworkBase()
            .requestAndParse(
                url:"http://localhost:5069/api/Room/"+roomId,
                method: .get,
                parameters:nil,
                headers: headers,
                type: RoomDetailsModel.self) { result in
                    switch result {
                    case .success(let loadedPost):
                        self.roomDetails = loadedPost
                        
                    case .failure(let error):
                        print("Error loading post: \(error)")
                    }
                }
    }
    
    private func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
}

struct KeyValueView: View {
    let key: String
    let value: String
    
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Text(value)
                .foregroundColor(.blue)
        }
    }
}

struct RoomDetailsPageView_Previews: PreviewProvider {
    static var previews: some View {
        let roomDetails = RoomDetailsModel(name: "Sample Room",
                                           type: "Sample Type",
                                           price: 100,
                                           destinationUserID: "123",
                                           startDate: "2023-09-17T12:00:00.000Z",
                                           finishDate: "2023-09-18T12:00:00.000Z")
        RoomDetailsPageView(roomId: "1",roomDetails: roomDetails)
            .environmentObject(ApplicationUser())
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Room Details Preview")
        
    }
}
