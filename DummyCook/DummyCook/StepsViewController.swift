//
//  StepsViewController.swift
//  DummyCook
//
//  Created by Aline Ebone on 13/11/17.
//  Copyright © 2017 Aline Ebone. All rights reserved.
//

import UIKit

class StepsViewController: UIViewController {
    
    
    @IBOutlet weak var stepsTitle: UILabel!
    @IBOutlet weak var stepsImage: UIImageView!
    @IBOutlet weak var stepsViewVideo: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var descricaoPasso: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stepsTitle.text = listaDePassos2[index].tituloDoPasso
        stepsImage.image = UIImage(named: listaDePassos2[index].imagemPasso!)
        //VIDEO
        descricaoPasso.text = listaDePassos2[index].texto
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        stepsTitle.text = listaDePassos2[index].tituloDoPasso
        stepsImage.image = UIImage(named: listaDePassos2[index].imagemPasso!)
        //VIDEO
        descricaoPasso.text = listaDePassos2[index].texto
    }
    
    
    
    @IBAction func botaoProximo(_ sender: Any) {
        if(index != (listaDePassos2.count - 1)){
            index = index + 1
            stepsTitle.text = listaDePassos2[index].tituloDoPasso
            stepsImage.image = UIImage(named: listaDePassos2[index].imagemPasso!)
            //VIDEO
            descricaoPasso.text = listaDePassos2[index].texto
        }
    }
    
    
    
    @IBAction func botaoVolta(_ sender: Any) {
        if(index != 0){
            //self.navigationController?.popViewController(animated: true)
            index = index - 1
            stepsTitle.text = listaDePassos2[index].tituloDoPasso
            stepsImage.image = UIImage(named: listaDePassos2[index].imagemPasso!)
            //VIDEO
            descricaoPasso.text = listaDePassos2[index].texto
        }
    }
    
    var listaDePassos2: [CDPasso]!
    var index: Int!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "segueProximoPasso" ) {
            let destinoIniciaReceita = segue.destination as! StepsViewController
            if(index != (listaDePassos2.count - 1)){
                index = index + 1
                destinoIniciaReceita.listaDePassos2 = listaDePassos2
                destinoIniciaReceita.index = index
            }
            else{
                print("Nao há mais passos")
                destinoIniciaReceita.listaDePassos2 = listaDePassos2
                destinoIniciaReceita.index = index
            }
        }
        
        if( segue.identifier == "segueVoltaPasso" ) {
            let destinoIniciaReceita = segue.destination as! StepsViewController
            if(index != 0){
                index = index - 1
                destinoIniciaReceita.listaDePassos2 = listaDePassos2
                destinoIniciaReceita.index = index
            }
            else{
                print("Nao há mais passos")
                destinoIniciaReceita.listaDePassos2 = listaDePassos2
                destinoIniciaReceita.index = index
            }
        }
     }
        */
        
    

}
