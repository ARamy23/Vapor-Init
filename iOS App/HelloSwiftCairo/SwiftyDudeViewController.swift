//
//  SwiftyDudeViewController.swift
//  HelloSwiftCairo
//
//  Created by Ahmed Ramy on 4/24/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import UIKit

class SwiftyDudeViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://localhost:8080/swiftydude")!
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
            guard let data = data, let string = String(data: data, encoding: String.Encoding.utf8) else { return }
            DispatchQueue.main.async {
                self.label.text = string
            }
        }.resume()
    }
}
