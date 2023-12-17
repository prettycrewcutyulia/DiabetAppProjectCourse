//
//  SwiftUIView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 16.12.2023.
//

import SwiftUI

struct UpdateNoteView: View {
    @Binding var isModalPresented: Bool
    @ObservedObject var viewModel:UpdateNoteViewModel
    var updatedNote:DiabetNote
    @Binding var needsRefresh: Bool
    
    init(isModalPresented: Binding<Bool>,action: @escaping () -> Void, updatedNote: DiabetNote, needRefresh:Binding<Bool>) {
        _isModalPresented = isModalPresented
        viewModel = UpdateNoteViewModel(updatedNote: updatedNote)
        self.updatedNote = updatedNote
        _needsRefresh = needRefresh
    }

    var body: some View {
        VStack {
            FormNavigationBar(textButton: "Update".localized, actionButton:{
                viewModel.updateNote()
                self.isModalPresented.toggle()
                self.needsRefresh.toggle()
            })
            .onAppear(perform: {
                viewModel.viewModelDiaryView.diabetNote = DiabetNoteModel(Date: updatedNote.date!, Blood: updatedNote.blood, XE: updatedNote.xe, ShortInsulin: updatedNote.shortInsulin, LongInsulin: updatedNote.longInsulin, Comment: updatedNote.comment!)
            })
            Button("Cancel".localized) {
                self.isModalPresented.toggle()
            }.foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width * 0.3)
                .background(Color("BaseColor"))
            .cornerRadius(10).padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding()
    }
}
