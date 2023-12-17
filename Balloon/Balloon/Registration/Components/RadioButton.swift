//
//  RadioButton.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 02.12.2023.
//

import Foundation
import SwiftUI

struct RadioButton : View {
    let isSelected: Bool
    let text: String
    let action: () -> Void
    
    init(isSelected: Bool, text: String, action: @escaping () -> Void) {
        self.isSelected = isSelected
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Label(text.localized,
                  systemImage: isSelected ? "largecircle.fill.circle" : "circle")
            .font(Font.custom("OpenSans-Regular", size: 25))
            .foregroundColor(Color("TextColor"))
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
    }
}
