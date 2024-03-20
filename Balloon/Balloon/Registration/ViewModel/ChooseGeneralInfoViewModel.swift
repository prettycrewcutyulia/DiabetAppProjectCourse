//
//  ChooseGeneralInfoViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 10.12.2023.
//

import Foundation

class ChooseGeneralInfoViewModel: ObservableObject {
    @Published var sex: String = "male";
    @Published var height: Int = 160;
    @Published var weight: Int = 60;
    @Published var isContinue: Bool = false;
    @Published var errorMessage: String = ""
    @Published var showInvalidError: Bool = false
    @Published var errorTitle: String = "Error".localized
    
    private let authService = AuthenticationServiceEmail.shared
    private let dataBaseService = DatabaseService.shared
    
    func createAccount() {
        var user: UserGeneralInfo = UserGeneralInfo()
        DispatchQueue.main.async {
            user.id =  UserDefaults.standard.string(forKey: "idUser") ?? UUID().uuidString
            user.name = UserDefaults.standard.string(forKey: "Name") ?? ""
            user.typeDiabet = UserDefaults.standard.string(forKey: "TypeDiabet") ?? "Type 1"
            user.birthDate = (UserDefaults.standard.object(forKey: "BirthDate") as? Date)!
            user.male = self.sex
            user.height = self.height
            user.weight = self.weight
            UserDefaults.standard.set(self.sex, forKey: "sex")
            UserDefaults.standard.set(self.height, forKey: "height")
            UserDefaults.standard.set(self.weight, forKey: "weight")
        }
        
        dataBaseService.addUser(user: user) {[weak self] error in
            if let error = error {
                self?.showInvalidError = true
                self?.errorMessage = error.localizedDescription
                print("Ошибка входа: \(error.localizedDescription)")
            } else {
                self?.showInvalidError = false
                UserDefaults.standard.set("yes", forKey: "login")
                self?.isContinue = true
            }
        }
    }
}
