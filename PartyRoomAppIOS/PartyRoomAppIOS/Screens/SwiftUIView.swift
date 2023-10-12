import SwiftUI

struct SwiftUIView: View {
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
            formatter.locale = Locale(identifier: "ru") // Установка локализации на русский
            return formatter
        }()

        let startDateString = "2023-10-04T19:00:26.542"
        let finishDateString = "2023-10-05T19:00:26.542"

        var body: some View {
            VStack {
                Text("Start Date: \(formattedDate(dateString: startDateString))")
                Text("Finish Date: \(formattedDate(dateString: finishDateString))")
            }
        }

        func formattedDate(dateString: String) -> String {
            if let date = dateFormatter.date(from: dateString) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "dd.MM.yyyy HH:mm"
                return outputFormatter.string(from: date)
            } else {
                return "Invalid Date"
            }
        }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
