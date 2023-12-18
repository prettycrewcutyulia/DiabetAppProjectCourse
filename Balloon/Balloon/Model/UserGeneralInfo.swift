//
//  UserGeneralInfo.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 08.12.2023.
//

import Foundation

struct UserGeneralInfo: Identifiable, Codable {
    var id: String = ""
    var name: String = ""
    var birthDate: Date = Date()
    var typeDiabet: String = ""
    var height: Int = 0
    var weight: Int = 0
    var male: String = ""
}
