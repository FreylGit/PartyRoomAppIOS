import SwiftUI

struct RegistrationScreen: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var userName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var password = ""

    var body: some View {
        
            VStack {
                Text("Регистрация")
                    .font(.largeTitle)
                    

                TextField("Имя", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.top, .leading, .trailing])

                TextField("Фамилия", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.top, .leading, .trailing])

                TextField("Имя пользователя", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.top, .leading, .trailing])

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .padding([.top, .leading, .trailing])

                TextField("Номер телефона", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
                    .padding([.top, .leading, .trailing])

                SecureField("Пароль", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                /*Button(action: {
                    sendRegistration()
                }) {*/
                NavigationLink(destination: RegistrationProfileDetailsScreen()){
                    Text("Далее")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                
                    
                //}
            }
            .padding()
        }
       
    }
    
    //TODO: Работает, не забыть потом вызвать
    func sendRegistration(){
        let fn = "Andrey"
        let ln = "Ryabokon"
        let un = "testUserName"
        let em = "ryabokon_01@bk.ry"
        let p = "1321312321"
        let pas = "Qdqdq!cew41412Fwf"
        let registrationModel = AccountRegistrationModel(firstName: fn, lastName: ln, userName: un, email: em, phoneNumber: p, password: pas)
        NetworkBase().registration(model: registrationModel){ result in
            switch result {
            case .success(let jwtAccessModel):
                print("Регистрация успешна \(jwtAccessModel)")
                
            case .failure(let error):
                // Обработка ошибки
                print("Ошибка входа: \(error)")
            }
        }
    }
}

struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationScreen()
    }
}
