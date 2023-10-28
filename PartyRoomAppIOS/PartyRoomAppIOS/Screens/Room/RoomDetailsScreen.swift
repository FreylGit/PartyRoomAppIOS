import SwiftUI

struct RoomDetailsScreen: View {
    @ObservedObject var viewModel = RoomDetailsViewModel(roomId: "")
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingToast = false
    var body: some View {
        VStack{
            if let room = viewModel.roomDetails{
                TopBarView(name:room.name)
                    roomInfo
            }
            ScrollView(){
                if let isStarted = viewModel.roomDetails?.isStarted{
                    if !isStarted{
                        infot
                        invite
                    }
                }
                info
                if isShowingToast {
                        HStack() {
                            Spacer()
                                Text("Ссылка скопирована")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.orange)
                                    .cornerRadius(10)
                            Spacer()
                        }
                }
                userCollections
                Spacer()
                
            }
            .onAppear(perform: {
                viewModel.loadUsers()
                viewModel.getRoom()
            })
        }
        .background(GradientBackgroundView())
    }
    
    var roomInfo : some View{
        HStack(alignment:.top){
            VStack{
                Text("Бюджет")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("213 P")
            }
            .padding(9)
            VStack{
                Text("Дата начала")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("20.09.23")
            }
            .padding(9)
           
            VStack{
                Text("Дата конца")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("22.12.23")
            }
            .padding(9)
        }
        .background(Color("Grey"))
        .foregroundColor(.white)
        .cornerRadius(15)
    }

    var dateInfo: some View {
        HStack {
            if let room = viewModel.roomDetails
            {
                VStack {
                    Text(formattedDate(dateString:room.startDate))
                }
                .padding(9)
                .background(
                    Color.green
                        .opacity(0.4)
                        .blur(radius: 10)
                )
                .border(Color.green)
                .cornerRadius(12)
                Spacer()
                VStack {
                    Text(formattedDate(dateString:room.finishDate))
                }
                .padding(9)
                .background(
                    Color.red
                        .opacity(0.5)
                        .blur(radius: 10)
                )
                .border(Color.red)
                .cornerRadius(12)
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal, 50)
    }
    
    var infot: some View{
        HStack{
            if let link = viewModel.roomDetails?.link{
                HStack{
                    Image(systemName: "paperclip")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                    Text("Ссылка-приглашение")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            let pasteboard = UIPasteboard.general
                            pasteboard.string = link ?? ""
                            showToast()
                        }
                }
                .padding(10)
                .background(Color.yellow)
                
            }
        }
        .cornerRadius(15)
    }
    
    var info: some View {
        VStack {
            if let room = viewModel.roomDetails {
                VStack(alignment: .leading) {
                    if let userName = room.destinationUserName {
                        Text("Кому подарить:")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                        NavigationLink(destination: ProfileMainScreen(viewModel: ProfileViewModel(isLogin: true, isCurrentProfile: false,username: userName))) {
                            Text("@"+userName)
                                .font(.body)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .padding(.leading,20)
                        .background(Color.clear)
                        .cornerRadius(10)
                    }
                    HStack{
                        Spacer()
                    }
                }
                
            }
        }
    }
    
    var invite : some View{
        VStack{
            if let  room = viewModel.roomDetails{
                if room.isAuthor && !room.isStarted {
                    VStack(spacing: 16) {
                        CustomTextFieldView(inputText: $viewModel.userName, label: "Введите имя пользователя")
                            .padding(.horizontal)
                            .padding(.top)
                        Button(action: {
                            viewModel.pushInvite()
                        }) {
                            Text("Отправить приглашение")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(Color("Color"))
                                .cornerRadius(12)
                        }
                    }
                }
                
            }
        }
    }
    
    var userCollections : some View{
        ForEach(viewModel.users ?? [], id: \.id) { user in
            NavigationLink(destination: ProfileMainScreen(viewModel: ProfileViewModel(isLogin: true, isCurrentProfile: false,username: user.userName))) {
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
                    Text("@"+user.userName)
                        .foregroundColor(.white)
                    Spacer()
                    if let isAuthor = viewModel.roomDetails?.isAuthor{
                        if isAuthor{
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
                        }
                    }
                }
                .padding()
            }
            .background(Color("Grey"))
            .padding(2)
            .cornerRadius(20)
        }
        
    }
    
    
    func showToast() {
        isShowingToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                isShowingToast = false
            }
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "ru")
        return formatter
    }()
    
    func formattedDate(dateString: String) -> String {
        var formattedDateString = dateString
        
        // Check if the date string contains milliseconds
        if let dotRange = dateString.range(of: ".", options: .literal) {
            // Remove the milliseconds part
            formattedDateString = String(dateString[..<dotRange.lowerBound])
        }
        
        if let date = dateFormatter.date(from: formattedDateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd.MM.yyyy \n HH:mm"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
}

struct RoomDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RoomDetailsViewModel(roomId: "sampleRoomId")
        
        let roomDetails = RoomDetailsModel(
            name: "Sample Room",
            type: "Sample Type",
            price: 1000,
            quantityParticipant: 4,
            isAuthor: true,
            isStarted: false,
            link: "https://example.com",
            destinationUserID: "sampleUserID",
            startDate: "2023-10-04T19:00:26.542",
            finishDate: "2023-10-05T19:00:26.542",
            destinationUserName: "Sample User"
        )
        
        viewModel.roomDetails = roomDetails
        
        let sampleProfile = ProfileModel(
            id: "sampleUserID",
            firtsName: "John",
            lastName: "Doe",
            userName: "johndoe",
            email: "john@example.com",
            phoneNumber: "123-456-7890",
            details: Details(about: "About John Doe", imagePath: "http://localhost:5069/api/Image/omvsqnfg.fom.jpg"),
            tags: [
                Tag(id: "1", name: "Tag1", important: true, isLike: false),
                Tag(id: "2", name: "Tag2", important: false, isLike: true)
            ]
        )
        
        viewModel.users = [sampleProfile,sampleProfile]
        
        return RoomDetailsScreen(viewModel: viewModel)
        
    }
}
