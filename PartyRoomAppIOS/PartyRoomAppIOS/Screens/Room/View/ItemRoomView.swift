import SwiftUI

struct ItemRoomView: View {
    let room: RoomsModelElement
    var body: some View {
        HStack{
            
            VStack(alignment: .leading){
                Text(room.name)
                    .fontWeight(.bold)
                    .padding(.bottom,5)
                HStack{
                    Text("Дата старта:")
                    Text(CustomDateFormatter.shared.formattedDate(dateString:room.finishDate))
                }
                HStack{
                    Text("Учасников:")
                    Text(String(room.quantityParticipant))
                }
            }
            Spacer()
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("Grey"))
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}

struct ItemRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRoomView(room: RoomsModelElement(id: "1", name: "Sample Room", type: "w", price: 100,quantityParticipant: 2, isStarted: true, startDate: "2023-10-04T19:00:26.22", finishDate: "2023-10-02T00:00:00"))
    }
}
