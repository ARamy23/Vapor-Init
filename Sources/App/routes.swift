import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // make an array of controllers
    let controllers: [RouteCollection] = [ArticlesController()]
    
    // register each controller in the router so it can use it's paths
    try controllers.forEach { try router.register(collection: $0) }
}
