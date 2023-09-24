import SwiftUI

struct ProfileScreen: View {
    @State var profile: ProfileModel? = nil
    @State var isLogin: Bool = true
    var body: some View {
        if isLogin{
            NavigationView {
                ScrollView {
                    VStack {
                        if let firstName = profile?.firtsName, let lastName = profile?.lastName, let imageUrl = profile?.details.imagePath, let email = profile?.email {
                            HeaderProfileView(firstName: firstName, lastName: lastName, imageUrl: imageUrl, email: email, isLogin: $isLogin).background(Color.white)
                        }
                        if let about = profile?.details.about {
                            BodyProfileView(about: about).padding()
                        }
                        if let tags = profile?.tags {
                            HStack {
                                TagProfileView(tags: tags).padding()
                            }
                        }
                        Spacer().background(Color.gray.opacity(0.5))
                    }.background(Color.gray.opacity(0.5))
                }
                .onAppear(perform: loadProfile)
                
            }
        }else {
            LoginScreen()
        }
        
    }
    
    func loadProfile() {
        NetworkBase().requestAndParse(url: "http://localhost:5069/api/Profile", method: .get, type: ProfileModel.self) { result in
            switch result {
            case .success(let loadedProfile):
                self.profile = loadedProfile
            case .failure(let error):
                print("Error loading profile \(error)")
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
            tags: [Tag(id: "1", name: "tag1", important: true),Tag(id: "2", name: "tag2", important: true),Tag(id: "3", name: "tag1", important: true)]
        )
        ProfileScreen(profile: sampleProfile)
    }
}
