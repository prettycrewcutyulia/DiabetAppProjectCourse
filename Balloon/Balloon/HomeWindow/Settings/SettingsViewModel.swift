//
//  SettingsViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 18.12.2023.
//

import Foundation

class SettingsViewModel : ObservableObject {
    @Published var sex: String = UserDefaults.standard.string(forKey: "Sex")!
    @Published var height: Int = UserDefaults.standard.integer(forKey: "Height")
    @Published var weight: Int = UserDefaults.standard.integer(forKey: "Weight")
    @Published var typeDiabet: String =  UserDefaults.standard.string(forKey: "TypeDiabet")!
    @Published var birthDate: Date = (UserDefaults.standard.object(forKey: "BirthDate") as? Date)!
    @Published var name: String =  UserDefaults.standard.string(forKey: "Name")!
    @Published var selectedLanguage: String = UserDefaults.standard.string(forKey: "selectedLanguage")!
    @Published var showInvalidError: Bool  = false
    @Published var errorMessage:String = ""
    let diabetesTypes = ["Type 1", "Type 2", "LADA", "Prediabetes", "Gestational", "Another"]
    let languages = ["en", "ru"]
    
    let dbService = DatabaseService.shared
    
    func saveSettings() {
        UserDefaults.standard.set(sex, forKey: "Sex")
        UserDefaults.standard.set(height, forKey: "Height")
        UserDefaults.standard.set(weight, forKey: "Weight")
        UserDefaults.standard.set(typeDiabet, forKey: "TypeDiabet")
        UserDefaults.standard.set(birthDate, forKey: "BirthDate")
        UserDefaults.standard.set(name, forKey: "Name")
        UserDefaults.standard.set(selectedLanguage, forKey: "SelectedLanguage")
        
        var newUser = UserGeneralInfo()
        newUser.id = UserDefaults.standard.string(forKey: "idUser")!
        newUser.birthDate = birthDate
        newUser.height = height
        newUser.male = sex
        newUser.name = name
        newUser.typeDiabet = typeDiabet
        newUser.weight = weight
        
        dbService.updateUser(user: newUser, completion:  { [weak self] error in
                if let error = error {
                    self?.showInvalidError = true
                    self?.errorMessage = error.localizedDescription
                    print("Ошибка входа: \(error.localizedDescription)")
                } else {
                    self?.showInvalidError = false
                }
        })
    }
}
