import Fluent
import Vapor

// We are conforming our ArticlesController to RouteCollection so that it can be used solely to handle the routes of the articles
// doing so keeps our routes.swift file clean and preserve the single responsibility principle
/// Articles Controller which is responsible for handling logic of routes for Articles
struct ArticlesController: RouteCollection {
    func boot(router: Router) throws {
        
        // this sets our articles endpoint which is going to be responsible for
        // doing operations on the articles API
        // so our final URL should be like localHost:8080/api/articles
        // then we differnetiate between it using our httpMethod type
        let articlesRoutes = router.grouped("api", "articles")
        
        // Create
        articlesRoutes.post(Article.self, use: createHandler)
        
        // Read
        articlesRoutes.get(use: getAllHandler)
        articlesRoutes.get(Article.parameter, use: getHandler)
    }
    
    /// creates articles and saves them
    ///
    /// - Parameters:
    ///   - req: in-coming request
    ///   - article: article decodable data in the request body
    /// - Returns: returns a Future of an Article
    func createHandler(_ req: Request, article: Article) throws -> Future<Article> {
        return article.save(on: req)
    }
    
    /// gets all articles that are there in the database
    ///
    /// - Parameter req: in-coming request
    /// - Returns: Future of articles
    func getAllHandler(_ req: Request) throws -> Future<[Article]> {
        return Article // 1 ~> in the Article Entity
            .query(on: req) // 2 ~> perform a query on the in-coming request
            .all() // 3 ~> then return all articles
    }
    
    /// gets article specified by a parameter after the endpoint
    /// like localHost:8080/api/articles/4
    ///
    /// - Parameter req: in-coming request
    /// - Returns: a future of the specified article in the URL
    func getHandler(_ req: Request) throws -> Future<Article> {
        return try req // 1 ~> We take the request
            .parameters // 2 ~> we cut it down and get the parameter (...articles/`1`)
            .next(Article.self) // 3 ~> we map that parameter into the Article type
    }
}
