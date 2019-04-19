# Step 2

Right now you might be asking, how did that `hello, world` came to life when i didn't even do anything? 
What happened is that we used a template in Vapor which already has a route which takes you to the default page on the server which justs renders a simple hello world paragraph on the screen

we can alternate this a bit by going to the file which is responsible for the routes of our little backend app and put more creativity into it!



open **routes.swift** in **Sources/App**



then right after the `router.get("hello")`, add the following

```Swift
router.get("hello", "swift-cairo") { req in
		return "Hello, Swift-Cairo!"
}
```



build and run and then go to http://localHost:8080/hello/world

Yep, you guessed it right, this will fire up something exactly like this...

![Swift Cairo ❤](https://github.com/ARamy23/Today-I-Read/blob/step-2/swift-cairo.png)



Hello, World is great, but let's take this a bit further more! 

how about we make it print something which we can input in ourselves rather than hardcoding it?

below `router.get("hello", "swift-cairo")`, add the following...



```Swift
router.get("hello", String.parameter) { req in 
    return try "hello, \(req.parameters.next(String.self))"
}
```



![hello, Instabug! 🐞](https://github.com/ARamy23/Today-I-Read/blob/step-2/hello%2C%20Instabug!.png)



so, let's break down this to parts



`String.parameter` is another word for saying 

> Please take the type given in the URL and you should expect it to be a String



Then to parse this type you extract it from the request like in `req.parameters.next(String.self)`

you may noticce that it's super similar to codable parsing where you say something like `JSONDecoder().decode(String.self, from: data)`



Okay now that we can print anything on the screen after hello and got familiar with routes, why don't we up our game a little bit and start recieving some JSON? 💪



First things first, in order for our little Hello something app to send off JSON, we need to create something which can be encoded and decoded from data and to data



and that something is…?

### Content!

content is something similar to codable which allows our model to be converted to JSON so u can pass it to clients app (Web, iOS, Android… etc)



So we gonna create a simple model like the following...

in **routes.swift**, below the public `routes(_ router: Router)` 



add this `struct` 

```swift
struct SwiftyCairoer: Content {
    let name: String
    let yearsOfExperience: Double
    let toWhomDoesHeBelong: String
}
```



then right after `router.get("hello", String.parameter)`

add this one...

```swift
router.post(SwiftyCairoer.self, at: "swiftydude") { req, data -> String in
    let name = data.name
    let yearsOfExperience = data.yearsOfExperience
    return "The name is \(name)\nBeen Building iOS Apps for \(yearsOfExperience)"
}
```



build and run then fire up `Postman`!

![postman](https://github.com/ARamy23/Today-I-Read/blob/step-2/postman.png)

okay but what if we wanted to receieve JSON instead?

well, we can do something like this...

```swift
router.post(SwiftyCairoer.self, at: "jsondude") { req, data -> String in
    let name = data.name
    let yearsOfExperience = data.yearsOfExperience
    return "The name is \(name)\nBeen Building iOS Apps for \(yearsOfExperience)"
}
```

then we should expect something like this 

![postman json](https://github.com/ARamy23/Today-I-Read/blob/step-2/postman%20json.png)





------



### Conclusion 

### Now that we made our little Hello world app be able to accept JSON and return one, we are now ready to take our simple hello world app to the next level!

feel free to switch to the next step by `git checkout step-3`