//
//  DetailsViewController.swift
//  DummyCook
//
//  Created by Aline Ebone on 10/11/17.
//  Copyright © 2017 Aline Ebone. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var recipeTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTitle.text = "Index da receita clicada: " + String(myIndex)
    }

    @IBAction func goToSteps(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToSteps", sender: self)
    }
    
    
    @IBAction func goToStepsList(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToStepsList", sender: self)
    }
}
