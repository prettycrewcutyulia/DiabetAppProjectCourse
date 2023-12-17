//
//  ForgotPasswordView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 19.11.2023.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @ObservedObject var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        VStack(spacing: 30) {
           TopImageWithText(Spacing: 6, Image: "balloon", Text: "Recover Password".localized)
                VStack(alignment: .leading, spacing: 20, content: {
                    CustomTextField(text: $viewModel.email, placeholder: "Email")
                        .frame(width: screenSize.width * 0.8, height: 24).registrationTextFieldStyle()
                })
            Button(action: {
                viewModel.resetPassword()
            }) {
                Text("Recover Password".localized).font(Font.custom("OpenSans-SemiBold", size: 25)).foregroundColor(.white)
                    .frame(width: screenSize.width * 0.9, height: 70)
                    .background(Color("BaseColor"))
                    .cornerRadius(10)
            }.alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(viewModel.alertText), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }.padding() // Добавляем padding, чтобы фон занимал весь экран
            .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all)).navigationTitle("")
    }
}

#Preview {
   ForgotPasswordView()
}
