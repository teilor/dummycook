//
//  StepsListViewController.swift
//  DummyCook
//
//  Created by Aline Ebone on 13/11/17.
//  Copyright © 2017 Aline Ebone. All rights reserved.
//

import UIKit
import CoreData

class StepsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewPassos: UITableView!
    @IBOutlet weak var tituloReceita: UILabel!
    //var listaDePassos: [CDPasso]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Step 1 of " + String(listaDePassos.count)
        self.tableViewPassos.dataSource = self
        self.tableViewPassos.delegate = self
        tituloReceita.text = recipeTitle
        tableViewPassos.reloadData()
    }
    
    var listaDePassos: [CDPasso]!
    var passoCelula: CDPasso!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDePassos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       let cell = tableView.dequeueReusableCell(withIdentifier: "cellPasso", for: indexPath) as! DataCellPassosTableViewCell
       cell.passoCelula = listaDePassos[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segueIniciaReceita", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "segueIniciaReceita" ) {
            let dest = segue.destination as! StepsViewController
            dest.listaDePassos2 = listaDePassos
            dest.index = myIndex
        }
        
    }
    
}
