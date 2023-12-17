//
//  RegistrationView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 19.11.2023.
//

import SwiftUI
import FirebaseAuth

struct RegistrationView: View {
    
    @ObservedObject var viewModel = RegistrationViewModel()

    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        VStack(alignment: .center,spacing: 50, content: {
            TopImageWithText(Spacing: 6, Image: "balloon", Text: "started".localized)
            FormaView(viewModel: viewModel, screenSize: screenSize)
            FullScreenCoverButton(isPresented: $viewModel.isContinue, destination: HelloView(), label: Text("Sign up".localized), action: {viewModel.signUp()})
        }).padding() // Добавляем padding, чтобы фон занимал весь экран
            .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    RegistrationView()
}

struct FormaView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    var screenSize : CGSize
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            
            CustomTextField(text: $viewModel.userName, placeholder: "User name").frame(width: screenSize.width * 0.8, height: 24).registrationTextFieldStyle()
            
            CustomTextField(text:  $viewModel.email, placeholder: "Email").frame(width: screenSize.width * 0.8, height: 24).registrationTextFieldStyle()
            
            HStack(spacing: 15) {
                if (!isPasswordVisible) {
                    CustomSecureField(text: $viewModel.pass, placeholder: "Password")
                }else {
                    CustomTextField(text: $viewModel.pass, placeholder: "Password")
                }
               VisibilityToggleButton(isVisible: $isPasswordVisible)
            } .frame(width: screenSize.width * 0.8, height: 24).registrationTextFieldStyle()
            
            HStack(spacing: 15) {
                if (!isConfirmPasswordVisible) {
                    CustomSecureField(text: $viewModel.confirmPassword, placeholder: "Confirm password")
                }else {
                    CustomTextField(text: $viewModel.confirmPassword, placeholder: "Confirm password")
                }
                VisibilityToggleButton(isVisible: $isConfirmPasswordVisible)
            } .frame(width: screenSize.width * 0.8, height: 24).registrationTextFieldStyle()
            
            if (viewModel.showInvalidError) {
                Text("invalidconfirmpassword".localized).font(Font.custom("OpenSans-SemiBold", size: 16)).foregroundStyle(Color.red)
            }
            if (viewModel.showInvalidLengthPassword) {
                Text("The password length must be greater than 6".localized).font(Font.custom("OpenSans-SemiBold", size: 16)).foregroundStyle(Color.red)
            }
        })
    }
}
extension View {
    func registrationTextFieldStyle() -> some View {
        self.padding(.vertical, 18).padding(.horizontal).overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
    }
}
