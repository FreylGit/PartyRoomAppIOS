import SwiftUI

struct ItemRoomView: View {
    let room: RoomsModelElement
    var body: some View {
        HStack(){
            VStack(alignment: .leading){
                Text(room.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(1)
                Text("Участников: \(room.quantityParticipant)")
            }
            .foregroundColor(.black)
            Spacer()
            if room.isStarted{
                VStack{
                    Text("Конец")
                    Text(formattedDate(dateString:room.finishDate))
                        
                }
                .font(.caption)
                .foregroundColor(.black)
                .padding(7)
                .background(
                    Color.red
                        .opacity(0.9)
                        .blur(radius: 6)
                )
                .border(Color.green)
                .cornerRadius(12)
            }else{
                VStack{
                    Text("Начало")
                    Text(formattedDate(dateString:room.startDate))
                        
                }
                .font(.caption)
                .foregroundColor(.black)
                .padding(7)
                .background(
                    Color.green
                        .opacity(0.6)
                        .blur(radius: 6)
                )
                .border(Color.green)
                .cornerRadius(12)
            }
           
            
            
            if room.type == "Закрыто"{
                Image(systemName: "lock.fill")
                    .imageScale(.large)
                    .foregroundColor(.black)
            }else{
                Image(systemName: "lock.open.fill")
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(room.isStarted ? .systemGreen : .systemOrange ))
        .cornerRadius(10)
        .foregroundColor(.white)
    }
    
    let dateFormatter: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
         formatter.locale = Locale(identifier: "ru")
         return formatter
     }()
    
    func formattedDate(dateString: String) -> String {
        var formattedDateString = dateString

            // Check if the date string contains milliseconds
            if let dotRange = dateString.range(of: ".", options: .literal) {
                // Remove the milliseconds part
                formattedDateString = String(dateString[..<dotRange.lowerBound])
            }

            if let date = dateFormatter.date(from: formattedDateString) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "dd.MM.yyyy \n HH:mm"
                return outputFormatter.string(from: date)
            } else {
                return "Invalid Date"
            }
       }
}

struct ItemRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRoomView(room: RoomsModelElement(id: "1", name: "Sample Room", type: "w", price: 100,quantityParticipant: 2, isStarted: true, startDate: "2023-10-04T19:00:26.22", finishDate: "2023-10-02T00:00:00"))
    }
}
