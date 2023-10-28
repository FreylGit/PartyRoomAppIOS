import Foundation

public class ProfileEditViewModel: ObservableObject {
    @Published var bioText = ""
    @Published var tags : [Tag] = []
    @Published  var goodTag:[Tag] = []
    @Published var beadTag:[Tag] = []
    @Published var newTag:[Tag] = []
    init(bioText:String) {
        self.bioText = bioText
    }
    init(){
        
    }
}
