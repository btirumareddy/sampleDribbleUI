//
//  CustomLayoutAttributes.swift
//  JungleCup
//
//  Created by Bhanuja Tirumareddy on 17/12/20.
//  Copyright © 2020 RW Swift Team. All rights reserved.
//
import UIKit

final class CustomLayoutAttributes: UICollectionViewLayoutAttributes {

  // MARK: - Properties
  var parallax: CGAffineTransform = .identity
  var initialOrigin: CGPoint = .zero
  var headerOverlayAlpha = CGFloat(0)
  var roundrCornerRadius = CGFloat(0)
  var headerHeight = CGFloat(0)

  // MARK: - Life Cycle
  override func copy(with zone: NSZone?) -> Any {
    guard let copiedAttributes = super.copy(with: zone) as? CustomLayoutAttributes else {
      return super.copy(with: zone)
    }

    copiedAttributes.parallax = parallax
    copiedAttributes.initialOrigin = initialOrigin
    copiedAttributes.headerOverlayAlpha = headerOverlayAlpha
    copiedAttributes.roundrCornerRadius = roundrCornerRadius
    
    return copiedAttributes
  }
  
  override func isEqual(_ object: Any?) -> Bool {
    guard let otherAttributes = object as? CustomLayoutAttributes else {
      return false
    }

    if NSValue(cgAffineTransform: otherAttributes.parallax) != NSValue(cgAffineTransform: parallax)
      || otherAttributes.initialOrigin != initialOrigin
      || otherAttributes.headerOverlayAlpha != headerOverlayAlpha || otherAttributes.roundrCornerRadius != roundrCornerRadius{
        return false
    }

    return super.isEqual(object)
  }
}
