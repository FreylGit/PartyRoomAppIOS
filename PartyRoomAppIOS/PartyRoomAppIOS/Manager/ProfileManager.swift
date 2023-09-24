import Foundation
import KeychainSwift

class TokenManager {
    static let shared = TokenManager()
    private init() {}
    private let keychain = KeychainSwift()
    
    private let accessTokenKey = ""
    private let refreshTokenKey = ""
    
    func saveTokens(accessToken: String, refreshToken: String) {
        clearTokens()
        keychain.set(accessToken, forKey: accessTokenKey)
        keychain.set(refreshToken, forKey: refreshTokenKey)
    }
    
    func saveRefresh(refreshToken:String){
        keychain.set(refreshToken, forKey: refreshTokenKey)
    }
    
    func saveAccess(accessToken: String){
        keychain.set(accessToken, forKey: accessTokenKey)
    }
    
    func getAccessToken() -> String? {
        return keychain.get(accessTokenKey)
    }
    
    func getRefreshToken() -> String? {
        return keychain.get(refreshTokenKey)
    }
    
    func clearTokens() {
        keychain.delete(accessTokenKey)
        keychain.delete(refreshTokenKey)
    }
}

