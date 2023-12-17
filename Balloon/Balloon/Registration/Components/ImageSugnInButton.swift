//
//  ImageSugnInButton.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 02.12.2023.
//

import Foundation
import SwiftUI

struct ImageSugnInButton: View {
    var action: () -> Void
    var image: Image

    var body: some View {
        Button(action: action) {
            image
                .resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 31.6).padding(15) .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))).foregroundStyle(Color.black)
        }
    }
}

