import FluentSQLite
import Vapor

final class Article: Codable {
    /// ID to article
    /// can be later used in fetching the article through URL
    /// example: to fetch first article there ever was
    /// use this ~> localhost:8080/articles/1
    var id: Int?
    
    /// Title for the article
    var title: String
    
    /// Body of the artilce
    var body: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}

// extending the Article to a SQLiteModel here means that
// this model will be an entity later in the SQLiteDatabase
// so you can include it in the migrations
extension Article: SQLiteModel {}

// extending the Article to Content here means that
// this model is tirelessly convertable to a JSON to be responded with to
// iOS & Android clients
extension Article: Content {}

// extending the Article to Parameter here means that
// i can use the id of the article i have in the URL and fetch this article
extension Article: Parameter {}

// extending the Article to Migration here means that
// this model can be used by the database
// and prepares the database to use this model before your application runs.
extension Article: Migration {}
