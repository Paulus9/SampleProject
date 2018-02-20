//
//  CustomTableViewCell.swift
//  Sample
//
//  Created by SysBig on 03/11/17.
//  Copyright © 2017 SysBig. All rights reserved.
//

import UIKit
protocol TapDelegate:class {
    func didTapOnCell()
}

class CustomTableViewCell: UITableViewCell {

    weak var delegate: TapDelegate?
    @IBOutlet weak var dataLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedOnCell))
        self.contentView.addGestureRecognizer(tapGesture)

    }
    @objc func tappedOnCell()
    {
        self.delegate?.didTapOnCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
