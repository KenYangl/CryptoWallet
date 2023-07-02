//
//  AppLockView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/24.
//

import SwiftUI

struct AppLockView: View {
    var body: some View {
        List {
            Text("Immediate")
            Text("If away for 1 minute")
            Text("If away for 5 minutes")
            Text("If away for 1 hour")
            Text("If away for 5 hours")
            Text("Never")
        }
            .navigationTitle("Auto-Lock")
    }
}

struct AppLockView_Previews: PreviewProvider {
    static var previews: some View {
        AppLockView()
    }
}
