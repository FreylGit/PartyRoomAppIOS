import SwiftUI

struct RoomSettings: View {
    @ObservedObject var viewModel: RoomDetailsViewModel
    @State private var roomName: String
    @State private var budget: String
    @Environment(\.presentationMode) var presentationMode
    init(viewModel: RoomDetailsViewModel) {
        self.viewModel = viewModel
        _roomName = State(initialValue: viewModel.roomDetails?.name ?? "")
        _budget = State(initialValue: String(viewModel.roomDetails?.price ?? 0))
    }
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
                .ignoresSafeArea()
            VStack {
                navigationBar
                if let isAuthor = viewModel.roomDetails?.isAuthor{
                    if isAuthor{
                        edit
                    }
                }
                
                Spacer()
            }
        }
    }
    
    var navigationBar : some View{
        
        HStack{
            if let isAuthor = viewModel.roomDetails?.isAuthor {
                if isAuthor {
                    Button(action: {
                        viewModel.deleteRoom()
                        self.presentationMode.wrappedValue.dismiss()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Удалить")
                            .padding(10)
                            .foregroundColor(.black)
                    })
                    .background(.red)
                    .cornerRadius(10)
                    
                }else{
                    Button(action: {
                        viewModel.disconnectWithRoom()
                    }, label: {
                        Text("Выйти")
                            .padding(10)
                            .foregroundColor(.black)
                    })
                    .background(.red)
                    .cornerRadius(10)
                }
                Spacer()
            }
        }
        .padding(.horizontal,20)
    }
    var edit: some View{
        VStack(alignment: .leading){
            Text("Название")
                .fontWeight(.bold)
                .padding(.horizontal,2)
            
            CustomTextFieldView(inputText: $roomName, label: "Название комнаты")
            Text("Бюджет")
                .fontWeight(.bold)
                .padding(.horizontal,2)
            CustomTextFieldView(inputText: $budget, label: "Бюджет")
            
        }
        .padding(.horizontal)
        .foregroundColor(.white)
    }
}

struct RoomSettings_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RoomDetailsViewModel(roomId: "qw")
        viewModel.roomDetails = RoomDetailsModel(name: "test", type: "private", price: 213, quantityParticipant: 11, isAuthor: true, isStarted: true, link: "wq", destinationUserID: "qwq", startDate: "212", finishDate: "wq")
        return RoomSettings(viewModel: viewModel)
    }
}
