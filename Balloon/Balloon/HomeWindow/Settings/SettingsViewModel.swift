//
//  SettingsViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 18.12.2023.
//

import Foundation

// ViewModel для настроек
class SettingsViewModel : ObservableObject {
    @Published var sex: String = UserDefaults.standard.string(forKey: "Sex") ?? "Female"
    @Published var height: Int = UserDefaults.standard.integer(forKey: "Height")
    @Published var weight: Int = UserDefaults.standard.integer(forKey: "Weight")
    @Published var typeDiabet: String =  UserDefaults.standard.string(forKey: "TypeDiabet") ?? "Type 1"
    @Published var lowLevelSugar: Int = UserDefaults.standard.integer(forKey: "lowLevelSugar") == 0 ? 3 : UserDefaults.standard.integer(forKey: "lowLevelSugar")
    @Published var highLevelSugar: Int = UserDefaults.standard.integer(forKey: "highLevelSugar") == 0 ? 12 : UserDefaults.standard.integer(forKey: "highLevelSugar")
    
    private let date: Date
    @Published var birthDate: Date
    @Published var name: String =  UserDefaults.standard.string(forKey: "Name") ?? "Юлия"
    @Published var selectedLanguage: String = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "ru"
    @Published var showInvalidError: Bool  = false
    @Published var errorMessage:String = ""
    let diabetesTypes = ["Type 1", "Type 2", "LADA", "Prediabetes", "Gestational", "Another"]
    let languages = ["en", "ru"]
    
    let dbService = DatabaseService.shared
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        date = dateFormatter.date(from: "27.12.2002") ?? Date()
        
        birthDate = (UserDefaults.standard.object(forKey: "BirthDate") as? Date) ?? date
    }
    
    func saveSettings() {
        UserDefaults.standard.set(sex, forKey: "Sex")
        UserDefaults.standard.set(height, forKey: "Height")
        UserDefaults.standard.set(weight, forKey: "Weight")
        UserDefaults.standard.set(typeDiabet, forKey: "TypeDiabet")
        UserDefaults.standard.set(birthDate, forKey: "BirthDate")
        UserDefaults.standard.set(name, forKey: "Name")
        UserDefaults.standard.set(lowLevelSugar, forKey: "lowLevelSugar")
        UserDefaults.standard.set(highLevelSugar, forKey: "highLevelSugar")
        
        DispatchQueue.main.async {
            UserDefaults.standard.set(self.selectedLanguage, forKey: "selectedLanguage")
            self.selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage")!
        }
        
        
        var newUser = UserGeneralInfo()
        newUser.id = UserDefaults.standard.string(forKey: "idUser") ?? UUID().uuidString
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
