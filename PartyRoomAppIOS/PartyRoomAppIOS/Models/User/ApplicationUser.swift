import Foundation

class ApplicationUser: ObservableObject {
    @Published var jwtAccess: JwtAccessModel?
    @Published var refreshToken: String?
    @Published var loginStatus: String = TokenManager.shared.getAccessToken() ?? ""

    func setTokens(jwtAccess: JwtAccessModel, refreshToken: String) {
        self.jwtAccess = jwtAccess
        self.refreshToken = refreshToken
    }
    
    func clearTokens() {
        jwtAccess = nil
        refreshToken = nil
    }
}
