//
//  VisibilityToggleButton.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 02.12.2023.
//

import Foundation
import SwiftUI

struct VisibilityToggleButton: View {
    @Binding var isVisible: Bool
    
    var body: some View {
        Button(action: {
            isVisible.toggle()
        }, label: {
            Image(systemName: isVisible ? "eye.slash.fill": "eye.fill")
                .foregroundColor(.gray)
        })
    }
}
