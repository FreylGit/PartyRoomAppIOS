import SwiftUI

struct BodyProfileView : View{
    @State var about:String
    var body: some View{
        VStack(alignment: .leading) {
            HStack {
                Text("О Себе")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            
            Text(about)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct BodyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        BodyProfileView(about: "Описание о себе")
    }
}
