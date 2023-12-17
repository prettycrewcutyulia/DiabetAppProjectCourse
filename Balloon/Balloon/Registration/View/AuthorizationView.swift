//
//  AuthorizationView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 18.11.2023.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseCore

struct AuthorizationView: View {
    
    @ObservedObject var viewModel = AuthorizationViewModel()
    @State private var isPasswordVisible: Bool = false

    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        
        VStack(spacing: 30, content: {
            TopImageWithText(Spacing: 6, Image: "balloon", Text: "welcome".localized)
            VStack(spacing: 15, content: {
                EmailPasswordInputView(user: $viewModel.user, pass:  $viewModel.pass, isPasswordVisible: $isPasswordVisible, screenSize: screenSize)
                VStack(content: {
                    NavigationLink {
                        ForgotPasswordView()
                    } label: {Text("forgot_password".localized).font(Font.custom("OpenSans-Light", size: 16)).padding(.trailing, 20)
                    }.frame(maxWidth: .infinity, alignment: .trailing).foregroundStyle(Color.gray)
                    if (viewModel.showInvalidError) {
                        Text("invalidloginpassword".localized).font(Font.custom("OpenSans-SemiBold", size: 16)).foregroundStyle(Color.red)
                    }
                })
            })
            
            FullScreenCoverButton(isPresented: $viewModel.isContinue, destination: HelloView(), label: Text("sign in".localized), action: {viewModel.signIn()})
            
            CustomSeparator()
            HStack(spacing: 25, content: {
                ImageSugnInButton(action: {}, image: Image("google_logo"))
                ImageSugnInButton(action: {}, image: Image(systemName: "apple.logo"))
            })
            HStack(content: {
                Text("Don't have an account?".localized).font(Font.custom("OpenSans-Light", size: 18)).foregroundStyle(Color.gray)
                NavigationLink {
                    RegistrationView()
                } label: {
                    Text("Sign up".localized).font(Font.custom("OpenSans-SemiBold", size: 18)).foregroundStyle(Color("TextColor"))
                }
            })
        }).padding() // Добавляем padding, чтобы фон занимал весь экран
            .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
            .navigationTitle("")
    }
}

struct EmailPasswordInputView: View {
    @Binding var user: String
    @Binding var pass: String
    @Binding var isPasswordVisible: Bool
    var screenSize : CGSize

    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            CustomTextField(text: $user, placeholder: "Email").frame(width: UIScreen.main.bounds.width * 0.8, height: 24)
                .padding(.vertical, 18)
                .padding(.horizontal)
                .overlay(RoundedRectangle(cornerRadius: 10.0)
                    .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
            HStack(spacing: 15) {
                if (!isPasswordVisible) {
                    CustomSecureField(text: $pass, placeholder: "Password")
                } else {
                    CustomTextField(text:$pass, placeholder: "Password")
                }
                VisibilityToggleButton(isVisible: $isPasswordVisible)
            } .frame(width: screenSize.width * 0.8, height: 24).padding(.vertical, 18).padding(.horizontal).overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
        })
    }
}

struct CustomSeparator: View {
    var body: some View {
        HStack(content: {
            Rectangle().frame( height: 1)
            Text("or".localized)
            Rectangle().frame( height: 1)
        }).padding(.horizontal, 20).foregroundStyle(.gray)
    }
}
