//
//  UserGeneralInfo.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 08.12.2023.
//

import Foundation

struct UserGeneralInfo: Identifiable, Codable {
    var id: String = ""
    var Name: String = ""
    var BirthDate: Date = Date()
    var TypeDiabet: String = ""
    var Height: Int = 0
    var Weight: Int = 0
    var Male: String = ""
}
