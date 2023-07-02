//
//  AppLockMethodView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/25.
//

import SwiftUI

struct AppLockMethodView: View {
    var body: some View {
        List {
            SettingsRow(title: "Passcode", accessoryType: .none)
            SettingsRow(title: "Passcode / Face ID", accessoryType: .none)
        }
        .navigationTitle("Lock Method")
    }
}

struct AppLockMethodView_Previews: PreviewProvider {
    static var previews: some View {
        AppLockMethodView()
    }
}
