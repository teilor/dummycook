//
//  ViewController.swift
//  DummyCook
//
//  Created by Aline Ebone on 09/11/17.
//  Copyright © 2017 Aline Ebone. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var dataArray = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        
        dataArray.append(DataModel(recipeImage: UIImage(named: "Nico_Rosberg")!, title: "abdsaiu", time: "385", serves: "Nico Rosberg", cost: "Mercedes"))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! DataCell
    
        return cell
    }

}
