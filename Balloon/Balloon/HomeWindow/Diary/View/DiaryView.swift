//
//  DiaryView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 15.12.2023.
//

import SwiftUI

struct DiaryView: View {
    @ObservedObject var viewModel = FormNavigationBarViewModel.shared
    @State private var selectedIndex: Int? = nil
    private let updatedNote: DiabetNote? = nil
    @State private var needsRefresh: Bool = false
    
    var body: some View {
        ZStack() {
            VStack {
                FormNavigationBar(textButton: "Save".localized, actionButton: viewModel.saveNote).listRowSeparator(.hidden)
                List {
                    Section("History".localized) {
                        ForEach(viewModel.notes.indices.reversed(), id: \.self) { index in
                            VStack(alignment: .leading) {
                                Text("\(formattedDate(viewModel.notes[index].date!))").foregroundStyle(Color("TextColor"))
                                HStack(content: {
                                    Image(systemName: "drop.fill")
                                    Text(String(format: "%.1f", viewModel.notes[index].blood)).foregroundStyle(Color("TextColor"))
                                    Image(systemName:"fork.knife")
                                    Text(String(format: "%.1f", viewModel.notes[index].xe)).foregroundStyle(Color("TextColor"))
                                    Image(systemName:"syringe")
                                    Text(String(format: "%.1f", viewModel.notes[index].shortInsulin)).foregroundStyle(Color("TextColor"))
                                    Image(systemName: "syringe.fill")
                                    Text(String(format: "%.1f", viewModel.notes[index].longInsulin)).foregroundStyle(Color("TextColor"))
                                }).foregroundStyle(Color("BaseColor"))
                                HStack(alignment: .top) {
                                    Image(systemName: "square.and.pencil").foregroundStyle(Color("BaseColor"))
                                    Text(viewModel.notes[index].comment ?? "")
                                }
                            }
                            .onTapGesture {
                                viewModel.isModalPresented.toggle()
                                selectedIndex = index
                            }
                        }.onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                let reversedIndex = viewModel.notes.indices.reversed()[index]
                                viewModel.deleteNote(index: reversedIndex)
                            }
                        })
                        
                    }
                }.listStyle(.plain)
                    .refreshable {
                        viewModel.getNote()
                    }
                
            }.onAppear(perform: {
                viewModel.getNote()
            }).onChange(of: needsRefresh, {
                viewModel.getNote()
            })
            if viewModel.isModalPresented {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 5)
                UpdateNoteView(isModalPresented: $viewModel.isModalPresented, action: self.viewModel.getNote, updatedNote: viewModel.notes[selectedIndex!], needRefresh: $needsRefresh)
                
            }
        }
    }
    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
}
