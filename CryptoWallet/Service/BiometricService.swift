//
//  BiometricService.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/25.
//

import Foundation
import Combine
import LocalAuthentication

//enum BiometryType: String, RawRepresentable {
//    case faceID = "Face ID"
//    case touchID = "Touch ID"
//    case none = "none"
//}

final class BiometricService {
    static let shared = BiometricService()
    let biometryType: LABiometryType
    
    private var biometricString: String? {
        set {
            AppUserDefaults.biometricString = newValue
        }
        get {
            AppUserDefaults.biometricString
        }
    }
    
    init() {
        let context = LAContext()
        var error: NSError?
        _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        biometryType = context.biometryType
    }
    
    func saveBiometricString() {
        let context = LAContext()
        var error: NSError?

        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)

        if let newBiometricString = context.evaluatedPolicyDomainState?.base64EncodedString() {
            biometricString = newBiometricString
        }
    }
    
    func detectBiometricChange() -> AnyPublisher<Bool, Never> {
        let context = LAContext()
        var error: NSError?
        let canFlag = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        guard canFlag else {
            return Just(false).eraseToAnyPublisher()
        }
        
        if let newValue = context.evaluatedPolicyDomainState?.base64EncodedString(), newValue == biometricString {
            return Just(false).eraseToAnyPublisher()
        } else {
            return Just(true).eraseToAnyPublisher()
        }
    }
    
    func evaluate(with type: LABiometryType) -> AnyPublisher<Bool, LAError> {
        guard type != .none else {
            return Fail(error: LAError(.biometryNotAvailable)).eraseToAnyPublisher()
        }
    
        let context = LAContext()
        
        return Future { promise in
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Verify with \(type.rawValue)") { (result, error) in
                if let error = error as? LAError {
                    promise(.failure(error))
                } else {
                    promise(.success(result))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func canEvaluate() -> LAError? {
        let context = LAContext()
        var error: NSError?
        _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)

        if let error = error as? LAError {
            return error
        } else {
            return nil
        }
    }
}
