import Foundation
import Alamofire

class ProfileViewModel: ObservableObject {
    @Published var profile: ProfileModel?
    @Published var isLogin: Bool = true
    @Published var isCurrentProfile: Bool = true
    @Published var username: String?
    @Published  var goodTag:[Tag] = []
    @Published var beadTag:[Tag] = []
    init(isLogin: Bool,isCurrentProfile: Bool, username: String? = nil) {
        self.isLogin = isLogin
        self.isCurrentProfile = isCurrentProfile
        self.username = username
        
        if let tags = self.profile?.tags {
            self.goodTag = tags.filter { tag in
                return tag.isLike
            }
            self.beadTag  = tags.filter { tag in
                return !tag.isLike
            }
        }
    }
    
    init(){
        
    }
    func toProfileEditViewModel() -> ProfileEditViewModel{
        let model = ProfileEditViewModel()
        if let profile = self.profile{
            model.tags = profile.tags
            model.bioText = profile.details.about
            model.beadTag = self.beadTag
            model.goodTag = self.goodTag
        }
        return model
    }
    
    func loadCurrentProfile() {
        let url = APIClient.shared.profileURL
        NetworkBase().requestAndParse(url: url, method: .get, type: ProfileModel.self) { result in
            switch result {
            case .success(let loadedProfile):
                self.profile = loadedProfile
                if let tags = self.profile?.tags {
                    self.goodTag = tags.filter { tag in
                        return tag.isLike
                    }
                    self.beadTag  = tags.filter { tag in
                        return !tag.isLike
                    }
                }
            case .failure(let error):
                print("Error loading profile \(error)")
            }
        }
    }
    
    func loadProfile() {
        if let username = username {
            let url = URL(string: APIClient.shared.profileURL.absoluteString + "/" + username)
            
            NetworkBase().requestAndParse(url: url!, method: .get, type: ProfileModel.self) { result in
                switch result {
                case .success(let loadedProfile):
                    self.profile = loadedProfile
                    if let tags = self.profile?.tags {
                        self.goodTag = tags.filter { tag in
                            return tag.isLike
                        }
                        self.beadTag  = tags.filter { tag in
                            return !tag.isLike
                        }
                    }
                    
                case .failure(let error):
                    print("Error loading profile \(error)")
                }
            }
        }
    }
    
    func deleteTag(id:String){
        let url = "http://localhost:5069/api/Profile/DeleteTag?tagId="+id
        NetworkBase().sendPostRequest(url: url, method: .delete){result in
            switch result{
            case .success():
                print("delete")
            case .failure(let error):
                print("Error loading profile \(error)")
            }
        }
    }
}
