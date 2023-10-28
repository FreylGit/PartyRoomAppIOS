import SwiftUI

struct IsLoginMainView: View {
    @State var selectTab = "1"
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $selectTab){
                
                RoomsScreen()
                    .tag("1")
                ProfileMainScreen()
                    .tag("2")
            }
            .accentColor(.yellow)
            .onAppear {
                UITabBar.appearance().unselectedItemTintColor = .gray
            }
            HStack{
                Spacer()
                Button{
                    selectTab = "1"
                }label: {
                    VStack{                        
                        Image(systemName:"house.fill")
                            .font(.system(size: 22))
                        Text("Комнаты")
                            .font(.system(size: 15))
                    }
                }
                .foregroundColor( selectTab=="1" ? .yellow:.gray)
                Spacer()
                Button{
                    selectTab = "2"
                }label: {
                    VStack{
                        Image(systemName:"person.circle.fill")
                            .font(.system(size: 22))
                        Text("Профиль")
                            .font(.system(size: 15))
                    }
                }
                .foregroundColor(selectTab=="2" ? .yellow:.gray )
                Spacer()
            }
            .padding(.top,10)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(Color(UIColor(red: 0.08, green: 0.08, blue: 0.09, alpha: 1.00)))
            
        }
    }
}

#Preview {
    IsLoginMainView()
}
