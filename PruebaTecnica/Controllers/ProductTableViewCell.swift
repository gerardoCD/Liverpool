//
//  ProductTableViewCell.swift
//  PruebaTecnica
//
//  Created by Gerardo Castillo Duran  on 19/04/20.
//  Copyright © 2020 Gerardo Castillo Duran . All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        descriptionLabel.sizeToFit()

        // Configure the view for the selected state
    }

}
