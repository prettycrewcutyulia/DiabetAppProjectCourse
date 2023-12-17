//
//  ChooseTypeDiabet.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 02.12.2023.
//

import SwiftUI

struct ChooseTypeDiabetView: View {
    @ObservedObject var viewModel = ChooseTypeDiabetViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40, content: {
                TopImageWithText(Spacing: 6, Image: "calm", Text: "What type of diabetes do you have?".localized)
                VStack(alignment: .leading,spacing: 7, content: {
                    ForEach(viewModel.diabetesTypes, id: \.self) { type in
                        RadioButton(isSelected: viewModel.selectedTypeDiabet == type, text: type) {
                            viewModel.selectedTypeDiabet = type
                        }
                    }
                })
                CustomNavigationButton(destination: ChooseBirthDateView(), label: {Text("continue".localized)}, action: viewModel.confirmChoose)
            }).padding() // Добавляем padding, чтобы фон занимал весь экран
                .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all)).navigationTitle("") // Пустой заголовок навигации
        }
    }
}

#Preview {
    ChooseTypeDiabetView()
}
