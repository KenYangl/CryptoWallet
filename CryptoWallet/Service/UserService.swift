//
//  UserService.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/27.
//

import Foundation
import Combine

public final class UserService {
    static let shared = UserService()
    
    var uuid: String? {
        guard let uuid = AppUserDefaults.uuid, !uuid.isEmpty else {
            return nil
        }
        return uuid
    }
    
    var hasWallet: Bool {
        return uuid != nil
    }
    
    var wallets: [Wallet] {
        let user = obtainingUser()
        return user?.wallets ?? []
    }
    
    public func store(user: User) {
        guard let originalDataString = flatMapUserToString(user) else {
            assertionFailure("User transform String failure")
            return
        }
        guard let encryptedData = CryptoService.shared.encrypto(originalDataString: originalDataString) else {
            return
        }
        KeychainService.shared.store(userUUID: user.uuid, userData: encryptedData)
    }
    
    public func store(mnemonics: String, walletName: String?, walletSelected: Bool) {
        let name: String
        if let _name = walletName {
            name = _name
        } else {
            name = generateDefaultWalletName()
        }
        let wallet = Wallet(mnemonics: mnemonics, name: name, isSelected: walletSelected)
        let user = makeUser(with: wallet)
        store(user: user)
    }
    
    private func generateDefaultWalletName() -> String {
        let count = wallets.count + 1
        return "Main Wallet\(count)"
    }
    
    public func makeUser(with wallet: Wallet) -> User {
        var existWallets = wallets
        existWallets.append(wallet)
        return User(wallets: existWallets)
    }

    public func obtainingUser() -> User? {
        if let uuid = uuid,
           let encryptedData = try? KeychainService.shared.obtaining(userUUID: uuid),
           let decryptDataString = CryptoService.shared.decrypto(encryptedDataString: encryptedData),
           let user = decodeUserFromString(decryptDataString) {
            return user
        }
        print("obtaining user fail")
        return nil
    }
    
    private func decodeUserFromString(_ userDataString: String) -> User? {
        guard let userData = userDataString.data(using: .utf8) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: userData)
            return user
        } catch {
            assertionFailure("Failed to decode user: \(error)")
            return nil
        }
    }
    
    private func flatMapUserToString(_ user: User) -> String? {
        do {
            let encoder = JSONEncoder()
            let userData = try encoder.encode(user)
            let userDataString = String(data: userData, encoding: .utf8)
            return userDataString
        } catch {
            assertionFailure("Failed to encode user: \(error)")
            return nil
        }
    }
    
    private func obtainingSelectedWallet() -> Wallet? {
        let user = obtainingUser()
        let wallets = user?.wallets
        let selectedWallet = wallets?.first { $0.isSelected }
        let firstWallet = wallets?.first
        guard let selectedWallet = selectedWallet else {
            return firstWallet
        }
        return selectedWallet
    }
    
}
