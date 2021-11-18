//
//  TableViewController.swift
//  WebServices
//
//  Created by Mobark Alseif on 12/04/1443 AH.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {
    
    var books : [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        simpleRequest()
    }
    // MARK: - simple Request
    func simpleRequest() {
         //1 - Create Request
        let request = AF.request("https://bit.ly/3sspdFO",method: .get)
         //2- Convert HTTP Response Data to a simple String or to specific struct
        request.responseDecodable(of: [Book].self) { (response) in
            guard let books = response.value else { return }
            DispatchQueue.main.async {
                self.books = books
                self.tableView.reloadData()
            }
        }

//
//        // 1 - Create URL
//        let url = URL(string: "https://bit.ly/3sspdFO")
//        guard let requestUrl = url else { fatalError() }
//        //---------------------------------------
//        // 2 - Create URL Request
//        var request = URLRequest(url: requestUrl)
//        // 3 - Specify HTTP Method to use
//        request.httpMethod = "GET"
//        // 4 - Specify HTTP Method to use
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        //---------------------------------------
//        // 5 - Send HTTP Request
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            // 6 - Check if Error took place
//            if let error = error {
//                print("Error took place \(error)")
//                return
//            }
//            // 7 - Read HTTP Response Status code
//            if let response = response as? HTTPURLResponse {
//                print("Response HTTP Status code: \(response.statusCode)")
//            }
//            // 8 - Convert HTTP Response Data to a simple String or to specific struct
//
//            if let data = data, let books = try? JSONDecoder().decode([Book].self, from: data) {
//
//                DispatchQueue.main.async {
//                    self.books = books
//                    self.tableView.reloadData()
//                }
//
////                print(books.count)
////                for book in books {
////                    print(book.author)
////                    print(book.title)
////                }
//
//            }else {
//                print("Invalid Response")
//            }
//
//
//
//
//            //            if let data = data, let dataString = String(data: data, encoding: .utf8) {
//            //                print(dataString)
//            //            } else {
//            //                print("Invalid Response")
//            //            }
//        }
//        task.resume()
        
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
