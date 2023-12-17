//
//  TextEditorComment.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 16.12.2023.
//

import SwiftUI

struct TextEditorComment:View {
    enum Field {
        case textEditor
        case placeholder
        case nothing
    }
    @Binding var comment:String
    @FocusState private var focusedField: Field?
    var placeholder:String = "Enter your notes..."
    var body: some View {
        VStack {
            TextEditor(text: $comment)
                .focused($focusedField, equals: .textEditor)
            if (focusedField == .textEditor) {
                Button("Submit") {
                    endTextEditing()
                }.padding(.bottom, 8)
            }
        } .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
               Spacer()
               Button("Done") {
                     UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                     focusedField = nil
               }
            }
         }
    }
    
    func endTextEditing() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                      to: nil, from: nil, for: nil)
    }
}
