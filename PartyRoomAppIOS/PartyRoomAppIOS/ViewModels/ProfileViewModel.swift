import Foundation
import Alamofire

class ProfileViewModel: ObservableObject {
    @Published var profile: ProfileModel?
    @Published var isLogin: Bool = true
    @Published var loginStatus: String = "accessToken"
    @Published var isCurrentProfile: Bool = true
    @Published var username: String?
    
    init(isLogin: Bool,isCurrentProfile: Bool, username: String? = nil) {
        self.isLogin = isLogin
        self.isCurrentProfile = isCurrentProfile
        self.username = username
    }
    init(){
        
    }
    func toProfileEditViewModel() -> ProfileEditViewModel{
        let model = ProfileEditViewModel()
        if let about = self.profile?.details.about{
            model.bioText = about
        }
        
        return model
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
    
    func loadProfile() {
        if let username = username {
            NetworkBase().requestAndParse(url: "http://localhost:5069/api/Profile/" + username, method: .get, type: ProfileModel.self) { result in
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
