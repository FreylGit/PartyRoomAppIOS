import SwiftUI

@main
struct PartyRoomAppIOSApp: App {
    @ObservedObject var user = ApplicationUser()
    var body: some Scene {
        WindowGroup {
            if user.isLogin{
                IsLoginMainView()
                    .environmentObject(user)
            }else{
                LoginScreen()
                    .environmentObject(user)
            }
            /*if let token = TokenManager.shared.getRefreshToken(){
                if token == "refreshToken"{
                    MainView()
                        .background(GradientBackgroundView())
                }else{
                    IsLoginMainView()
                }
            }*/
        }
        
    }
}


