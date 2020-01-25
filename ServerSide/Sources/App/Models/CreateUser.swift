//
//  File.swift
//  
//
//  Created by tokopedia on 16/01/20.
//

import Fluent
struct  CreateUser: Migration {
    
    func prepare(on database: Database)-> EventLoopFuture<Void>{
        database.schema(User.schema)
            .field("id", .int,.identifier(auto:true))
        .field("name", .string,.required)
        .field("username", .string,.required)
        .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(User.schema).delete()
    }
}
