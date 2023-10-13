import SwiftUI
import Contacts

struct LoginScreen: View {
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject var user: ApplicationUser
    @State private var isRegistrationActive = false
    
    var body: some View {
        if user.loginStatus != "" && user.loginStatus != nil{

            ProfileMainScreen(isLogin: true)
            
            } else {NavigationView {
                VStack {
                    Spacer()
                    Text("Вход")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    VStack{
                        CustomTextFieldView(inputText: $username, label: "Email")
                        CustomTextFieldView(inputText: $password, label: "Пароль")
                    }
                    .padding(10)
                    NavigationLink(
                        destination: RegistrationScreen(),
                        isActive: $isRegistrationActive,
                        label: {
                            Text("Регистрация").foregroundColor(Color.blue)
                        }
                    )
                    Button(action: {
                        singIn()
                    }) {
                        Text("Войти")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(GradientBackgroundView())
            }
        }
    }
    
    func singIn(){
        let email = "user@example.com"
        let password = "Qdqdq!cew41412Fwf"
        
        NetworkBase().login(email: email, password: password) { result in
            switch result {
            case .success(let jwtAccessModel):
                user.loginStatus = jwtAccessModel.token
                print("Вход выполнен успешно: \(jwtAccessModel)")
            case .failure(let error):
                print("Ошибка входа: \(error)")
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    @State static private var loginStatus = "accessToken"

    static var previews: some View {
        LoginScreen().environmentObject(ApplicationUser())
    }
}
