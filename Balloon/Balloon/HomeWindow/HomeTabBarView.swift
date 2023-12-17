//
//  HomeTabBarView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 10.12.2023.
//

import SwiftUI

struct HomeTabBarView: View {
    @ObservedObject var viewModel = HomeTabBarViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedView)  {
            DiaryView()
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("Diary".localized)
                }.tag(1)
            Analytic()
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                    Text("Statistics".localized)
                }.tag(2)
            Text("Fourth")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings".localized)
                }.tag(3)
        }
    }
}

#Preview {
    HomeTabBarView()
}
