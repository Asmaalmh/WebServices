//
//  TableViewController.swift
//  WebServices
//
//  Created by Mobark Alseif on 12/04/1443 AH.
//

import UIKit

class TableViewController: UITableViewController {
    
    var books : [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        simpleRequest()
    }
    // MARK: - simple Request
    func simpleRequest() {
        // 1 - Create URL
        let url = URL(string: "https://bit.ly/3sspdFO")
        guard let requestUrl = url else { fatalError() }
        // 2 - Create URL Request
        var request = URLRequest(url: requestUrl)
        // 3 - Specify HTTP Method to use
        request.httpMethod = "GET"
        // 4 - Send HTTP Request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // 5 - Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            // 6 - Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            // 7 - Convert HTTP Response Data to a simple String or to specific struct
            if let data = data, let books = try? JSONDecoder().decode([Book].self, from: data) {
                print("books.count:\(books.count)")
                for (index,book) in books.enumerated() {
                    
                    print(book.title)
                    print(book.author)
                    self.books.append(book)
                    
                    if index == books.endIndex-1 {
                        // handling the last element
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } else {
                print("Invalid Response")
            }
        }.resume()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = books[indexPath.row].title
        cell?.detailTextLabel?.text = books[indexPath.row].author
        
        return cell ?? UITableViewCell()
    }
}
