import SwiftUI
import Contacts

struct LoginScreen: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isRegistrationActive = false
    @State private var isLoggedin = false
    var body: some View {
            NavigationView {
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
                    .background(NavigationLink("", destination: IsLoginMainView(), isActive: $isLoggedin))
                   
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(GradientBackgroundView())
            }
            .navigationBarBackButtonHidden(true)
        
        
    }
    func singIn(){
        let email = "user@example.com"
        let password = "Qdqdq!cew41412Fwf"
        
        NetworkBase().login(email: email, password: password) { result in
            switch result {
            case .success(let jwtAccessModel):
                //user.loginStatus = jwtAccessModel.token
                isLoggedin = true
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
