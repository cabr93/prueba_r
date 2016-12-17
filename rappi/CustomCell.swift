//
//  CustomCell.swift
//  rappi
//
//  Created by Carlos Buitrago on 13/12/16.
//  Copyright © 2016 Carlos Buitrago. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var categoria: UILabel!
    @IBOutlet weak var numero: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
