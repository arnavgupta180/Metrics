//  Created by Carmen Jwen on 16/01/2020.
//
/*
 POST http://localhost:8080/api/users/
 {
 "name" : "Tim"
 "username" : "timc"
 }
 
 */
import Foundation
import Fluent
import Vapor
struct UserController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        let userRoutes = routes.grouped("api","users")
        routes.post("api", "users", use: createHandler)
        routes.post("api", "users", use: getAllHandler)
      //  routes.put("api", "users","userID", use: updateHandler)

      //  routes.delete("api","users",":userID", use: deleteHandler(req: ))
  
    }
    
    func createHandler(req: Request) throws -> EventLoopFuture<User>{
        let user = try req.content.decode(User.self)
        return user.save(on: req.db).map { user }
    }
//    func boot(routes: RoutesBuilder) throws {
//           routes.post("api", "users", use: getAllHandler)
//       }
    
//    func deleteHandler(req:Request)-> EventLoopFuture<[HTTPStatus]>{
//        User.find(req.parameters.get("userID"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//            .flatMap({$0.delete(on: req.db)})
//            //.transform(to: .)
//        }
    
    func getAllHandler(req:Request)-> EventLoopFuture<[User]>{
        User.query(on: req.db).all()
    }
  
    func getFirstUser(req:Request)-> EventLoopFuture<User>{
        User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
//    func useUpdateHandler(req: Request) -> EventLoopFuture<User> {
//        _ = try req.content.decode(User.self)
//        return User.find(req.parameters.get("userID"), on: req.db)
//    }
}

