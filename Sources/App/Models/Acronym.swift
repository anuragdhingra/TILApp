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
    var creatorID: User.ID
    
    init(short: String, long: String, creatorID: User.ID) {
        self.short = short
        self.long = long
        self.creatorID = creatorID
    }
}

extension Acronym: SQLiteModel {}
extension Acronym: Content {}
extension Acronym: Migration {}

extension Acronym {
    var creator: Parent<Acronym,User> {
        return parent(\.creatorID)
    }
}
