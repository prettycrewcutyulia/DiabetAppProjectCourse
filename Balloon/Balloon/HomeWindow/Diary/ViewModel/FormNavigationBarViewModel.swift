//
//  FormNavigationBarViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 12.12.2023.
//

import Foundation
import SwiftUI

class FormNavigationBarViewModel : ObservableObject {
    @Published var choosenIndicators:DiabetiIndicators = DiabetiIndicators.Blood
    @Published var check:Bool = false
    @Published var diabetNote:DiabetNoteModel = DiabetNoteModel(Date: .now, Blood: 0, XE: 0, ShortInsulin: 0, LongInsulin: 0, Comment: "")
    @Published var notes: [DiabetNote] = []
    @Published var isModalPresented = false
    @Published var needRefresh = false
    
    static let shared = FormNavigationBarViewModel()
    let coreDM: CoreDataManager = CoreDataManager.shared
    
    func getNote() {
        DispatchQueue.main.async {
            let fetchedNotes = self.coreDM.getAllNotes()
            self.notes = fetchedNotes
        }
    }
    
    func saveNote() {
        // сохранение в CoreData
        coreDM.saveNote(note: diabetNote)
        // сохранение на серваке
        
        DispatchQueue.main.async {
            //очищение
            //            self.diabetNote = DiabetNoteModel(Date: .now, Blood: 0, XE: 0, ShortInsulin: 0, LongInsulin: 0, Comment: "")
            self.diabetNote.Date = Date()
            self.diabetNote.Blood = 0
            self.diabetNote.XE = 0
            self.diabetNote.ShortInsulin = 0
            self.diabetNote.LongInsulin = 0
            self.diabetNote.Comment = ""
            self.diabetNote.objectWillChange.send()
            self.needRefresh.toggle()
        }
        getNote()
        
    }
    
    func deleteNote(index:Int) {
        let note = notes[index]
        coreDM.deleteNote(note: note)
        // обновление на сервере
        
        notes.remove(at: index)
    }
    
    
    
}
