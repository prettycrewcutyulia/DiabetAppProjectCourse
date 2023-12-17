//
//  Extension+String.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 17.11.2023.
//

import Foundation

extension String {
    
    var localized: String {
        let selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en" // По умолчанию используется английский язык, если значение не установлено
                
        if let path = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj"),
            let bundle = Bundle(path: path) {
                return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
            }
        return NSLocalizedString(self, comment: "")
    }
}
