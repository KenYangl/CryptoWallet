//
//  SSError.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/23.
//

struct SSError {
    enum WalletError: Error {
        case walletCreateFailed
        case mnemonicisInvalid
        case derivationPathEmpty
        case obtainingUserDataFromKeychainError
    }
}
