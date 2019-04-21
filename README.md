# Step 3

Now that we have our lovely API that can recieve and send requests in form of JSON, It would be nicer if we had something that can do more than just introduce ourselves or send some info about ourselves and be introduced again (had to say that...)



So, for this step, we are going to build...



### **MEDIUM!**



Well… not exactly that big Medium website where u see lots of experiences written neatly for you to take in in a couple of mins, but it's a start 😄



So? what are we waiting for? let's start **Medium**ing!



For a starter we gonna delete all the files we created at the moment, however if you wanted to return to the previous stuff, you can always revisit the steps by using `git checkout step-n` (where n is the step you wanted to go back to)



so, first thing to do is launching that terminal and run the following commands in the project folder



first we will delete all the unnecessary files that were generated when we first created the project...

`rm -rf Sources/App/Models/*`

`rm -rf Sources/App/Controllers/*`



then we will create a model to hold the articles and a controller which will be responsible for handling the requests and sending the responses

`touch Sources/App/Models/Article.swift`

`touch Sources/App/Controllers/ArticlesController.swift`



After that go back to your Xcode project and go to your `routes.swift` file and **delete everything in between the braces** of the `routes(_ router:)` function



now go to `configure.swift` file and delete this line

`migrations.add(model: Todo.self, database: .sqlite)`

**don't worry about it we will come to migrations and databases in a later step**

------



### now that everything is clean, build your project and make sure that you don't have any compilation errors



so to get started, you have to regenerate the vapor project in order to make sure that Xcode gets our inputted files and that they would work with Vapor correctly



run the following command

`vapor xcode -y`







after that, let's visit our `Article.swift` file and start building our Articles model



before going into the actual coding, first let's understand an important aspect when using Vapor, which is **Fluent**



> “Fluent
> Fluent is Vapor’s ORM or object relational mapping tool. It’s an abstraction layer between the Vapor application and the database, and it’s designed to make working with databases easier. Using an ORM such as Fluent has a number of benefits.
> The biggest benefit is you don’t have to use the database directly! When you interact directly with a database, you write database queries as strings. These aren’t type-safe and can be painful to use from Swift.
> Fluent benefits you by allowing you to use any of a number of database engines, even in the same app. Finally, you don’t need to know how to write queries since you can interact with your models in a “Swifty” way.”
>
> By Tim Condon. “Server Side Swift with Vapor.”



now that we got an idea about what Fluent is...



let's start building our Model by writing the following...



```swift
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
    
    /// Body of the article
    var body: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
```



notice the `optional` after the `id` property? this means that this property will be filled directly by Fluent



but that much is not gonna cut it yet for us to start having articles in our app, so we need to add more things to our `Article` for it to be effective!



so let's start by telling fluent that this is a Model that it's gonna use by conforming it to `Model` protocol!

```swift
extension Article: Model {
    
    // Tell Fluent that we are using SQLite as a database for this model
    typealias Database = SQLiteDatabase
    
    // Tell Fluent that the type of our ID for this model will be an Int
    typealias ID = Int
    
    // Tell Fluent that we will be using the the model's id property as a keyPath
    static var idKey: IDKey = \Article.id
}
```



or we can also say this directly...

```swift
// extending the Article to a SQLiteModel here means that
// this model will be an entity later in the SQLiteDatabase
// so you can include it in the migrations
extension Article: SQLiteModel {}
```



Now that fluent knows that this is a SQLiteModel which is gonna be saved in a SQLite database

we need to conform the model to the `Migration` protocol, by doing so we help Fluent to create a table for our database, which also comes hand in hand with building a **reliable, testable and reproducible** changes to your database.

**Migration** is  most commonly used in creating database schemas, also used to seed data into your database or make changes to your models after they've been saved



Add the following at thend of your `Articles.swift` to make the model conform to `Migraition`



```swift
// extending the Article to Migration here means that
// this model can be used by the database
// and prepares the database to use this model before your application runs.
extension Article: Migration {}
```



And that's all we need to do… (I know Fluent needs to know lots of things to be useful but it saves you tons of work)



now that we are done teaching Fluent what to do, we are ready to add our model to our configuration so that we can use the model and do some useful stuff with it!



Open `configure.swift` from your hierarchy and add the following line before `services.register(migrations)`



```swift
migrations.add(model: Article.self, database: .sqlite)
```



now that we've added the model to our database we need to make it conform to `Content` like we did in `step-2`



add the following to the end of the `Article.swift`

```swift
// extending the Article to Content here means that
// this model is tirelessly convertable to a JSON to be responded with to
// iOS & Android clients
extension Article: Content {}
```



with that being said, now our model is set and ready to be used and that it's time to actually use it and control it...



go to **ArticlesController.swift** and fill it up with the following.

```swift
import Fluent
import Vapor

/// Articles Controller which is responsible for handling logic of routes for Articles
struct ArticlesController: RouteCollection {
    func boot(router: Router) throws {
        
    }
}
```



We are conforming our `ArticlesController` to `RouteCollection` so that it can be used solely to handle the routes of the articles
doing so keeps our routes.swift file clean and preserve the single responsibility principle



now we have to go back to the **routes.swift** file to register our controllers so that our App can use it's routes



replace the `routes(_:Router) with the following

```swift
/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // make an array of controllers
    let controllers: [RouteCollection] = [ArticlesController()]
    
    // register each controller in the router so it can use it's paths
    try controllers.forEach { try router.register(collection: $0) }
}
```



now our application can use any routes that are implemented in the `ArticlesController`.

------

### **Now it's time to implement the routes for the Articles**



What we are going to do is **CRUD**, which stands for Create, Read, Update, Delete

which are essential 4 things that any API should do, for instance, I can create an article, I can get my article or all the articles, I can edit and modify my articles and then I can delete it



So we are going to start with a simple POST which creates the API



go to the **ArticlesController.swift** and right below the `boot(router: Router)`

add the following...

```swift
/// creates articles and saves them
    ///
    /// - Parameters:
    ///   - req: in-coming request
    ///   - article: article decodable data in the request body
    /// - Returns: returns a Future of an Article
    func createHandler(_ req: Request, article: Article) throws -> Future<Article> {
        return article.save(on: req)
    }
```

you may be wondering about what a `Future` is, it's similar to `Promises` to handle Async work

also why we labeled this function as `throws` because sometimes an error may occur and you want to handle this error, for instance `403` which stands for you're not authorized to do this action and other types of error which you want to send back as a response for the client apps to show to the mobile user



now that we've created a handler to handle our Articles creating requests, we have to tell our routes to keep an eye on those POST requests that are supposed to create Articles



go to the `boot(router: Router)` function in the same file you're in and add the following lines



```swift
// this sets our articles endpoint which is going to be responsible for
// doing operations on the articles API
// so our final URL should be like localHost:8080/api/articles
// then we differnetiate between it using our httpMethod type
let articlesRoutes = router.grouped("api", "articles")
        
articlesRoutes.post(Article.self, use: createHandler)
```



notice that we didn't give our `createHandler` function it's arguments? 

that's because they can be interfered from the `post(Article.self, use: createHandler)` function...

that's what is called `Currying` 



(And no… not that one)

![steph-curry doing some currying](https://media.giphy.com/media/QOgvV9rV4hHpgNRBfQ/giphy.gif)



now let's test creating our first article through postman!



first go to the terminal and run the following commands

`vapor update`

`vapor build`

to make sure that our routes are installed correctly and that our little app can see them, run `vapor run routes`

and you should be ending up with something like this

![routes](/Users/ahmedramy/Desktop/Workstation/iOS/Today-I-Read/routes.png)



then go back to xcode, run the project and fire up your postman

(Postman be like...)

![henedy postman](/Users/ahmedramy/Desktop/Workstation/iOS/Today-I-Read/henedy postman.png)

------



After feeding postman my first article on medium, this was the result!

![first article!](/Users/ahmedramy/Desktop/Workstation/iOS/Today-I-Read/first article!.png)



if you want to you can read the article on medium from 

[here]: https://link.medium.com/fGFoatPY4V



or if you're just interested in the text, I've left a text file in the project which goes by the name of `medium article.txt`, you can find it by going to project's folder in the finder and copy & paste the title and the body like i did with postman!



now let's go back to Xcode and add the rest of our routes!



### Read

now that we created our first article, we also want to fetch that article and all the articles that are there

so we will start by adding a `getAllHandler`

after right your `createHandler(:Request, article: Article)`, add the following

```swift
/// gets all articles that are there in the database
///
/// - Parameter req: in-coming request
/// - Returns: Future of articles
func getAllHandler(_ req: Request) throws -> Future<[Article]> {
	return Article // 1 ~> in the Article Entity
		.query(on: req) // 2 ~> perform a query on the in-coming request
		.all() // 3 ~> then return all articles
}
```



And while we're at it, let's also add the get a specific article handler using the `Parameter` protocol that we made Article conform to earlier



below `getAllHandler(: Request)`, add...

```swift
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
```



and don't forget to register the handlers to your controller's router

add the following to the end of the `boot(router: Router)`

```swift
articlesRoutes.get(use: getAllHandler)
articlesRoutes.get(Article.parameter, use: getHandler)
```



now go to your terminal and execute the following command

`vapor build && vapor run routes` so we can check that our app knows about the two routes, and you should be ending up with something like this

![routes check2](/Users/ahmedramy/Desktop/Workstation/iOS/Today-I-Read/routes check2.png)

