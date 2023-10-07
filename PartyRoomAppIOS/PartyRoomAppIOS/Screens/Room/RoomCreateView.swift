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
        NavigationView {
            VStack {
                Text("Создание новой комнаты")
                    .font(.largeTitle)
                    .padding(.bottom, 20)

                TextField("Название", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Тип", text: $type)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Бюджет", text: $budget)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                    .onReceive(Just(budget)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.budget = filtered
                        }
                    }

                DatePicker("Дата начала", selection: $startDate, displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .padding()
                
                DatePicker("Дата конца", selection: $endDate, displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .padding()

                Button(action: {
                    viewModel.CreateRoomTest(name: name, type: type, budget: budget, startDate: startDate, endDate: endDate)
                }) {
                    Text("Создать")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
          
        }
    }
}

struct RoomCreateView_Previews: PreviewProvider {
    static var previews: some View {
        RoomCreateView()
    }
}
