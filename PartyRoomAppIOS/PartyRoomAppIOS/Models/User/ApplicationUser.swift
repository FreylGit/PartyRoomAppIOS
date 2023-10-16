import Foundation

class ApplicationUser: ObservableObject {
    @Published var isLogin =  TokenManager.shared.getRefreshToken() != "refreshToken"
}
