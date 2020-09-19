//
//  ViewController.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 19/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://api.androidhive.info/contacts/")
            .response { response in


                guard response.error == nil else {
                    debugPrint(response.error.debugDescription)
                    return }

                guard let data = response.data else { return }
                
                guard let dataDecoded = try? JSONDecoder().decode(Data.self, from: data) else { return }
                debugPrint(dataDecoded)
        }
    }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = "• apple"
        return cell
    }


}

struct Data: Decodable {
    var contacts: [UserInfo]

    struct UserInfo: Decodable {
        var name: String
    }
}
