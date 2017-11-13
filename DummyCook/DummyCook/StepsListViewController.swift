//
//  StepsListViewController.swift
//  DummyCook
//
//  Created by Aline Ebone on 13/11/17.
//  Copyright © 2017 Aline Ebone. All rights reserved.
//

import UIKit

class StepsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewPassos: UITableView!

    @IBOutlet weak var tituloReceita: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tituloReceita.text = "AAA"
        
        print(listaDePassos)
        print(listaDePassos[1].texto!)
        print(listaDePassos[1].imagemPasso!)

    
        tableViewPassos.reloadData()
    }
    
    var listaDePassos: [CDPasso]!

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
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        myIndex = indexPath.row
//        performSegue(withIdentifier: "segue", sender: self)
//    }
//
}
