//
//  Wallet.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/27.
//

import Foundation

public struct Wallet: Codable, Identifiable {
    public let id: UUID
    /// mnemonic string separated by spaces
    let mnemonics: String
    /// wallet name
    let name: String
    /// Is the wallet currently selected
    let isSelected: Bool
    
    init(mnemonics: String, name: String, isSelected: Bool) {
        self.mnemonics = mnemonics
        self.name = name
        self.isSelected = isSelected
        self.id = UUID()
    }
}
