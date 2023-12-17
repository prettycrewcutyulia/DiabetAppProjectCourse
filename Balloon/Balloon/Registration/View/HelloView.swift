//
//  HelloView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 19.11.2023.
//

import SwiftUI

struct HelloView: View {
    @State private var isChooseTypeDiabetPresented = false
    let userName =  UserDefaults.standard.string(forKey: "Name") ?? "Non"
    
    var body: some View {
        VStack(spacing: 40) {
                VStack(spacing: 30, content: {
                    Text("Hi".localized + ", " + userName + ", " + "my name is Balloon and I will become your personal diabetic assistant".localized).padding(18).font(Font.custom("OpenSans-Regular", size: 25)).lineSpacing(-1).tracking(-1).multilineTextAlignment(.center)
                    Image("balloon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 223)
                    Text("Answer a couple of questions before I can help you".localized).padding(30).font(Font.custom("OpenSans-Regular", size: 25)).lineSpacing(-1).tracking(-1).multilineTextAlignment(.center)
                })
            FullScreenCoverButton(
                            isPresented: $isChooseTypeDiabetPresented,
                            destination: ChooseTypeDiabetView(),
                            label: Text("Let's go".localized),
                            action: {
                                isChooseTypeDiabetPresented.toggle()
                            }
                        )
        }.padding() // Добавляем padding, чтобы фон занимал весь экран
            .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
    }
}
