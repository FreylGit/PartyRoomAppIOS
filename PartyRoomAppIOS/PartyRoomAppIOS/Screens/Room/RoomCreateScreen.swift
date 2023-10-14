import SwiftUI
import Combine

struct RoomCreateScreen: View {
    @State private var name: String = ""
    @State private var type: String = ""
    @State private var budget: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @ObservedObject private var viewModel = RoomCreateViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                Text("Создание новой комнаты")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                
                CustomTextFieldView(inputText: $name, label: "Название")
                CustomTextFieldView(inputText: $type, label: "Тип")
                CustomTextFieldView(inputText: $budget, label: "Бюджет")
                    .onReceive(Just(budget)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.budget = filtered
                        }
                    }

                DatePicker("Дата начала", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(DefaultDatePickerStyle())
                    .padding()
                
                DatePicker("Дата конца", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding()
                


                Button(action: {
                    print(endDate)
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
              Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .background(GradientBackgroundView())
          
          
        }
        
    }
    
}

struct RoomCreateView_Previews: PreviewProvider {
    static var previews: some View {
        RoomCreateScreen()
    }
}
