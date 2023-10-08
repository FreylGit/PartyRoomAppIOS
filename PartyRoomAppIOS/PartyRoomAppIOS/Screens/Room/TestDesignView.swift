import SwiftUI

struct RoomDetailsScreen: View {
    @ObservedObject   var viewModel = RoomDetailsViewModel(roomId: "")
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView{
            navigationBar
            info
            invite
            userCollections
            Spacer()
        }.onAppear(perform: {
            viewModel.loadUsers()
            viewModel.getRoom()
        })
        
    }
    
    var navigationBar : some View{
        HStack{
            if let isAuthor = viewModel.roomDetails?.isAuthor{
                if isAuthor{
                    Button(action: {
                        viewModel.deleteRoom()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Удалить")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                }
                else{
                    Button(action: {
                        viewModel.disconnectWithRoom()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Выйти")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                }
            }
            
            Spacer()
        }
        .foregroundColor(.white)
        .fontWeight(.bold)
        .padding(.horizontal ,22)
    }
    
    var info: some View {
        VStack {
            if let room = viewModel.roomDetails {
                Text(room.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top, 21)
                    .padding(.leading,20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    HStack {
                        Text("Тип:")
                            .font(.headline)
                        Spacer()
                        Text(room.type)
                            .font(.body)
                    }
                    
                    HStack {
                        Text("Бюджет:")
                            .font(.headline)
                        Spacer()
                        Text("\(room.price) ₽")
                            .font(.body)
                    }
                    if let userName = room.destinationUserName {
                        NavigationLink(destination: ProfileMainScreen(viewModel: ProfileViewModel(isLogin: true, isCurrentProfile: false,username: userName),isLogin: true )) {
                            HStack {
                                Text("Кому подарить:")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                Spacer()
                                Text(userName)
                                    .font(.body)
                            }
                        }
                    }
                    HStack {
                        Text("Дата начала:")
                            .font(.headline)
                        Spacer()
                        Text(room.startDate)
                            .font(.body)
                    }
                    
                    HStack {
                        Text("Дата конца:")
                            .font(.headline)
                        Spacer()
                        Text(room.finishDate)
                            .font(.body)
                    }
                    if room.isAuthor && !room.isStarted{
                        HStack {
                            Text("Ссылка:")
                                .font(.headline)
                            Spacer()
                            if let link = room.link{
                                Text(link)
                                    .font(.body)
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        let pasteboard = UIPasteboard.general
                                        pasteboard.string = room.link ?? ""
                                    }
                            }
                            
                        }
                    }
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        }
        
    }
    
    var invite : some View{
        VStack{
            if let  room = viewModel.roomDetails{
                if room.isAuthor && !room.isStarted {
                    VStack(spacing: 16) {
                        TextField("Введите имя пользователя", text: $viewModel.userName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {
                            viewModel.pushInvite()
                        }) {
                            Text("Отправить приглашение")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(Color.orange)
                                .cornerRadius(12)
                        }
                    }
                }
                
            }
        }
    }
    
    var userCollections : some View{
        ForEach(viewModel.users ?? [], id: \.id) { user in
            HStack {
                AsyncImage(url: URL(string: user.details.imagePath)) { image in
                    image
                        .resizable()
                        .frame(width: 40, height: 40)
                        .background(Color.gray)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                Text(user.userName)
                Spacer()
                Button(action: {
                    // Действие, которое должно выполняться при нажатии на кнопку
                }) {
                    Image(systemName: "trash")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }.padding()
        }
    }
    
    
    
    
}

#Preview {
    
    RoomDetailsScreen()
}
