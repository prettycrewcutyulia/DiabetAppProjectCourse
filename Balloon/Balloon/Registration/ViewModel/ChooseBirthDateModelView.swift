//
//  ChooseBirthDateModelView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 08.12.2023.
//

import Foundation

class ChooseBirthDateModelView:ObservableObject {
    @Published var currentDate = Date()
    let startDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())!
    let endDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
    
    func confirmChoose() {
        UserDefaults.standard.set(currentDate, forKey: "BirthDate")
    }
}
