//
//  Export.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 07.03.2024.
//

import SwiftUI

struct ExportView: View {
    @ObservedObject var viewModel: AnalyticViewModel
    var view: AnyView
    var body: some View {
        VStack {
            Text("Select the export format".localized).font(.title2)
            Divider().frame(height: 1).background(Color("BaseColor")).padding(.horizontal)
            Button(action: {
                //viewModel.saveAsPDF(view: view)
            }) {
                Text("Export to PDF".localized)
            }
            Button(action: {
                // код для экспорта в CSV
            }) {
                Text("Export to CSV".localized)
            }
        }
    }
}
