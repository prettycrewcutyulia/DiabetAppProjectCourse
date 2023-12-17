//
//  ChooseTypeDiabetViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 02.12.2023.
//

import Foundation

class ChooseTypeDiabetViewModel: ObservableObject {
    @Published var selectedTypeDiabet: String = "Type 1"
    // Массив типов диабета
    @Published var diabetesTypes = ["Type 1", "Type 2", "LADA", "Prediabetes", "Gestational", "Another"]
    
    func chooseTypeDiabet(_ type: String) {
        selectedTypeDiabet = type
    }
    
    func confirmChoose() {
        UserDefaults.standard.set(selectedTypeDiabet, forKey: "TypeDiabet")
    }
}
