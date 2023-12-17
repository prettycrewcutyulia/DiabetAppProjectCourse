//
//  CustomNavigationBar.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 02.12.2023.
//

import Foundation
import SwiftUI

struct CustomNavigationButton<Content: View>: View {
    var destination: Content
    var label: Text
    var action: () -> Void = {}
    
    init(destination: Content, @ViewBuilder label: () -> Text) {
        self.destination = destination
        self.label = label()
    }
    
    init(destination: Content, @ViewBuilder label: () -> Text, action: @escaping () -> Void) {
        self.destination = destination
        self.label = label()
        self.action = action
    }
    
    var body: some View {
        NavigationLink(destination: destination.onAppear(perform: {
            action()
        })) {
            label
                .font(Font.custom("OpenSans-SemiBold", size: 25))
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 70)
                .background(Color("BaseColor"))
                .cornerRadius(10)
        }
    }
}


