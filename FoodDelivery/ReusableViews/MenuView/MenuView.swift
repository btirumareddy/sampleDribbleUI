//
//  MenuView.swift
//  FoodDelivery
//
//  Created by Bhanuja Tirumareddy on 17/12/20.
//

import UIKit

protocol MenuViewDelegate {
  func reloadCollectionViewDataWithTeamIndex(_ index: Int)
}


final class MenuView: UICollectionReusableView {

  // MARK: - Properties

  var delegate: MenuViewDelegate?
  // MARK: - View Life Cycle
  
  // MARK: - View Life Cycle
  override func prepareForReuse() {
    super.prepareForReuse()
    delegate = nil
  }
  
  public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    guard let customFlowLayoutAttributes = layoutAttributes as? CustomLayoutAttributes else {
      return
    }
    roundCorners(corners: [.topLeft, .topRight], radius: customFlowLayoutAttributes.roundrCornerRadius)
    
  }
 
  func setButtonSelectedColors(index : Int) {
    let allButtonTags = [1, 2, 3]
        let currentButtonTag = index

        allButtonTags.filter { $0 != currentButtonTag }.forEach { tag in
            if let button = self.viewWithTag(tag) as? UIButton {
                button.setTitleColor(UIColor.darkGray, for: .normal)
                //button.isSelected = false
            }
            else {
              
            }
        }
    
    if let button = self.viewWithTag(currentButtonTag) as? UIButton {
      button.setTitleColor(UIColor.black, for: .normal)
    }
    
        
  }
  override func layoutSubviews() {
      super.layoutSubviews()
      
      
  }
}

// MARK: - IBActions
extension MenuView {

  @IBAction func tappedButton(_ sender: UIButton) {

   
    delegate?.reloadCollectionViewDataWithTeamIndex(sender.tag)

  }
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
          let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
          let mask = CAShapeLayer()
          mask.path = path.cgPath
          layer.mask = mask
      }
}
