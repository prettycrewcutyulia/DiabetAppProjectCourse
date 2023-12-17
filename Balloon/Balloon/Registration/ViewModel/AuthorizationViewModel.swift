//
//  AuthorizationViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 01.12.2023.
//

import SwiftUI

class AuthorizationViewModel: ObservableObject {
    @Published var user: String = ""
    @Published var pass: String = ""
    @Published var showInvalidError: Bool = false
    @Published var isContinue: Bool = false
    
    private let authService = AuthenticationServiceEmail.shared // ваш сервис авторизации
    
    func signIn() {
        authService.signIn(email: user, password: pass) { [weak self] error in
                    if let error = error {
                        self?.showInvalidError = true
                        print("Ошибка входа: \(error.localizedDescription)")
                    } else {
                        self?.showInvalidError = false
                        UserDefaults.standard.set("yes", forKey: "login")
                        self?.isContinue = true
                    }
                }
        }
}

