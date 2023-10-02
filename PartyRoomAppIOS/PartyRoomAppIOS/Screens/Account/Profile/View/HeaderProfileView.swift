import SwiftUI


struct AppFonts {
    static let headlineFont = Font.system(size: 18).weight(.semibold)
    static let bodyFont = Font.system(size: 16)
}

struct HeaderProfileView: View {
    @State var firstName: String
    @State var lastName: String
    @State var imageUrl: String
    @State var username: String
    @EnvironmentObject var user: ApplicationUser
    @Binding var isLogin: Bool
    @State var isCurrnetProfile: Bool

    var body: some View {
        VStack {
                if isCurrnetProfile {
                    HStack {
                    Button(action: {
                        TokenManager.shared.clearTokens()
                        user.loginStatus = ""
                        isLogin = false
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    Spacer()
                    NavigationLink(destination: NotificationsScreen()) {
                        Image(systemName: "bell.fill")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.yellow)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                    .padding(.horizontal)
            }

            AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .frame(width: 80, height: 80)
                                .background(Color.gray)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                        } placeholder: {
                            ProgressView()
                        }

            Text(firstName)
                .font(AppFonts.headlineFont)
                .foregroundColor(Color.black)

            Text(lastName)
                .font(AppFonts.headlineFont)
                .foregroundColor(Color.black)

            Text("@"+username)
                .font(AppFonts.bodyFont)
                .foregroundColor(Color.blue)
                .padding(.bottom, 20)

            if isCurrnetProfile {
                NavigationLink(destination: ProfileEditScreen()) {
                    HStack {
                        Text("Редактировать")
                        Image(systemName: "pencil")
                    }
                    .padding(.all, 8)
                    .background(Color.orange)
                    .cornerRadius(12)
                    .foregroundColor(.white)
                }
                .padding(.bottom, 20)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}

struct HeaderProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let firstName = "Andrey"
        let lastName = "Ryabokon"
        let imageUrl = "http://localhost:5069/api/Image/omvsqnfg.fom.jpg"
        let username = "andrey"
        let isLogin = Binding.constant(true)
        HeaderProfileView(firstName: firstName, lastName: lastName, imageUrl: imageUrl, username: username, isLogin: isLogin, isCurrnetProfile: true)
            .environmentObject(ApplicationUser()) // Добавьте необходимые зависимости
    }
}
