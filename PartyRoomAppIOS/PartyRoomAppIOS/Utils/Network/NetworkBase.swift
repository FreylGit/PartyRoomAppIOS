import Foundation
import SwiftyJSON
import Alamofire

enum NetworkError: Error {
    case responseValidationFailed(reason: String)
    case responseSerializationFailed(reason: String)
    case decodingFailed
    case unknownError
}

class NetworkBase {
    public var atoken = "nil"
    public func requestAndParse<T: Decodable>(
        url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        type: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        if let storedRefreshToken = TokenManager.shared.getRefreshToken() {
            print(storedRefreshToken)
        }
        if let storedAccessToken = TokenManager.shared.getAccessToken(){
            atoken = "Bearer " + storedAccessToken
        }
        let headersr: HTTPHeaders = ["Authorization": atoken]
        AF.request(url, method: method, parameters: parameters, headers: headersr)
            .validate()
            .responseData { response in
                switch response.result {
                case .failure(let error):
                    let networkError: NetworkError
                    switch error {
                    case let afError as AFError:
                        networkError = .responseValidationFailed(reason: afError.localizedDescription)
                    default:
                        networkError = .unknownError
                    }
                    completion(.failure(networkError))
                case .success(let value):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: value)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(.decodingFailed))
                    }
                }
            }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<JwtAccessModel, NetworkError>) -> Void) {
        let loginURL = "http://localhost:5069/api/Account/Login"
        
        let parameters = AccountLogin(email: email, password: password)
        
        AF.request(loginURL, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .failure(let error):
                    let networkError: NetworkError
                    switch error {
                    case let afError as AFError:
                        networkError = .responseValidationFailed(reason: afError.localizedDescription)
                    default:
                        networkError = .unknownError
                    }
                    completion(.failure(networkError))
                case .success(let value):
                    do {
                        let jwtAccessModel = try JSONDecoder().decode(JwtAccessModel.self, from: value)
                        
                        // Ваш код обработки успешного входа
                        if let httpResponse = response.response {
                            if let refreshToken = self.extractRefreshToken(from: httpResponse) {
                                TokenManager.shared.saveTokens(accessToken: jwtAccessModel.token, refreshToken: refreshToken)
                            } else {
                                print("Refresh Token not found in cookies.")
                            }
                        }
                        
                        completion(.success(jwtAccessModel))
                    } catch {
                        completion(.failure(.decodingFailed))
                    }
                }
            }
    }
    
    func registration(model:AccountRegistrationModel,completion: @escaping (Result<JwtAccessModel, NetworkError>)-> Void){
        let loginURL = "http://localhost:5069/api/Account/Registration"
        
        let parameters = model
        
        AF.request(loginURL, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .failure(let error):
                    let networkError: NetworkError
                    switch error {
                    case let afError as AFError:
                        networkError = .responseValidationFailed(reason: afError.localizedDescription)
                    default:
                        networkError = .unknownError
                    }
                    completion(.failure(networkError))
                case .success(let value):
                    do {
                        let jwtAccessModel = try JSONDecoder().decode(JwtAccessModel.self, from: value)
                        
                        // Ваш код обработки успешного входа
                        if let httpResponse = response.response {
                            if let refreshToken = self.extractRefreshToken(from: httpResponse) {
                                TokenManager.shared.saveTokens(accessToken: jwtAccessModel.token, refreshToken: refreshToken)
                            } else {
                                print("Refresh Token not found in cookies.")
                            }
                        }
                        
                        completion(.success(jwtAccessModel))
                    } catch {
                        completion(.failure(.decodingFailed))
                    }
                }
            }
    }
    
    
    private func extractRefreshToken(from response: HTTPURLResponse) -> String? {
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: response.allHeaderFields as! [String: String], for: response.url!)
        
        if !cookies.isEmpty {
            if let refreshTokenCookie = cookies.first(where: { $0.name == "refreshToken" }) {
                print("refresh\n"+refreshTokenCookie.value)
                let refreshToken = refreshTokenCookie.value
                return refreshTokenCookie.value
            }
        }
        
        return nil
    }
    
}
