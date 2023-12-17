//
//  ChooseBirthDateView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 06.12.2023.
//

import SwiftUI

struct ChooseBirthDateView: View {
    @ObservedObject var modelView = ChooseBirthDateModelView()
    var body: some View {
            VStack(alignment: .center, spacing: 30) {
                TopImageWithText(Spacing: 6, Image: "calm", Text: "When were you born?".localized)
                Spacer()
                DatePicker("", selection: $modelView.currentDate, in: modelView.startDate...modelView.endDate, displayedComponents: [.date])
                    .datePickerStyle(.wheel).labelsHidden()
                    .padding()
                Spacer()
                CustomNavigationButton(destination: ChooseGeneralInfoView(), label: {Text("continue".localized)}, action: {modelView.confirmChoose()})
        }.padding()
            .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all)).navigationTitle("")
    }
}

#Preview {
    ChooseBirthDateView()
}
