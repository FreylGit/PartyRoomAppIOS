import SwiftUI
import Alamofire

struct ProfileScreen: View {
    @State var profile: ProfileModel? = nil
    @State var isLogin: Bool = true
    @EnvironmentObject var user: ApplicationUser
    @State  private var loginStatus = "accessToken"
    @State var isCurrnetProfile: Bool = true
    @State var username: String? = nil
    var body: some View {
        if isLogin{
            NavigationView {
                ScrollView {
                    VStack {
                        if let firstName = profile?.firtsName, let lastName = profile?.lastName, let imageUrl = profile?.details.imagePath, let email = profile?.userName {
                            HeaderProfileView(firstName: firstName, lastName: lastName, imageUrl: imageUrl, email: email, isLogin: $isLogin,isCurrnetProfile: isCurrnetProfile)
                            Rectangle()
                                    .frame(height: 2) 
                                    .foregroundColor(Color.gray)
                        }
                        if let about = profile?.details.about {
                            BodyProfileView(about: about)
                                .padding()
                                .shadow(radius: 5)
                        }
                        if let tags = profile?.tags {
                            TagProfileView(tags: tags.filter { tag in
                                return tag.isLike
                            },isGood: true,isCurrnetProfile: isCurrnetProfile)
                            .padding()
                            .shadow(radius: 5)
                            TagProfileView(tags: tags.filter { tag in
                                return !tag.isLike
                            },isGood: false,isCurrnetProfile: isCurrnetProfile)
                            .padding()
                            .shadow(radius: 5)
                        }
                        
                    }
                }
                .onAppear(perform: {
                    if isCurrnetProfile {
                        loadCurrentProfile()
                    } else {
                        loadProfile()
                    }
                })
            }
        }else {
            LoginScreen()
        }
    }
    
    func loadCurrentProfile() {
        NetworkBase().requestAndParse(url: "http://localhost:5069/api/Profile", method: .get, type: ProfileModel.self) { result in
            switch result {
            case .success(let loadedProfile):
                self.profile = loadedProfile
            case .failure(let error):
                print("Error loading profile \(error)")
            }
        }
    }
    func loadProfile(){
        if let username = username{

            NetworkBase().requestAndParse(url: "http://localhost:5069/api/Profile/"+username, method: .get, type: ProfileModel.self) { result in
                switch result {
                case .success(let loadedProfile):
                    self.profile = loadedProfile
                case .failure(let error):
                    print("Error loading profile \(error)")
                }
            }
        }
        
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleProfile = ProfileModel(
            id: "1",
            firtsName: "Иван",
            lastName: "Иванов",
            userName: "Username",
            email: "user@example.com",
            phoneNumber: "1234567890",
            details: Details(about: "Описание о себе", imagePath: "http://localhost:5069/api/Image/omvsqnfg.fom.jpg"),
            tags: [Tag(id: "1", name: "tag1", important: true,isLike: false),Tag(id: "2", name: "Спорт", important: true,isLike: true),Tag(id: "3", name: "Искусство", important: true,isLike: false),Tag(id: "4", name: "12у1", important: true,isLike: true)]
        )
        ProfileScreen(profile: sampleProfile)
    }
}
