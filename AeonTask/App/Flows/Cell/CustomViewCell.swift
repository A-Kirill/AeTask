//
//  CustomViewCell.swift
//  AeonTask
//
//  Created by Kirill Anisimov on 22.02.2021.
//

import UIKit

class CustomViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var curLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

        descriptionLabel.text = nil
        dateLabel.text = nil
        amountLabel.text = nil
        curLabel.text = nil
    }

}
