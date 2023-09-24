import SwiftUI

struct MainView: View {
    @StateObject  var user = ApplicationUser()
    var body: some View {
           TabView{
               LoginScreen()
                   .tabItem{
                       Label("Account",systemImage: "person.circle.fill")
                   }
                   .environmentObject(user) // Внедрение user в AccountView
               RoomsView()
                   .tabItem{
                       Label("Content",systemImage: "house.fill")
                   }
                   .environmentObject(user) // Внедрение user в ContentView
               ProfileScreen()
                   .tabItem{
                       Label("Content",systemImage: "house.fill")
                   }
                  
           }
       }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
