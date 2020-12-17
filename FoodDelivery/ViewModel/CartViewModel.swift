//
//  CartViewModel.swift
//  JungleCup
//
//  Created by Bhanuja Tirumareddy on 17/12/20.
//  Copyright © 2020 RW Swift Team. All rights reserved.
//

import UIKit

class CartViewModel: NSObject {
  let name: String?
  let image: UIImage?
  let price : String?
  
  init(name : String?, image: UIImage?, price : String?) {
    self.name = name
    self.image = image
    self.price = price
  }

}
