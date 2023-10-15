import Foundation

class APIClient {
    static let shared = APIClient()
    
    let baseURL = "http://localhost:5069/api"
    
    var profileURL: URL {
        return URL(string: baseURL + "/Profile")!
    }
    
    var roomURL: URL {
        return URL(string: baseURL + "/Room")!
    }
    
    var notificationURL: URL {
        return URL(string: baseURL + "/Notifications")!
    }
}
