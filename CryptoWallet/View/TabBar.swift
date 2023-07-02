//
//  TabBar.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/23.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject private var appSettings: AppSettings

    enum Tab: Int {
        case home, nft, browser, settings
    }
    
    func tabbarItem(text: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
                .imageScale(.large)
            Text(text)
        }
    }
    
    var body: some View {
        TabView(selection: $appSettings.selectedTab) {
            HomeView()
                .tabItem{
                    tabbarItem(text: "tab_home".localized, image: appSettings.selectedTab == .home ? "house.fill" : "house")
            }
            .tag(Tab.home)
            
            NFTView()
                .tabItem{
                    tabbarItem(text: "tab_nft".localized, image: appSettings.selectedTab == .nft ? "heart.fill" : "heart")
            }
            .tag(Tab.nft)
            
            BrowserView()
                .tabItem{
                    tabbarItem(text: "tab_browser".localized, image: appSettings.selectedTab == .browser ? "square.split.2x2.fill" : "square.split.2x2")
            }
            .tag(Tab.browser)
            
            NavigationStack {
                SettingsView()
            }
            .tabItem{
                tabbarItem(text: "tab_settings".localized, image: appSettings.selectedTab == .settings ? "gearshape.fill" : "gearshape")
            }
            .tag(Tab.settings)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .environment(\.locale, .init(identifier: "en"))
    }
}
