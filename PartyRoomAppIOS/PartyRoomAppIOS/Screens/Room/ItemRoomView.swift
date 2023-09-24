import SwiftUI

struct ItemRoomView: View {
    let room: RoomsModelElement // Объявляем переменную room
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(room.name)")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            Text("Type: \(room.type)")
            Text("Price: \(room.price)")
            Text("Запущено: \(room.isStarted ? "Yes" : "No")")
        }.padding(.all)
            .background(Color(room.isStarted ? .green : .orange))
            .cornerRadius(10)
            
        
    }
}

struct ItemRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRoomView(room: RoomsModelElement(id: "1", name: "Sample Room", type: "Sample Type", price: 100, isStarted: true, startDate: "2023-09-17", finishDate: "2023-09-18"))
    }
}
