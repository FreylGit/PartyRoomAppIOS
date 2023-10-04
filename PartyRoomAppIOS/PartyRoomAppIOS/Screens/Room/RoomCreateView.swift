
import SwiftUI
import Combine
struct RoomCreateView: View {
    @State private var name: String = ""
    @State private var type: String = ""
    @State private var budget: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @ObservedObject private var viewModel = RoomCreateViewModel()
    @Environment(\.presentationMode) var presentationMode

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
                viewModel.CreateRoomTest(name: name, type: type, budget: budget, startDate: startDate, endDate: endDate)
            }, label: {
                Text("Создать")
            })
        }.padding()
    }
}


struct RoomCreateView_Previews: PreviewProvider {
    static var previews: some View {
        RoomCreateView()
    }
}
