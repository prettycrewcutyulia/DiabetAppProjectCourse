//
//  DiabetNote.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 15.12.2023.
//
//
import Foundation


class DiabetNoteModel: ObservableObject, Identifiable {
    @Published var Date:Date = .now
    @Published var Blood:Double = 0.0
    @Published var XE:Double = 0.0
    @Published var ShortInsulin: Double = 0.0
    @Published var LongInsulin: Double=0.0
    @Published var Comment:String = ""
    
    init(Date: Date, Blood: Double, XE: Double, ShortInsulin: Double, LongInsulin: Double, Comment: String) {
        self.Date = Date
        self.Blood = Blood
        self.XE = XE
        self.ShortInsulin = ShortInsulin
        self.LongInsulin = LongInsulin
        self.Comment = Comment
    }
}

extension DiabetNote {
    func toDiabetNoteModel() -> DiabetNoteModel {
        // Предполагая, что DiabetNoteModel - это структура или класс,
        // имеющая аналогичные свойства DiabetNote.
        return DiabetNoteModel(Date: self.date!, Blood: self.blood, XE: self.xe, ShortInsulin: self.shortInsulin, LongInsulin: self.longInsulin, Comment: self.comment!)
    }
}

extension Array where Element == DiabetNote {
    func toDiabetNoteModels() -> [DiabetNoteModel] {
        return self.map { $0.toDiabetNoteModel() }
    }
}
