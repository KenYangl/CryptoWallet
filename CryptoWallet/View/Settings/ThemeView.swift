//
//  ThemeView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/24.
//

import SwiftUI

enum DarkMode: String, RawRepresentable {
    case automatic = "automatic"
    case nomal = "nomal"
    case dark = "dark"
}

struct ThemeView: View {
    @State private var autoFollowSystem = true
    
    var body: some View {
        List {
            Section {
                Toggle("settings_dark_mode_automatic".localized, isOn: $autoFollowSystem)
            } footer: {
                Text("settings_dark_mode_settings_dark_mode_automatic_footer".localized)
            }

            Section("settings_dark_mode_select_manually".localized) {
                Text("settings_dark_mode_normal".localized)
                Text("settings_dark_mode_dark".localized)
            }
        }
        .navigationTitle("settings_dark_mode_navigation_title".localized)
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}
