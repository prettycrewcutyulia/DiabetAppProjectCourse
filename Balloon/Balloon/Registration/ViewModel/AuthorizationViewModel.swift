//
//  AuthorizationViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 01.12.2023.
//

import SwiftUI

class AuthorizationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var pass: String = ""
    @Published var showInvalidError: Bool = false
    @Published var isContinue: Bool = false
    @Published var invalidGetUser: Bool = false
    @Published var errorMessage:String = ""
    
    private let authService = AuthenticationServiceEmail.shared // ваш сервис авторизации
    private let dbService = DatabaseService.shared
    
    func signIn() {
        authService.signIn(email: email, password: pass) { [weak self] error in
                    if let error = error {
                        self?.showInvalidError = true
                        print("Ошибка входа: \(error.localizedDescription)")
                        return
                    } else {
                        self?.showInvalidError = false
                        UserDefaults.standard.set("yes", forKey: "login")
                        //self?.isContinue = true
                    }
                }
        guard let idUser = UserDefaults.standard.string(forKey: "idUser") else {
            self.showInvalidError = true
            //self.isContinue = false
            UserDefaults.standard.set("no", forKey: "login")
            //print("Ошибка входа: \(error.localizedDescription)")
            return
        }
        dbService.getUser(userID: idUser, completion: {
            result in
            switch result {
            case .success(let user):
                // Получен успешный результат - информация о пользователе
                print("User info received: \(user)")
                UserDefaults.standard.set(user.male, forKey: "Sex")
                UserDefaults.standard.set(user.height, forKey: "Height")
                UserDefaults.standard.set(user.weight, forKey: "Weight")
                UserDefaults.standard.set(user.typeDiabet, forKey: "TypeDiabet")
                UserDefaults.standard.set(user.birthDate, forKey: "BirthDate")
                UserDefaults.standard.set(user.name, forKey: "Name")
                self.isContinue = true
                UserDefaults.standard.set("yes", forKey: "login")
                
            case .failure(let error):
                // Получена ошибка при запросе данных о пользователе
                print("Failed to fetch user info. Error: \(error)")
                self.invalidGetUser = true
                self.errorMessage = "Something went wrong. Check the entered data and your Internet connection.".localized
                UserDefaults.standard.set("no", forKey: "login")
            }
        })
        }
}

