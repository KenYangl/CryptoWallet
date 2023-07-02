//
//  AppUserDefaults.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/25.
//

import Foundation

public struct AppUserDefaults {
    @UserDefault("darkModeDefaultKey", defaultValue: DarkMode.automatic.rawValue)
    public static var darkMode: String

    @UserDefaultOption("biometricIdentityDefaultKey", defaultValue: nil)
    public static var biometricString: String?
    
    @UserDefaultOption("passcodeDefaultKey", defaultValue: nil)
    public static var passcode: String?
    
    @UserDefaultOption("userUUIDDefaultKey", defaultValue: nil)
    public static var uuid: String?
}

@propertyWrapper
public struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

@propertyWrapper
public struct UserDefaultOption<T> {
    let key: String
    let defaultValue: T?
    
    init(_ key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T? {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}
