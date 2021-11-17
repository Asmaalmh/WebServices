//
//  ViewController.swift
//  WebServices
//
//  Created by Mobark Alseif on 12/04/1443 AH.
//

import UIKit


struct Book: Codable {

    // MARK: - Properties
    let title: String
    let author: String

}
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        simpleRequest()
    }
    
    // MARK: - simple Request
    func simpleRequest() {
        // Create URL
        let url = URL(string: "https://bit.ly/3sspdFO")
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Send HTTP Request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            if let books = try? JSONDecoder().decode([Book].self, from: data!) {
                print("books.count:\(books.count)")
                for book in books {
                    print(book.title)
                    print(book.author)
                }
            } else {
                print("Invalid Response")
            }
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }.resume()
    }
}

