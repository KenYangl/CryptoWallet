//
//  CryptoWalletApp.swift
//  CryptoWallet
//
//  Created by Ken on 2023/7/2.
//

import SwiftUI

@main
struct CryptoWalletApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
