//
//  DataCellPassosTableViewCell.swift
//  DummyCook
//
//  Created by vitor luiz lima demenighi on 13/11/17.
//  Copyright © 2017 Aline Ebone. All rights reserved.
//

import UIKit

class DataCellPassosTableViewCell: UITableViewCell {

    
   // @IBOutlet weak var imagemPasso: UIImageView!
    @IBOutlet weak var tituloPasso: UILabel!
    @IBOutlet weak var descricaoPasso: UILabel!
    
    @IBOutlet weak var stepNumberLabel: UILabel!
    
    var listaDePassos: [CDPasso]!
    
    var passoCelula: CDPasso! {
        didSet {
            tituloPasso.text = passoCelula.tituloDoPasso
            //imagemPasso.image = UIImage(named: passoCelula.imagemPasso!)
            descricaoPasso.text = passoCelula.texto
            
            //let ind = String(listaDePassos.index(after: 0))
            for index in 1...3 {
                stepNumberLabel.text = String(index)
            }
            
            
            
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
