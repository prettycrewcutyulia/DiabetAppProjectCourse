//
//  SettingsView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 18.12.2023.
//

import SwiftUI

// View для настроек
struct SettingsView: View {
    
   @ObservedObject var viewModel = SettingsViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings".localized).font(.title2)
            Divider().frame(height: 1).background(Color("BaseColor")).padding(.horizontal)
            Form {
                Section(header: Text("Personal Information".localized)) {
                    TextField("Name".localized, text: $viewModel.name)
                    DatePicker("Birth Date".localized, selection: $viewModel.birthDate, displayedComponents: .date) .environment(\.locale, UserDefaults.standard.string(forKey: "selectedLanguage") == "ru" ? Locale(identifier: "ru_RU"): Locale.autoupdatingCurrent) // Установка локали на русскую, если необходимо
                        }

                Section(header: Text("Health Information".localized)) {
                    Picker("Type of Diabetes".localized, selection: $viewModel.typeDiabet) {
                        ForEach(viewModel.diabetesTypes, id: \.self) { type in
                            Text(type.localized).tag(type)
                        }
                                    }
                            
                    Picker("Height".localized, selection: $viewModel.height) {
                                ForEach(30..<250) { value in
                                    Text("\(value) " + "cm".localized).tag(value)
                                }
                            }
                            
                    Picker("Weight".localized, selection: $viewModel.weight) {
                                ForEach(5..<250) { value in
                                    Text("\(value) " + "kg".localized).tag(value)
                                }
                            }
                    Picker(selection: $viewModel.sex, content: {
                                Text("Male".localized).tag("male").font(Font.title)
                                Text("Female".localized).tag("female")
                            }, label: {Text("")}).pickerStyle(.segmented)
                    Picker("Low level sugar",selection: $viewModel.lowLevelSugar) {
                        ForEach(0..<25) { value in
                            Text("\(value) " + "mmol/l".localized)
                        }
                    }
                    Picker("High level sugar",selection: $viewModel.highLevelSugar) {
                        ForEach(0..<25) { value in
                            Text("\(value) " + "mmol/l".localized)
                        }
                    }
                        }
                Section(header: Text("Language".localized)) {
                    Picker("Language".localized, selection: $viewModel.selectedLanguage) {
                                    ForEach(viewModel.languages, id: \.self) { language in
                                        Text(language.localized).tag(language)
                                    }
                                }
                            }

                        Button(action: {
                            viewModel.saveSettings()
                        }) {
                            Text("Save".localized)
                        }
            }
            .navigationBarTitle("Settings".localized)
        }
    }
}
