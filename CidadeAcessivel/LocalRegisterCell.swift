//
//  OpnionRegisterCell.swift
//  CidadeAcessivel
//
//  Created by André Maciel on 3/16/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class LocalRegisterCell: UITableViewCell {

    @IBOutlet weak var labelField: UILabel!
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var fieldName: UITextField!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var buttonRegisterLocation: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
