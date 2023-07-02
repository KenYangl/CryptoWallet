//
//  SettingsView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var appSettings: AppSettings
    @State private var showWalletView = false
    
    var body: some View {
        List {
            NavigationLink(destination: WalletsView()) {
                SettingsRow(title: "settings_wallets".localized, accessoryType: .none)
            }
            
            Section {
                NavigationLink(destination: SecurityView()) {
                    SettingsRow(title: "settings_security".localized, accessoryType: .none)
                }
            }
            
            Section(header: Text("settings_appearance".localized)) {
                NavigationLink(destination: ThemeView()) {
                    SettingsRow(title: "settings_display_theme".localized, accessoryType: .text("settings_dark_mode_subtitle_automatic".localized))
                }
                
                Button(action: openAppSettings) {
                    SettingsRow(title: "settings_appl_anguage".localized, accessoryType: .text(currentLanguage()))
                }
            }
            
            Section(header: Text("settings_support".localized)) {
                NavigationLink(destination: LearnView()) {
                    SettingsRow(title: "settings_learn".localized, accessoryType: .none)
                }
                NavigationLink(destination: HelpCenterView()) {
                    SettingsRow(title: "settings_help_center".localized, accessoryType: .none)
                }
            }
            
            Section(header: Text("settings_about_starry_sky".localized)) {
                SettingsRow(title: "settings_version".localized, accessoryType: .text("1.0.0"))
                NavigationLink(destination: TermsOfServiceView()) {
                    SettingsRow(title: "settings_terms_of_service".localized, accessoryType: .none)
                }
                NavigationLink(destination: PrivacyView()) {
                    SettingsRow(title: "settings_privacy".localized, accessoryType: .none)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("settings_navigation_title".localized)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    private func currentLanguage() -> String {
        let mainBundle = Bundle.main
        let preferredLanguages = mainBundle.preferredLocalizations
        guard let currentLanguage = preferredLanguages.first else {
            return ""
        }
        switch currentLanguage {
        case "en":
            return "English"
        case "zh-Hans":
            return "中文"
        default:
            return ""
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
