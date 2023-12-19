//
//  DiabetIdentif.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 16.12.2023.
//

import Foundation

// Индикаторы для кастомных sliders для ввода данных записей
enum DiabetiIndicators: String, CaseIterable, Identifiable {
    case Blood = "Blood"
    case XE = "Bread unit"
    case ShortInsulin = "Short insulin"
    case LongInsulin = "Long insulin"
    case Comment = "Comment"
    
    var id: String { self.rawValue }
}
