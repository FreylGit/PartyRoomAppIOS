import SwiftUI

@main
struct PartyRoomAppIOSApp: App {
    @ObservedObject var user = ApplicationUser()
    var body: some Scene {
        WindowGroup {
            if user.isLogin{
                IsLoginMainView()
                    .environmentObject(user)
                    .background(Color.red)
                    //.background(GradientBackgroundView())
                    .preferredColorScheme(.dark)
            }else{
                LoginScreen()
                    .environmentObject(user)
                    .background(GradientBackgroundView()) 
                    .preferredColorScheme(.dark)
            }
        }
        
        
    }
    
}


