import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    
//    app.get("hello") { req in
//        return "Hello, world!"
//    }
//    app.get("bottles", ":count") { req -> Bottles in
//        guard let count = req.parameters.get("count", as: Int.self) else {
//        throw Abort(.badRequest)
//      }
//      return Bottles(count:count)
//    }
    struct UserInfo: Content {
      let name: String
    //  let age: Int
    }
    struct UserMessage: Content{
        let message: String
    }

    app.post("user-info"){ req -> UserMessage in
        let userInfo = try req.content.decode(UserInfo.self)
        let message = "Hello \(userInfo.name)"
        return UserMessage(message: message)
    }

    let todoController = TodoController()
    app.get("todos", use: todoController.index)
    app.post("todos", use: todoController.create)
    app.on(.DELETE, "todos", ":todoID", use: todoController.delete)
}
