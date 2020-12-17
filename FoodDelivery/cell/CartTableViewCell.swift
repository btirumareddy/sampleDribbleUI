//
//  CartTableViewCell.swift
//  JungleCup
//
//  Created by Bhanuja Tirumareddy on 17/12/20.
//  Copyright © 2020 RW Swift Team. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell{

  @IBOutlet weak var moneyLabel: UILabel!
  @IBOutlet weak var reciepeIMageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   func configure(withcartCellVM cartCellVM:CartViewModel) {
    self.moneyLabel.text = String(describing: cartCellVM.price)
    
    self.reciepeIMageView.image = cartCellVM.image
    self.nameLabel.text = cartCellVM.name
    
  }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
