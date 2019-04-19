import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("hello", "swift-cairo") { req in
        return "Hello, Swift-Cairo!"
    }
    
    router.get("hello", String.parameter) { req in
        return try "hello, \(req.parameters.next(String.self))"
    }

    router.post(SwiftyCairoer.self, at: "swiftydude") { req, data -> String in
        let name = data.name
        let yearsOfExperience = data.yearsOfExperience
        return "The name is \(name)\nBeen Building iOS Apps for \(yearsOfExperience)"
    }
    
    router.post(SwiftyCairoer.self, at: "jsondude") { req, data -> SwiftyCairoer in
        return data
    }
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

struct SwiftyCairoer: Content {
    let name: String
    let yearsOfExperience: Double
}
