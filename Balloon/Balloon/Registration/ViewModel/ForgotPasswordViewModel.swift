//
//  ForgotPasswordViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 02.12.2023.
//

import Foundation
import SwiftUI

class ForgotPasswordViewModel: ObservableObject {
    @Published var email = ""
    @Published var showAlert = false // Добавлено состояние для отображения Alert
    @Published var alertMessage = ""
    @Published var alertText = ""
    @Published private var success = false
    
    private let authService = AuthenticationServiceEmail.shared // сервис авторизации
    
    func resetPassword() {
        if (self.email != "") {
            authService.resetPassword(email: email) {  [weak self] (error) in
                if error == nil {
                    self?.showAlert = true
                    self?.success = true
                    self?.alertText = "Success".localized
                    self?.alertMessage = "Password reset email has been sent to".localized + "\(String(describing: self?.email))"
                } else {
                    self?.showAlert = true
                    self?.alertText = "Not success".localized
                    //self?.alertMessage = "Something went wrong. Try again.".localized
                    self?.alertMessage = error?.localizedDescription ??  "Something went wrong. Try again."
                }
            }
        }
    }
}
