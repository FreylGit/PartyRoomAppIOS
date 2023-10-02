import SwiftUI

struct RoomInfoView: View {
    let type: String
    let price: Int
    let userName: String?
    let startDate: String
    let finishDate: String
    let isAuthor, isStarted: Bool
    let link: String?
    @State private var copyLink: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Тип:")
                    .font(.headline)
                Spacer()
                Text(type)
                    .font(.body)
            }

            HStack {
                Text("Бюджет:")
                    .font(.headline)
                Spacer()
                Text("\(price) ₽")
                    .font(.body)
            }

            if let userName = userName {
                NavigationLink(destination: ProfileScreen(viewModel: ProfileViewModel(isLogin: true, isCurrentProfile: false,username: userName) )) {
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
                Text(startDate)
                    .font(.body)
            }

            HStack {
                Text("Дата конца:")
                    .font(.headline)
                Spacer()
                Text(finishDate)
                    .font(.body)
            }

            if isAuthor && !isStarted {
                HStack {
                    Text("Ссылка:")
                        .font(.headline)
                    Spacer()
                    Text(link!)
                        .font(.body)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            let pasteboard = UIPasteboard.general
                            pasteboard.string = link ?? ""
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

#Preview {
    RoomInfoView(type: "Открыто", price: 200, userName: "andrey", startDate: "2023-11-01", finishDate: "2023-12-31", isAuthor: true, isStarted: true, link: "wfqwfqwbt")
}
