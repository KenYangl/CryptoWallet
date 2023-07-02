//
//  WalletManager.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/23.
//

import WalletCore

enum WalletManager {
    
    static func isValid(mnemonic: String) -> Bool {
        Mnemonic.isValid(mnemonic: mnemonic)
    }

    static func isValid(coinType: CoinType, address: String) -> Bool {
        coinType.validate(address: address)
    }
    
    /// Creat a multi-coin wallet
    /// - Parameters:
    ///   - strength: The strength of the secret seed. Higher seed means more information content, longer recovery phrase. Default value is 128, but 256 is also possible.
    ///   - passphrase: Optional passphrase, used to scramble the seed. If specified, the wallet can be imported and opened only with the passphrase (Not to be confused with recovery phrase).
    /// - Returns: HDWallet
    static func creatWallet(strength: Int32 = 128, passphrase: String = "") throws -> HDWallet {
        guard let wallet = HDWallet(strength: strength, passphrase: passphrase) else {
            throw SSError.WalletError.walletCreateFailed
        }
        return wallet
    }
    
    /// Creat a multi-coin wallet and return a mnemonic array
    /// - Parameters:
    ///   - strength: The strength of the secret seed. Higher seed means more information content, longer recovery phrase. Default value is 128, but 256 is also possible.
    ///   - passphrase: Optional passphrase, used to scramble the seed. If specified, the wallet can be imported and opened only with the passphrase (Not to be confused with recovery phrase).
    /// - Returns: mnemonic array
    static func creatWalletForMnemonicArray(strength: Int32 = 128, passphrase: String = "") throws -> [String] {
        do {
            let wallet = try creatWallet(strength: strength, passphrase: passphrase)
            let mnemonics = wallet.mnemonic.components(separatedBy: " ")
            return mnemonics
        } catch {
            throw error
        }
    }
    
    /// Import a multi-coin wallet
    /// - Parameters:
    ///   - mnemonic: a.k.a. recovery phrase. The string of several words that was used to create the wallet.
    ///   - passphrase: Optional passphrase, used to scramble the seed. If specified, the wallet can be imported and opened only with the passphrase (Not to be confused with recovery phrase).
    /// - Returns: HDWallet
    static func importWallet(with mnemonic: String, passphrase: String = "") throws -> HDWallet {
        guard isValid(mnemonic: mnemonic) else {
            throw SSError.WalletError.mnemonicisInvalid
        }
        guard let wallet = HDWallet(mnemonic: mnemonic, passphrase: passphrase) else {
            throw SSError.WalletError.walletCreateFailed
        }
        return wallet
    }
    
    /// Generating the Default Address for a Coin
    /// The simplest is to get the default address for a coin -- this requires no further inputs.
    /// The address is generated using the default derivation path of the coin.
    /// - Parameters:
    ///   - wallet: HDWallet
    ///   - coinType: Cointype
    /// - Returns: Address of wallet
    static func getAddress(for wallet: HDWallet, coinType: CoinType) -> String {
        wallet.getAddressForCoin(coin: coinType)
    }
    
    /// Generating an Address Using a Custom Derivation Path (Expert)
    /// Warning: use this only if you are well aware of the semantics of the derivation path used!
    /// - Parameters:
    ///   - wallet: HDWallet
    ///   - coinType: CoinType
    ///   - derivationPath: a non-null derivation path
    /// - Returns: Address of wallet
    static func getAddress(
        for wallet: HDWallet,
        coinType: CoinType,
        derivationPath: String
    ) throws -> String {
        guard !derivationPath.isEmpty else {
            throw SSError.WalletError.derivationPathEmpty
        }
        let key = wallet.getKey(coin: coinType, derivationPath: derivationPath)
        let address = coinType.deriveAddress(privateKey: key)
        return address
    }
    
    static func getPrivateKey(for wallet: HDWallet, coinType: CoinType) -> PrivateKey {
        wallet.getKeyForCoin(coin: coinType)
    }
    
    static func getBase64PublicKey(for wallet: HDWallet, coinType: CoinType) -> String {
        let pk = getPrivateKey(for: wallet, coinType: coinType)
            .getPublicKeySecp256k1(compressed: true)
        let output = pk.data.base64EncodedString()
        return output
    }

    static func getHexPublicKey(for wallet: HDWallet, coinType: CoinType) -> String {
        let pk = getPrivateKey(for: wallet, coinType: coinType)
            .getPublicKeySecp256k1(compressed: true)
        let output = pk.data.hexString
        return output
    }
}
