//
//  ResponseLogin.swift
//  AeonTask
//
//  Created by Kirill Anisimov on 22.02.2021.
//

import Foundation

class ResponseLogin: Codable {
    let success: String
    let response: Token?
    let error: Error?
    
    init(success: String, token: Token?, error: Error?) {
        self.success = success
        self.response = token
        self.error = error
    }
}

// MARK: - Response
class Token: Codable {
    let token: String

    init(token: String) {
        self.token = token
    }
}

// MARK: - Error
class Error: Codable {
    let errorCode: Int
    let errorMsg: String

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMsg = "error_msg"
    }

    init(errorCode: Int, errorMsg: String) {
        self.errorCode = errorCode
        self.errorMsg = errorMsg
    }
}
