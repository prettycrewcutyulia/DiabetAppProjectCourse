//
//  ChooseLanguageViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 01.12.2023.
//

import Foundation
import SwiftUI

class ChooseLanguageViewModel: ObservableObject {
    @Published var selectedLanguage: String
    
    init() {
        self.selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
    }
    
    func chooseLanguage(_ language: String) {
        selectedLanguage = language
        UserDefaults.standard.set(language, forKey: "selectedLanguage")
    }
}

