//
//  JSONDudeViewController.swift
//  HelloSwiftCairo
//
//  Created by Ahmed Ramy on 4/24/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import UIKit

class JSONDudeViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var lovesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://localhost:8080/jsondude")!
        let parameters = ["name": "Ahmed Ramy", "age": 20, "awaitingWhatThisYear": "Anime!"] as [String : Any]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print((error?.localizedDescription)!)
                return
            }
            guard let data = data else { return }
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    self.nameLabel.text = user.name
                    self.ageLabel.text = "\(user.age)"
                    self.lovesLabel.text = user.loves
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

struct User: Codable {
    let name: String
    let age: Int
    let awaitingWhatThisYear: String
}
