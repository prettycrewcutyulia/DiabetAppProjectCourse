//
//  AnalyticViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 17.12.2023.
//

import Foundation

class AnalyticViewModel:ObservableObject {
    let coreDM: CoreDataManager = CoreDataManager.shared
    @Published var notes: [DiabetNote] = []
    
   func getNote() -> [DiabetNote] {
       let fetchedNotes = self.coreDM.getAllNotes()
       return fetchedNotes
    }
}
