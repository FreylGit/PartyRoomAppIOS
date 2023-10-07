import Foundation

public class ProfileEditViewModel: ObservableObject {
    @Published var bioText = ""
    
    init(bioText:String) {
        self.bioText = bioText
    }
    init(){
        
    }
}
