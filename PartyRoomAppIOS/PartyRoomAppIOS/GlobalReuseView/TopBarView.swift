import SwiftUI

struct TopBarView: View {
    @State var name :String
    var body: some View {
        VStack{
            VStack{
                VStack{
                    HStack{
                        Spacer()
                    }
                    Text(name)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.bottom,24)
                }
            }
        }
        .background(Color("Color"))
        .navigationBarItems(trailing:
                                Button(action: {
          
        }) {
            Image(systemName: "gearshape")
                .imageScale(.large)
                .foregroundColor(.yellow)
            
        }
        )
 
        
    }
}

#Preview {
    TopBarView(name: "Название")
}
