//
//  AeonService.swift
//  AeonTask
//
//  Created by Kirill Anisimov on 22.02.2021.
//

import Foundation
import Alamofire

class AeonService {
    
    // base URL of service
    let baseUrl = "http://82.202.204.94/api/"
    let appKey = "12345"
    let version = "1"
    
    let token = UserDefaults.standard.value(forKey: "token") ?? ""
    
    
    // MARK: - SignIn method
    func signIn(login: String, password: String, completion: @escaping (ResponseLogin) -> Void ) {
        
        let path = "login"
        let parameters: Parameters = [
            "login": login,
            "password" : password
        ]
        let headers = HTTPHeaders(["app-key" : "\(appKey)",
                                   "v" : "\(version)",
                                   "content-type": "multipart/form-data"])
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, to: self.baseUrl + path, usingThreshold: UInt64.init(), method: .post, headers: headers)
        .responseData(completionHandler: { response in
            DispatchQueue.global().async {
                guard let data = response.value else { return }
                do {
                    let result = try JSONDecoder().decode(ResponseLogin.self, from: data)
                    DispatchQueue.main.async {
                        completion(result)
                        print(result)
                    }
                } catch {
                   print(error)
                }
            }
        }
    )}
    
    
    // MARK: - Request transactions method
    func getTransactionDetails(completion: @escaping (ResponseResult) -> Void ) {
        let path = "payments"
        let headers = HTTPHeaders(["app-key" : "\(appKey)",
                                   "v" : "\(version)"
        ])
        let parameters: Parameters = [
            "token": token
        ]

        AF.request(self.baseUrl + path, method: .get, parameters: parameters, headers: headers).responseData { response in
            
            DispatchQueue.global().async {
                guard let data = response.value else { return }
                do {
                    let result = try JSONDecoder().decode(ResponseResult.self, from: data)

                    DispatchQueue.main.async {
                        completion(result)
                        print(result)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}


