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
        
        dataArray.append(DataModel(recipeImage: UIImage(named: "1")!, title: "Double Layer Pumpkin Cheesecake", time: "4h10m", serves: "8", cost: "U$ 18.00"))
        dataArray.append(DataModel(recipeImage: UIImage(named: "2")!, title: "Pumpkin Ginger Cupcakes", time: "1h30m", serves: "24", cost: "U$ 23.00"))
        dataArray.append(DataModel(recipeImage: UIImage(named: "3")!, title: "Oven Baked Omelet", time: "49m", serves: "6", cost: "U$ 5,00"))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! DataCell
    
        return cell
    }

}
