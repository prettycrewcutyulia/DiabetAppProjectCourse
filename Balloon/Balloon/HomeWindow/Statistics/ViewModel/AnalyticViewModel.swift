//
//  AnalyticViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 17.12.2023.
//

import Foundation
import PDFKit
import SwiftUI

class AnalyticViewModel:ObservableObject {
    let coreDM: CoreDataManager = CoreDataManager.shared
    @Published var notes: [DiabetNote] = []
    @Published var isExporting = false
    @Published var sex: String = UserDefaults.standard.string(forKey: "Sex") ?? "Female"
    @Published var height: Int = UserDefaults.standard.integer(forKey: "Height")
    @Published var weight: Int = UserDefaults.standard.integer(forKey: "Weight")
    @Published var typeDiabet: String =  UserDefaults.standard.string(forKey: "TypeDiabet") ?? "Type 1"
    @Published var lowLevelSugar: Int = UserDefaults.standard.integer(forKey: "lowLevelSugar") == 0 ? 3 : UserDefaults.standard.integer(forKey: "lowLevelSugar")
    @Published var highLevelSugar: Int = UserDefaults.standard.integer(forKey: "highLevelSugar") == 0 ? 12 : UserDefaults.standard.integer(forKey: "highLevelSugar")
    
    private let date: Date
    @Published var birthDate: Date
    @Published var name: String =  UserDefaults.standard.string(forKey: "Name") ?? "Юлия"
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        date = dateFormatter.date(from: "27.12.2002") ?? Date()
        
        birthDate = (UserDefaults.standard.object(forKey: "BirthDate") as? Date) ?? date
    }
    
    func getNote() -> [DiabetNote] {
        let fetchedNotes = self.coreDM.getAllNotes()
        return fetchedNotes
    }
    
    @MainActor
    private func generatePDF() -> Data {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let nowDateString = formatter.string(from: Date())
        let birthDateFormat = formatter.string(from: birthDate)
        let value = "Показания от \(nowDateString)"
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595, height: 842))
        let data = pdfRenderer.pdfData { context in
            
            context.beginPage()

            alignText(value: value, x: 0, y: 30, width: 580, height: 40, alignment: .center, textFont: UIFont.systemFont(ofSize: 30, weight: .bold))
            alignText(value: "Данные пациента", x: 30, y: 70, width: 580, height: 100, alignment: .left, textFont: UIFont.systemFont(ofSize: 20, weight: .bold))
            alignText(value: "1) Имя: \(name)", x: 30, y: 100, width: 580, height: 100, alignment: .left, textFont: UIFont.systemFont(ofSize: 16, weight: .regular))
            alignText(value: "2) Дата рождения: \(birthDateFormat)", x: 30, y: 120, width: 580, height: 100, alignment: .left, textFont: UIFont.systemFont(ofSize: 16, weight: .regular))
            alignText(value: "3) Пол: \(sex.localized)", x: 30, y: 140, width: 580, height: 100, alignment: .left, textFont: UIFont.systemFont(ofSize: 16, weight: .regular))
            alignText(value: "4) Рост: \(height)", x: 30, y: 160, width: 580, height: 100, alignment: .left, textFont: UIFont.systemFont(ofSize: 16, weight: .regular))
            alignText(value: "5) Вес: \(weight)", x: 30, y: 180, width: 580, height: 100, alignment: .left, textFont: UIFont.systemFont(ofSize: 16, weight: .regular))
            alignText(value: "6) Тип диабета: \(typeDiabet.localized)", x: 30, y: 200, width: 580, height: 100, alignment: .left, textFont: UIFont.systemFont(ofSize: 16, weight: .regular))

            alignText(value: "Показания за период", x: 30, y: 230, width: 580, height: 100, alignment: .left, textFont: UIFont.systemFont(ofSize: 20, weight: .bold))
            
            func fillTableData(from notes: [DiabetNoteModel]) -> [[String]] {
                var data: [[String]] = [["Дата", "Сахар", "XE", "Короткий инсулин", "Длинный инсулин", "Комментарий"]]
                print(notes)
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                
                for note in notes {
                    let dateStr = formatter.string(from: note.Date)
                    let bloodStr = String(format: "%.1f", note.Blood)
                    let xeStr = String(format: "%.1f", note.XE)
                    let shortInsulinStr = String(format: "%.1f", note.ShortInsulin)
                    let longInsulinStr = String(format: "%.1f", note.LongInsulin)
                    let row = [dateStr, bloodStr, xeStr, shortInsulinStr, longInsulinStr, note.Comment]
                    data.append(row)
                }
                
                return data
            }

            let tableData = fillTableData(from: getNote().toDiabetNoteModels()) // получение двумерного массива
            // Drawing table
            drawTable(data: tableData,
                            x: 30, y: 260, width: 540, height: 200)
            
        }
        
        return data
    }
    
    func alignText(value:String, x: Int, y: Int, width:Int, height: Int, alignment: NSTextAlignment, textFont: UIFont){
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = alignment
       
        let attributes = [    NSAttributedString.Key.font: textFont,
                              NSAttributedString.Key.paragraphStyle: paragraphStyle  ]
        
        let textRect = CGRect(x: x,
                              y: y,
                              width: width,
                              height: height)
        
        value.draw(in: textRect, withAttributes: attributes)
    }
    
    func drawTable(data: [[String]], x: Int, y: Int, width: Int, height: Int, cellSpacing: Int = 4) {
        let columns = data[0].count
        let rows = data.count
        let columnWidth = (width - cellSpacing * (columns - 1)) / columns
        let rowHeight = (height - cellSpacing * (rows - 1)) / rows
        
        for i in 0..<rows {
            for j in 0..<columns {
                let xPos = x + j * (columnWidth + cellSpacing)
                let yPos = y + i * (rowHeight + cellSpacing)
                let fieldFrame = CGRect(x: xPos, y: yPos, width: columnWidth, height: rowHeight)
                
                let fieldText: NSString = data[i][j] as NSString
                
                fieldText.draw(in: fieldFrame, withAttributes:
                [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
            }
        }
    }
    
    @MainActor func savePDF() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let nowDateString = formatter.string(from: Date())
        let value = "Показания от \(nowDateString)"
        let fileName = "\(value).pdf"
        let pdfData = generatePDF()
        var result: String?
        
        if let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let documentURL = documentDirectories.appendingPathComponent(fileName)
            do {
                try pdfData.write(to: documentURL)
                print("PDF saved at: \(documentURL)")
                result = value
            } catch {
                print("Error saving PDF: \(error.localizedDescription)")
            }
        }
        return result
    }
}
