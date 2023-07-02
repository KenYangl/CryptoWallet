//
//  AppSettings.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/28.
//

import SwiftUI
import Combine

class AppSettings: ObservableObject {
    @Published var selectedTab: TabBar.Tab = .home
}
