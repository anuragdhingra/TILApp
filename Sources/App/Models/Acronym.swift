//
//  Acronym.swift
//  TILAppPackageDescription
//
//  Created by Anurag Dhingra on 24/04/18.
//

import Foundation
import FluentSQLite
import Vapor

final class Acronym: Codable {
    var id: Int?
    var short: String
    var long: String
    
    init(short: String, long: String) {
        self.short = short
        self.long = long
    }
}

extension Acronym: SQLiteModel {}
extension Acronym: Content {}
extension Acronym: Migration {}
