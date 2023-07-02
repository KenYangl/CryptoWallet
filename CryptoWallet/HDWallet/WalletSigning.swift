//
//  WalletSigning.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/24.
//

import Foundation
import WalletCore

enum WalletSigning {
    
    static func bitcoin(with wallet: HDWallet) -> BitcoinSigningOutput {
        let utxoTxId = Data(hexString: "050d00e2e18ef13969606f1ceee290d3f49bd940684ce39898159352952b8ce2")! // latest utxo for sender, "txid" field from blockbook utxo api: https://github.com/trezor/blockbook/blob/master/docs/api.md#get-utxo
        let privateKey = PrivateKey(data: Data(hexString: "7fdafb9db5bc501f2096e7d13d331dc7a75d9594af3d251313ba8b6200f4e384")!)!
        let address = CoinType.bitcoinCash.deriveAddress(privateKey: privateKey)

        let utxo = BitcoinUnspentTransaction.with {
            $0.outPoint.hash = Data(utxoTxId.reversed()) // reverse of UTXO tx id, Bitcoin internal expects network byte order
            $0.outPoint.index = 2                        // outpoint index of this this UTXO, "vout" field from blockbook utxo api
            $0.outPoint.sequence = UINT32_MAX
            $0.amount = 5151                             // value of this UTXO, "value" field from blockbook utxo api
            $0.script = BitcoinScript.lockScriptForAddress(address: address, coin: .bitcoin).data // Build lock script from address or public key hash
        }

        let input = BitcoinSigningInput.with {
            $0.hashType = BitcoinScript.hashTypeForCoin(coinType: .bitcoin)
            $0.amount = 600
            $0.byteFee = 1
            $0.toAddress = "1Bp9U1ogV3A14FMvKbRJms7ctyso4Z4Tcx"
            $0.changeAddress = "1FQc5LdgGHMHEN9nwkjmz6tWkxhPpxBvBU" // can be same sender address
            $0.utxo = [utxo]
            $0.privateKey = [privateKey.data]
        }

        let output: BitcoinSigningOutput = AnySigner.sign(input: input, coin: .bitcoin)
//        guard output.error.isEmpty else { return }
        // encoded transaction to broadcast
        print(output.encoded)
        return output
    }
    
    static func ethereum(with wallet: HDWallet) -> EthereumSigningOutput {
        let input = EthereumSigningInput.with {
            $0.chainID = Data(hexString: "01")!
            $0.gasPrice = Data(hexString: "d693a400")! // decimal 3600000000
            $0.gasLimit = Data(hexString: "5208")! // decimal 21000
            $0.toAddress = "0xC37054b3b48C3317082E7ba872d7753D13da4986"
            $0.transaction = EthereumTransaction.with {
                $0.transfer = EthereumTransaction.Transfer.with {
                    $0.amount = Data(hexString: "0348bca5a16000")!
                }
            }
            $0.privateKey = wallet.getKeyForCoin(coin: .ethereum).data
        }
        
        let output: EthereumSigningOutput = AnySigner.sign(input: input, coin: .ethereum)
        return output
    }
}
