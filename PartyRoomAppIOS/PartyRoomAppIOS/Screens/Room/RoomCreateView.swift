
import SwiftUI
import Combine
struct RoomCreateView: View {
    @State private var name: String = ""
    @State private var type: String = ""
    @State private var budget: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var user: ApplicationUser
    var body: some View {
        
        VStack {
            Text("Создание новой комнаты").bold()
            TextField("Название", text: $name).padding()
            TextField("Тип", text: $type).padding()
            TextField("Бюджет", text: $budget) .keyboardType(.numberPad)
                .padding()
                .onReceive(Just(budget)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.budget = filtered
                    }
                }
            DatePicker("Дата начала", selection: $startDate, displayedComponents: .date)
                .padding()
            DatePicker("Дата конца", selection: $endDate, displayedComponents: .date)
                .padding()
            Button(action: {
                CreateRoomTest(presentationMode: presentationMode)
            }, label: {
                Text("Создать")
            })
        }.padding()
    }
    private func CreateRoomTest(presentationMode: Binding<PresentationMode>){
        let url = "http://localhost:5069/api/Room"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let roomCreate = RoomCreateModel(name: name, type: type, price: Int(budget)!, startDate: dateFormatter.string(from:startDate), finishDate: dateFormatter.string(from:endDate))
        NetworkBase().sendPostRequestBody(url: url, objectToEncode: roomCreate) { result in
            switch result {
            case .success(let data):
                if let responseData = data {
                    presentationMode.wrappedValue.dismiss() // Закрываем текущее представление
                } else {
                    print("Пустой ответ")
                }
            case .failure(let error):
                print("Ошибка запроса: \(error)")
            }
        }
    }
}


struct RoomCreateView_Previews: PreviewProvider {
    static var previews: some View {
        RoomCreateView()
    }
}
