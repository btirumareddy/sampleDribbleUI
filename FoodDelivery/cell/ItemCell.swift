/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
protocol ItemCellDelegate {
  func selectedItem(cartModel: CartViewModel)
}

final class ItemCell: UICollectionViewCell {
  var delegate : ItemCellDelegate?
  var section : Int?
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var selectionButton: UIButton!
  @IBOutlet weak var ingredientsLabel: UILabel!
  @IBOutlet weak var weightNLengthLabel: UILabel!
  // MARK: - IBOutlets
  @IBOutlet weak var addcartButton: UIButton!
  @IBOutlet weak var picture: UIImageView!

  // MARK: - View Life Cycle
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    
    guard let attributes = layoutAttributes as? CustomLayoutAttributes else {
      return
    }
  
    self.layer.cornerRadius = 8.0
    self.layer.masksToBounds = true
  }
  
  @IBAction func addtoCartAction(_ sender: UIButton) {
    let PreviousTile : String = sender.currentTitle!
    [UIView .transition(with: sender, duration: 1, options: .transitionCurlDown, animations: {
      sender.imageView?.image = nil
      sender.setTitle("added", for: .normal)
      sender.backgroundColor = .green
    }, completion: { (Bool) in
      sender.setTitle(PreviousTile, for: .normal)
      sender.backgroundColor = .black
    })]
    var cartModel : CartViewModel = CartViewModel.init(name: self.typeLabel.text, image: picture.image, price: addcartButton.titleLabel?.text)
    delegate?.selectedItem(cartModel: cartModel)
    
  }
  override func prepareForReuse() {
    super.prepareForReuse()
  
  
  //  picture.transform = .identity
  }
}
