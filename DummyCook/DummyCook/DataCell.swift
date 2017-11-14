//
//  DataCell.swift
//  DummyCook
//
//  Created by Aline Ebone on 09/11/17.
//  Copyright © 2017 Aline Ebone. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var serves: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var tableViewCell: UIView!
    
    var data: CDReceita! {
        didSet {
            recipeImage.layer.cornerRadius = 20
            tableViewCell.layer.cornerRadius = 20
            
            
            recipeTitle = data.nome!
            
            
            //let passos = data.relationship!.allObjects as! [CDPasso]
            recipeImage.image = UIImage(named: data.imagemReceita!)
            
            
            title.text = data.nome
            time.text = data.time
            serves.text = data.serves
            cost.text = data.cost
            //recipeImage.image = data.recipeImage
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
