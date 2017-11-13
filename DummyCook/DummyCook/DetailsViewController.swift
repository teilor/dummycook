//
//  DetailsViewController.swift
//  DummyCook
//
//  Created by Aline Ebone on 10/11/17.
//  Copyright © 2017 Aline Ebone. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var imagemReceita: UIImageView!
    @IBOutlet weak var textRequirements: UILabel!
    @IBOutlet var textoIngredientes: UILabel!
    @IBOutlet weak var tituloReceita: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textoIngredientes.text = data.textoIngredientes
        imagemReceita.image = UIImage(named: data.imagemReceita!)
        recipeTitle.text = data.nome
        ///recipeTitle.text =
    }
    
    var data: CDReceita! {
        didSet {
            //imagemReceita.layer.cornerRadius = 20
            print(data)
            
            //let passos = data.relationship!.allObjects as! [CDPasso]
            //imagemReceita.image = UIImage(named: data.imagemReceita!)
            
            
            //textoIngredientes.text = data.textoIngredientes
            //time.text = data.time
            //recipeTitle.text = data.nome
            //cost.text = data.cost
            //recipeImage.image = data.recipeImage
        }
    }
    

    @IBAction func goToSteps(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToSteps", sender: self)
    }
    
    
    @IBAction func goToStepsList(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToStepsList", sender: self)
    }
}
