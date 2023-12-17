//
//  TopImageWithText.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 02.12.2023.
//

import Foundation
import SwiftUI

struct TopImageWithText : View {
    
    var spacing: CGFloat
    var image: String
    var text: String
    
    init(Spacing: CGFloat, Image: String, Text: String) {
        self.spacing = Spacing
        self.image = Image
        self.text = Text
    }
    
    var body: some View {
        VStack(alignment: .center,spacing: spacing, content: {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140)
            GeometryReader { geometry in
                Text(text).font(Font.custom("OpenSans-Regular", size: 30)).padding().multilineTextAlignment(.center) .minimumScaleFactor(0.3)
                    .frame(width: geometry.size.width) // Установите ширину текста или используйте другие параметры
            }
        })
    }
    
}
