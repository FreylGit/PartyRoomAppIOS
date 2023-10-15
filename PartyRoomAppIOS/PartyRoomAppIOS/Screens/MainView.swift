import SwiftUI

struct MainView: View {

    var body: some View {
        
        if let token = TokenManager.shared.getRefreshToken(){
            if token == "refreshToken"{
                LoginScreen()
            }
            else{
                TabView{
                        ProfileMainScreen(isLogin: true)
                            .tabItem{
                                Label("Account",systemImage: "person.circle.fill")
                            }
                        RoomsScreen()
                            .tabItem{
                                Label("Content",systemImage: "house.fill")
                            }
                        
                        TestSelectView()
                            .tabItem {
                                Label("Test",systemImage: "pencil")
                            }
                    }
                .navigationBarBackButtonHidden(true)
                .background(Color.clear)
                .accentColor(.yellow)
                .onAppear {
                    UITabBar.appearance().unselectedItemTintColor = .gray
                }
                }
            
            }
            
             
        }
        
       // .preferredColorScheme(.dark)
       
    }


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
