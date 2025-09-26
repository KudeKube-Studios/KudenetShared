//
//  File.swift
//  KudenetShared
//
//  Created by Kuutti Taavitsainen on 25.5.2025.
//

import Foundation

public enum ValidationField: Codable {
    case all
    case handle
    case username
    case email
    case password
    case title
    case birthday
}

public enum ValidationStatus: Codable {
    case success
    case undefinedError
    case empty
    case tooShort
    case tooLong
    case formatInvalid
    case alreadyExists
    case passwordEmpty
    case tooYoung
}

public struct ValidationResult: Codable {
    public var successful: Bool
    public var fields: [ValidationField]
    public var statuses: [ValidationStatus]
    
    public init() {
        successful = false
        fields = []
        statuses = []
    }
    
    public mutating func addError(field: ValidationField, status: ValidationStatus) {
        fields.append(field)
        statuses.append(status)
    }
}

public func RegisterationCheck(email: String,
                               password: String,
                               birthday: Date,
                               handle: String,
                               username: String) -> ValidationResult {
    var result = ValidationResult()
    
    if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
        result.addError(field: .email, status: .empty)
    }
    if !email.contains("@") || !email.contains(".") {
        result.addError(field: .email, status: .formatInvalid)
    }
    if email.trimmingCharacters(in: .whitespacesAndNewlines).count < 5 {
        result.addError(field: .email, status: .tooShort)
    }
    
    if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
        result.addError(field: .password, status: .empty)
    }
    if password.trimmingCharacters(in: .whitespacesAndNewlines).count < 6 {
        result.addError(field: .password, status: .tooShort)
    }
    
    if birthday.timeIntervalSinceNow < 409968000 {
        result.addError(field: .birthday, status: .tooYoung)
    }
    
    if result.fields.isEmpty {
        result.successful = true
    }
    
    return result
}

public func PostCheck(title: String) -> ValidationResult {
    var result = ValidationResult()
    
    if title.isEmpty {
        result.addError(field: .title, status: .empty)
    }
    if title.trimmingCharacters(in: .whitespacesAndNewlines).count > 200 {
        result.addError(field: .title, status: .tooLong)
    }
    
    if result.fields.isEmpty {
        result.successful = true
    }
    
    return result
}
