//
//  KeychainService.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/27.
//

import Foundation
import KeychainAccess

final public class KeychainService {
    
    private enum Constants {
        static let domain = "io.ken.wallet.app"
        static let userDataKey = "io.ken.wallet.app.user.data"
    }
    
    static let shared = KeychainService()
    private let keychain: Keychain
    
    private init() {
        let keychain = Keychain(server: Constants.domain, protocolType: .daap)
            .accessibility(.afterFirstUnlockThisDeviceOnly)
            .synchronizable(true)
        self.keychain = keychain
            
    }
    
    /// Save `User` data in Keychain
    /// - Parameters:
    /// - warning: The UUID is added to prevent when the app is deleted, but the data saved in the keychain is not deleted, and the old data is taken out when fetching
    ///   - userUUID:  User`s UUID
    ///   - userData:  User`s data
    public func store(userUUID: String, userData: String) {
        // Try to delete the old data first, then save
        do {
            try remove(userUUID: userUUID)
        } catch let error {
            print("remove keychain user data error=\(error.localizedDescription)")
        }
        keychain[userUUID + Constants.userDataKey] = userData
    }
    
    /// obtaining `User` data
    /// - Parameter userUUID: `User` uuid
    /// - Returns: `User` data
    public func obtaining(userUUID: String) throws -> String {
        guard let userData = keychain[userUUID + Constants.userDataKey] else {
            throw SSError.WalletError.obtainingUserDataFromKeychainError
        }
        return userData
    }
    
    public func remove(userUUID: String) throws {
        try keychain.remove(userUUID + Constants.userDataKey)
    }
    
    public func cleanup() throws {
        try keychain.removeAll()
    }
}
