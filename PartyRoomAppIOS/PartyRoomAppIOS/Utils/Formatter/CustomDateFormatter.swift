import Foundation

class CustomDateFormatter{
    static let shared = CustomDateFormatter()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "ru")
        return formatter
    }()
    
    func formattedDate(dateString: String) -> String {
        var formattedDateString = dateString
        
        if let dotRange = dateString.range(of: ".", options: .literal) {
            formattedDateString = String(dateString[..<dotRange.lowerBound])
        }
        
        if let date = dateFormatter.date(from: formattedDateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd.MM.yyyy"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
}
