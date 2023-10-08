import Foundation
import SwiftUI

public class RoomCreateViewModel : ObservableObject{
    
    func CreateRoomTest(name:String,type:String,budget:String,startDate:Date,endDate:Date){
        if(name.isEmpty || type.isEmpty || budget.isEmpty || startDate >= endDate  ){
            return
        }
        let url = "http://localhost:5069/api/Room"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let roomCreate = RoomCreateModel(name: name, type: type, price: Int(budget)!, startDate: dateFormatter.string(from:startDate), finishDate: dateFormatter.string(from:endDate))
        NetworkBase().sendPostRequestBody(url: url, objectToEncode: roomCreate) { result in
            switch result {
            case .success(let data):
                if data != nil {
                } else {
                    print("Пустой ответ")
                }
            case .failure(let error):
                print("Ошибка запроса: \(error)")
            }
        }
    }
}
