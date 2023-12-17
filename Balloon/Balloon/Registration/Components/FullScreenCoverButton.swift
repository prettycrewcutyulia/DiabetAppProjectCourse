//
//  FullScreenCoverButton.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 02.12.2023.
//

import Foundation
import SwiftUI

struct FullScreenCoverButton<Content: View>: View {
    @Binding var isPresented: Bool
    var destination: Content
    var label: Text
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            label
                .font(Font.custom("OpenSans-SemiBold", size: 25))
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 70)
                .background(Color("BaseColor"))
                .cornerRadius(10)
        }
        .fullScreenCover(isPresented: $isPresented, content: {
            destination
        })
    }
}
