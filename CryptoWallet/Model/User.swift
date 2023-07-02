//
//  User.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/27.
//

import Foundation

public class User: Codable {
    
    public struct Options: Codable {
        /// A unique identifier for this user
        public let uuid: String
        /// have one or more wallets
        public var wallets: [Wallet] = []
        /// Mobile phone passcode- 6 digits
        public var passcode: String?
        /// Face ID or touch ID
        public var biometric: String?
        /// email
        public var mail: String?
        /// phone number
        public var phoneNumber: String?
    }
    
    private let options: Options
    
    public var uuid: String {
        return options.uuid
    }
    
    public var wallets: [Wallet] {
        return options.wallets
    }
    
    public var passcode: String? {
        return options.passcode
    }
    
    public var biometric: String? {
        return options.biometric
    }
    
    public var mail: String? {
        return options.mail
    }
    
    public var phoneNumber: String? {
        return options.phoneNumber
    }
    
    private init(_ options: Options) {
        self.options = options
    }
    
    public convenience init(wallets: [Wallet]) {
        let uuid: String
        if let _uuid = AppUserDefaults.uuid, !_uuid.isEmpty {
            uuid = _uuid
        } else {
            uuid = UUID().uuidString
            AppUserDefaults.uuid = uuid
        }
        var options = Options(uuid: uuid)
        options.wallets = wallets
        self.init(options)
    }
    
    public func passcode(_ passcode: String) -> User {
        var options = self.options
        options.passcode = passcode
        return User(options)
    }
    
    public func biometric(_ biometric: String) -> User {
        var options = self.options
        options.biometric = biometric
        return User(options)
    }
    
    public func phoneNumber(_ phoneNumber: String) -> User {
        var options = self.options
        options.phoneNumber = phoneNumber
        return User(options)
    }
    
    public func mail(_ mail: String) -> User {
        var options = self.options
        options.mail = mail
        return User(options)
    }
}
