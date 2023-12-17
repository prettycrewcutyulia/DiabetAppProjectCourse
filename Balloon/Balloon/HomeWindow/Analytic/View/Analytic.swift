//
//  Analytic.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 17.12.2023.
//

import SwiftUI
import Charts

struct Analytic: View {
    @ObservedObject var viewModel = AnalyticViewModel()
    var notes: [DiabetNote] { viewModel.getNote() }

    var body: some View {
        VStack(spacing:10) {
            Text("Analytics".localized).font(.title2)
            Divider().frame(height: 1).background(Color("BaseColor")).padding(.horizontal)
            ScrollView() {
                chartForPeriod(period: "Day", data: filterDataForDay())
                    .frame(height: 300)
                    .padding()
                chartForAverage(period: "Week", data: calculateAverageBloodForDays())
                    .frame(height: 300)
                    .padding()
                chartForAverage(period: "Month", data: calculateAverageBloodForWeeks())
                    .frame(height: 300)
                    .padding()
            }
        }.padding()
    }

    func chartForPeriod(period: String, data: [DiabetNoteModel]) -> some View {
        let averageSugar = calculateAverageSugar(data: data)
        return VStack(spacing: 10) {
            Chart(data) { note in
                LineMark(
                    x: .value("Date", note.Date),
                    y: .value("Blood", note.Blood)
                )
                PointMark(
                    x: .value("Date", note.Date),
                    y: .value("Blood", note.Blood)
                ).annotation(position: .overlay, alignment: .bottom, spacing: 10) {
                    Text("\(String(format: "%.1f", note.Blood))")
                        .font(.caption)
                }
            }
            .frame(height: 300)
            .padding()
            .chartYScale(domain: 0...36)
        }.padding(8)
        .overlay(
            Text("\(period) Chart - Avg Sugar: \(String(format: "%.1f", averageSugar))")
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(8)
            , alignment: .topLeading
        )
    }
    
    func calculateAverageSugar(data: [DiabetNoteModel]) -> Double {
            guard !data.isEmpty else { return 0 }
            let sum = data.reduce(0.0) { $0 + $1.Blood }
            return sum / Double(data.count)
        }

    func filterDataForDay() -> [DiabetNoteModel] {
        // Фильтрация данных за день
        // Например, использование текущей даты для фильтрации
        let currentDate = Date() // Получение текущей даты
        let filteredData = notes.filter { note in
            // Реализуйте логику фильтрации для дня здесь
            // Например, сравнение даты заметки с текущей датой
            return Calendar.current.isDate(note.date!, inSameDayAs: currentDate) && note.blood != 0
        }
        
        let sortedData = filteredData.sorted { $0.date! < $1.date! }
           
           return sortedData.toDiabetNoteModels()
    }

    func filterDataForWeek() -> [DiabetNoteModel] {
            // Фильтрация данных за предыдущую неделю
                
                // Получение текущей даты
                let currentDate = Date()

                // Получение начала предыдущей недели (вычитаем одну неделю)
                guard let startOfPreviousWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate) else {
                    return [] // Обработка ошибки, если не удается получить начало предыдущей недели
                }

                // Получение конца предыдущей недели (текущий день)
                let endOfPreviousWeek = currentDate

                // Фильтрация записей по условию даты
                let filteredData = notes.filter { note in
                    return note.date! >= startOfPreviousWeek && note.date! < endOfPreviousWeek && note.blood != 0
                }

        return filteredData.toDiabetNoteModels()
        }

    func filterDataForMonth() -> [DiabetNoteModel] {
        // Получаем текущую дату
        let currentDate = Date()

        // Получаем начало текущего месяца
        guard let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: currentDate)) else {
            return []
        }

        // Фильтруем данные за месяц до сегодняшней даты
        let filteredData = notes.filter { note in
            guard let noteDate = note.date else { return false }
            return noteDate >= startOfMonth && noteDate <= currentDate && note.blood != 0
        }

        // Сортируем отфильтрованные данные по дате в порядке убывания
        let sortedData = filteredData.sorted { $0.date! > $1.date! }

        // Преобразуем отфильтрованные и отсортированные данные в модели DiabetNoteModel
        return sortedData.toDiabetNoteModels()
    }

    
    func calculateAverageBloodForDays() -> [String: Double] {
        
        let filteredData = filterDataForWeek()
        // Словарь для хранения средних значений blood для каждого дня
        var averageBloodPerDay: [String: Double] = [:]

        // Группировка данных по дням
        let groupedByDay = Dictionary(grouping: filteredData) { note in
            // Используем форматтер даты для создания ключа в формате "год-месяц-день"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: note.Date)
        }

        // Вычисление среднего значения blood для каждого дня
        for (day, notes) in groupedByDay {
            let bloodValues = notes.map { $0.Blood }
            // Фильтруем ненулевые значения уровня крови
            let filteredBloodValues = bloodValues.filter { $0 != 0 }
            // Вычисляем среднее значение для данного дня
            if !filteredBloodValues.isEmpty {
                let average = filteredBloodValues.reduce(0, +) / Double(filteredBloodValues.count)
                averageBloodPerDay[day] = average
            }
        }
        
        // Сортировка словаря по ключам (датам) в порядке возрастания
            let sortedDict = averageBloodPerDay.sorted { $0.key < $1.key }

            // Создаем новый словарь с отсортированными данными
            let sortedAverageBloodPerDay = Dictionary(uniqueKeysWithValues: sortedDict)

            return sortedAverageBloodPerDay
    }

    
    func calculateAverageBloodForWeeks() -> [String: Double] {
        var filteredData = filterDataForMonth()
        var averageBloodPerWeek: [String: Double] = [:]

        // Группировка данных по неделям
        let groupedByWeek = Dictionary(grouping: filteredData) { note in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: note.Date)
            guard let startOfWeek = calendar.date(from: components) else { return "" }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: startOfWeek)
        }

        // Вычисление среднего значения blood для каждой недели
        for (week, notes) in groupedByWeek {
            let bloodValues = notes.compactMap { $0.Blood }
            let filteredBloodValues = bloodValues.filter { $0 != 0 }
            
            if !filteredBloodValues.isEmpty {
                let average = filteredBloodValues.reduce(0, +) / Double(filteredBloodValues.count)
                averageBloodPerWeek[week] = average
            }
        }

        // Сортировка словаря по ключам (датам) в порядке возрастания
            let sortedDict = averageBloodPerWeek.sorted { $0.key < $1.key }

            // Создаем новый словарь с отсортированными данными
            let sortedAverageBloodPerDay = Dictionary(uniqueKeysWithValues: sortedDict)

            return sortedAverageBloodPerDay
    }

    struct DataPoint: Identifiable {
        let id = UUID() // Уникальный идентификатор для Identifiable
        let key: String
        let value: Double
    }
    func chartForAverage(period: String, data: [String:Double]) -> some View {
        let averageSugar = data.values.reduce(0.0, +) / Double(data.count)
        let dataPoints = data.map { DataPoint(key: $0.key, value: $0.value) }
        return VStack {
            Chart(dataPoints) { note in
                LineMark(
                    x: .value("Date", note.key),
                    y: .value("Blood", note.value)
                )
                PointMark(
                    x: .value("Date",  note.key),
                    y: .value("Blood", note.value)
                ).annotation(position: .overlay, alignment: .bottom, spacing: 10) {
                    Text("\(String(format: "%.1f", note.value))")
                        .font(.caption)
                }
            }
            .frame(height: 300)
            .padding()
            .chartYScale(domain: 0...36)
        }
        .overlay(
            Text("\(period) Chart - Avg Sugar: \(String(format: "%.1f", averageSugar))")
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(8)
            , alignment: .topLeading
        )
    }
}


#Preview {
    Analytic()
}
