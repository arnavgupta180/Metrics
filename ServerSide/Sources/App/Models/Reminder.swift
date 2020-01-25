//
//  File.swift
//  
//
//  Created by tokopedia on 16/01/20.
//


import Foundation
import Fluent
import Vapor

 final class Reminder: Model, Content {
    static let schema = "reminders"
    
    @ID(key: "id") var id: Int?
    @Field(key: "title") var title: String
    @Parent(key: "userID") var user: User
    init() {}
    init(id: Int? = nil, title: String, userID: User) {
        self.id = id
        self.title = title
        self.user = userID
    }
}

struct  CreateReminderData: Content {
    let title: String
    let userID: User.IDValue
}
