import SwiftUI
import Contacts

struct LoginScreen: View {
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject var user: ApplicationUser
    @State private var isRegistrationActive = false
    
    var body: some View {
        if user.loginStatus != "" && user.loginStatus != nil{
                ProfileScreen(viewModel: ProfileViewModel(isLogin: true, isCurrentProfile: true)).frame(maxWidth: .infinity)
            
            } else {NavigationView {
                VStack {
                    
                    Text("Вход")
                    VStack{
                        TextField("Email", text: $username)
                            .padding([.top, .leading, .trailing])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Пароль", text: $password)
                            .padding(.all)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding([.top, .leading, .trailing])
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
                }
                .padding()
                .frame(maxWidth: .infinity)
                
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
                // Обработка ошибки
                print("Ошибка входа: \(error)")
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    @State static private var loginStatus = "accessToken" // Задайте начальное значение loginStatus

    static var previews: some View {
        LoginScreen()
    }
}
