//
//  File.swift
//  
//
//  Created by tokopedia on 16/01/20.
//

import Foundation
import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: "id") var id: Int?
    @Field(key: "name") var name: String
    @ID(key: "username") var username: String
    init() {}
    init(id: Int? = nil, name: String, username: String) {
        self.id = id
        self.name = name
        self.username = username
    }
}
