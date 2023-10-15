import SwiftUI

struct IsLoginMainView: View {
    var body: some View {
        TabView{
            ProfileMainScreen()
                .tabItem{
                    Label("Профиль",systemImage: "person.circle.fill")
                }
            RoomsScreen()
                .tabItem{
                    Label("Комнаты",systemImage: "house.fill")
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

#Preview {
    IsLoginMainView()
}
