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
    
    var data: DataModel! {
        didSet {
            title.text = data.title
            time.text = data.time
            serves.text = data.serves
            cost.text = data.cost
            recipeImage.image = data.recipeImage
        }
    }
}
