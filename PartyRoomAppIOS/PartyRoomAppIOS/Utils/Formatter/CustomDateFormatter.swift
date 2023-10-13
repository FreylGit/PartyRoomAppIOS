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
