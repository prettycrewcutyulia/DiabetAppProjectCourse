//
//  HomeTabBarViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 10.12.2023.
//

import Foundation
// Позволяет отправлять уведомления о переходе на другое окно
class HomeTabBarViewModel: ObservableObject {
    @Published var selectedView = 1
}
