import SwiftUI

struct ItemRoomView: View {
    let room: RoomsModelElement
    var body: some View {
        VStack(alignment: .leading) {
            Text(room.name)
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom,10)
              
            Text("Тип: \(room.type)")
            Text("Бюджет: \(room.price) ₽")
        }
        .padding(.all)
        .background(Color(room.isStarted ? .green : .orange))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct ItemRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRoomView(room: RoomsModelElement(id: "1", name: "Sample Room", type: "Sample Type", price: 100, isStarted: true, startDate: "2023-09-17", finishDate: "2023-09-18"))
    }
}
