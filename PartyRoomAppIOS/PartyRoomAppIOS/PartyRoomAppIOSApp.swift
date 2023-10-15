import SwiftUI

@main
struct PartyRoomAppIOSApp: App {
    var body: some Scene {
        WindowGroup {
            if let token = TokenManager.shared.getRefreshToken(){
                if token == "refreshToken"{
                    MainView()
                        .background(GradientBackgroundView())
                }else{
                    IsLoginMainView()
                }
            }
        }
        
    }
}


