//
//  ResponseResult.swift
//  AeonTask
//
//  Created by Kirill Anisimov on 22.02.2021.
//

import Foundation

// MARK: - Response
class ResponseResult: Codable {
    let success: String
    let response: [Transaction]

    init(success: String, response: [Transaction]) {
        self.success = success
        self.response = response
    }
}

// MARK: - TransactionElement
class Transaction: Codable {
    let desc: String
    let amount: Amount
    let currency: String?
    let created: Int

    init(desc: String, amount: Amount, currency: String?, created: Int) {
        self.desc = desc
        self.amount = amount
        self.currency = currency
        self.created = created
    }
}

enum Amount: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Amount.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "неверный тип"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

extension Amount {
    var stringValue: String {
        switch self {
            case .double(let value): return String(value)
            case .string(let value): return value
        }
    }
}
