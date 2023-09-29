import SwiftUI

struct HeaderProfileView: View {
    @State var firstName: String
    @State var lastName: String
    @State var imageUrl: String
    @State var email: String
    @EnvironmentObject var user: ApplicationUser
    @Binding var isLogin: Bool

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    TokenManager.shared.clearTokens()
                    user.loginStatus = ""
                    isLogin = false
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Spacer()
               
                    NavigationLink(destination:NotificationsScreen()){
                        Image(systemName: "bell.fill")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.yellow)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
            }

            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .background(Color.gray)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }

            HStack {
                Text(firstName).font(.headline)
                Text(lastName).font(.headline)
            }
            Text(email)
                .foregroundColor(Color.blue)
            NavigationLink(destination:ProfileEditView()){
                            HStack{
                                Text("Редактировать")
                                Image(systemName: "pencil")
                            }
                            .padding(.all, 8)
                            .background(Color.orange)
                            .cornerRadius(12)
                            .foregroundColor(Color.white)
                        }
        }
        .padding(22)
        .frame(maxWidth: .infinity)
        
    }
}


struct HeaderProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let firstName = "Andrey"
        let lastName = "Ryabokon"
        let imageUrl = "http://localhost:5069/api/Image/omvsqnfg.fom.jpg"
        let email = "user@example.com"
        let isLogin = Binding.constant(true)
        HeaderProfileView(firstName: firstName, lastName: lastName,imageUrl: imageUrl,email: email,isLogin: isLogin)
    }
}
