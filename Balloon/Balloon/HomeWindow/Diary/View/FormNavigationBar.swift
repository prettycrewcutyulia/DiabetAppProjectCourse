//
//  FormNavigationBar.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 10.12.2023.
//

import SwiftUI
import UIKit

struct FormNavigationBar: View {
    
    var actionButton: ()->Void
    var textButton:String
    
    @StateObject var viewModel = FormNavigationBarViewModel.shared
    @State var needRefresh = false
    
    init(textButton:String, actionButton: @escaping ()->Void) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("BaseColor"))
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(selectedTextAttributes, for: .selected)
        self.actionButton = actionButton
        self.textButton = textButton
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            Text(viewModel.choosenIndicators.rawValue.localized).font(.title2)
            Divider().frame(height: 1).background(Color("BaseColor")).padding(.horizontal)
            
            DatePicker("DateTime", selection: $viewModel.diabetNote.Date).labelsHidden().padding(.bottom) .environment(\.locale, UserDefaults.standard.string(forKey: "selectedLanguage") == "ru" ? Locale(identifier: "ru_RU"): Locale.autoupdatingCurrent) // Установка локали на русскую, если необходимо

            switch viewModel.choosenIndicators {
            case .Blood:
                CustomCircleSlider(count: $viewModel.diabetNote.Blood, measurement: "mmol/l".localized, koef: 36, needRefresh: $needRefresh).padding().accentColor(needRefresh ? .white : .black)
            case .XE:
                CustomCircleSlider(count: $viewModel.diabetNote.XE, measurement: "bu".localized, koef: 25, needRefresh: $needRefresh).padding()
                
            case .ShortInsulin:
                CustomCircleSlider(count: $viewModel.diabetNote.ShortInsulin, measurement: "units".localized, koef: 30, needRefresh: $needRefresh).padding()
                
            case .LongInsulin:
                CustomCircleSlider(count: $viewModel.diabetNote.LongInsulin, measurement: "units".localized, koef: 100, needRefresh: $needRefresh).padding()
                
            case .Comment:
                TextEditorComment(comment: $viewModel.diabetNote.Comment)
                    .font(.body)
                    .frame(height: UIScreen.main.bounds.width - 150, alignment: .leading)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BaseColor"), lineWidth: 1)).padding()
                
            }
            
            Button(action: {
                actionButton()
                viewModel.choosenIndicators = .Blood
                viewModel.isModalPresented = false 
                needRefresh.toggle()
            }, label: {Text(textButton) .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: 30)
                    .background(Color("BaseColor"))
                .cornerRadius(10)}).buttonStyle(PlainButtonStyle()).padding()
            Picker("DiabetiIndicators", selection: $viewModel.choosenIndicators) {
                ForEach(DiabetiIndicators.allCases, id: \.self) { indicator in
                    switch indicator {
                    case .Blood:
                        Image(systemName: "drop.fill").tag(indicator)
                    case .XE:
                        Image(systemName:"fork.knife").tag(indicator)
                    case .ShortInsulin:
                        Image(systemName:"syringe").tag(indicator)
                    case .LongInsulin:
                        Image(systemName: "syringe.fill").tag(indicator)
                    case .Comment:
                        Image(systemName: "square.and.pencil").tag(indicator)
                    }
                }
            }.pickerStyle(.segmented)
                .padding(.horizontal)
        }
        .padding()
    }
}
