//
//  CustomSecureField.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 02.12.2023.
//

import Foundation
import SwiftUI

struct CustomSecureField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        SecureField(placeholder.localized, text: $text)
            .font(Font.custom("OpenSans-Regular", size: 20))
            .multilineTextAlignment(.leading)
            .autocapitalization(.none)
    }
}
