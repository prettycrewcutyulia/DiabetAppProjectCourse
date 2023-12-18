//
//  ChooseGeneralInfoView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 09.12.2023.
//

import SwiftUI

struct ChooseGeneralInfoView: View {
    @ObservedObject var viewModel: ChooseGeneralInfoViewModel = ChooseGeneralInfoViewModel()
    
    var body: some View {
            VStack(alignment: .center) {
                TopImageWithText(Spacing: 6, Image: "calm", Text: "And a few more questions...".localized).frame(maxHeight: 250)
                List {
                    Picker(selection: $viewModel.sex, content: {
                        Text("Male".localized).tag("male").font(Font.title)
                        Text("Female".localized).tag("female")
                    }, label: {Text("")}).pickerStyle(.palette).listRowSeparator(.hidden).padding(.vertical)
                    Picker(selection: $viewModel.height, label:
                            Text("Height".localized)
                                ) {
                                    ForEach(30..<250) { value in
                                        Text("\(value) " + "cm".localized).tag(value)
                                    }
                                }.onAppear {
                                    UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 18)], for: .normal)
                                }.padding().overlay(RoundedRectangle(cornerRadius: 10.0)
                                    .strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                    Picker(selection: $viewModel.weight, label:
                            Text("Weight".localized)
                                ) {
                                    ForEach(5..<250) { value in
                                        Text("\(value) "+"kg".localized).tag(value)
                                    }
                    }.padding().overlay(RoundedRectangle(cornerRadius: 10.0)
                        .strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0))).listRowSeparator(.hidden)
                }.listStyle(.inset)
                
                FullScreenCoverButton(isPresented: $viewModel.isContinue, destination: HomeTabBarView(), label: Text("sign in".localized), action: {viewModel.createAccount()})
                }
        .padding()
            .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ChooseGeneralInfoView()
}
