//
//  File.swift
//  
//
//  Created by tokopedia on 16/01/20.
//

import Foundation
import Fluent

struct CreateReminder: Migration {
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Reminder.schema).delete()

    }
    
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Reminder.schema)
            .field("id",.int,.identifier(auto: true))
        .field("title",.string,.required)
         .field("userID",.int,.required)
        .create()

    }
    
    
}
