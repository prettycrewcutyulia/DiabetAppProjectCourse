//
//  RegistrationViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 01.12.2023.
//

import Foundation
import SwiftUI

class RegistrationViewModel: ObservableObject {
    @Published var userName = ""
    @Published var email = ""
    @Published var pass = ""
    @Published var confirmPassword = ""
    @Published var showInvalidError = false
    @Published var showInvalidLengthPassword = false
    @Published var isContinue: Bool = false
    
    private let authService = AuthenticationServiceEmail.shared // ваш сервис авторизации
    
    func signUp() {
        guard pass == confirmPassword else {
            showInvalidError = true
            return
        }
        
        guard pass.count >= 6 else {
            showInvalidLengthPassword = true
            return
        }
        
        authService.signUp(email: email, password: pass) { [weak self] error in
            if let error = error {
                print("Ошибка входа: \(error)")
            } else {
                self?.showInvalidError = false
                self?.showInvalidLengthPassword = false
                UserDefaults.standard.set(self?.userName, forKey: "Name")
                self?.isContinue = true
            }
        }
    }
}

