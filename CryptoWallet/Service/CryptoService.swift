//
//  CryptoService.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/28.
//

import Foundation
import CryptoSwift

public final class CryptoService {
    
    private enum Constants {
        static let encryptionKey = "c7831704bec14a047d2c65e7859b278e0babda2fd818e7eb49e403c90e4c88fe"
    }
    static let shared = CryptoService()
    
    public func encrypt(data: Data, key: String, iv: String) throws -> Data? {
        guard let aes = try? AES(key: key.bytes, blockMode: CBC(iv: iv.bytes), padding: .pkcs7) else {
            return nil
        }
        
        let encrypted = try aes.encrypt(data.bytes)
        return Data(encrypted)
    }

    public func decrypto(data: Data, key: String, iv: String) throws -> Data? {
        guard let aes = try? AES(key: key.bytes, blockMode: CBC(iv: iv.bytes), padding: .pkcs7) else {
            return nil
        }
        let encrypted = try aes.decrypt(data.bytes)
        return Data(encrypted)
    }
    
    public func encrypto(originalDataString data: String) -> String? {
        AES256CBC.encryptString(data, key: Constants.encryptionKey)
    }
    
    public func decrypto(encryptedDataString data : String) -> String? {
        AES256CBC.decryptString(data, key: Constants.encryptionKey)
    }
}
