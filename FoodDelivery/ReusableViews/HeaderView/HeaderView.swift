//
//  HeaderView.swift
//  FoodDelivery
//
//  Created by Bhanuja Tirumareddy on 17/12/20.
//

import UIKit
protocol HeaderViewDelegate {
  func reloadMenuViewDataWithAlpha(alpha: CGFloat)
}
final class HeaderView: UICollectionReusableView,UIScrollViewDelegate {
  // MARK: - Properties
  var delegate: HeaderViewDelegate?
  // MARK: - IBOutlets
  @IBOutlet weak var overlayView: UIView!
  @IBOutlet weak var scrollView: UIScrollView!{
           didSet{
               scrollView.delegate = self
           }
       
   }
   @IBOutlet weak var pageControl: UIPageControl!
   var slides:[Slide] = [];
  // MARK: - Life Cycle
  
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    
  }
  
  public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    guard let customFlowLayoutAttributes = layoutAttributes as? CustomLayoutAttributes else {
      return
    }
    overlayView?.alpha = customFlowLayoutAttributes.headerOverlayAlpha
    
    print("header overlayalpah",customFlowLayoutAttributes.headerOverlayAlpha)
  
    if (customFlowLayoutAttributes.headerOverlayAlpha > 0.30) {
      self.transform = customFlowLayoutAttributes.parallax
   }
    delegate?.reloadMenuViewDataWithAlpha(alpha: customFlowLayoutAttributes.headerOverlayAlpha)
    slides = createSlides()
    setupSlideScrollView(slides: slides)
    
    pageControl.numberOfPages = slides.count
    pageControl.currentPage = 0
    self.bringSubviewToFront(pageControl)
  }
  func createSlides() -> [Slide] {
    
    let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
    slide1.imageView.image = UIImage(named: "maxresdefault1")
    
    let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
    slide2.imageView.image = UIImage(named: "maxresdefault2")
    
    
    let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
    slide3.imageView.image = UIImage(named: "maxresdefault3")
    
    
    return [slide1, slide2, slide3]
  }
   func setupSlideScrollView(slides : [Slide]) {
   scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
   scrollView.contentSize = CGSize(width: self.frame.width * CGFloat(slides.count), height: self.frame.height)
   scrollView.isPagingEnabled = true
   
   for i in 0 ..< slides.count {
       slides[i].frame = CGRect(x: self.frame.width * CGFloat(i), y: 0, width: self.frame.width, height: self.frame.height)
       scrollView.addSubview(slides[i])
   }
}


/*
* default function called when view is scolled. In order to enable callback
* when scrollview is scrolled, the below code needs to be called:
* slideScrollView.delegate = self or
*/
func scrollViewDidScroll(_ scrollView: UIScrollView) {
   let pageIndex = round(scrollView.contentOffset.x/self.frame.width)
   pageControl.currentPage = Int(pageIndex)
   
   let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
   let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
   
   // vertical
   let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
   let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
   
   let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
   let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
   
   
   /*
    * below code changes the background color of view on paging the scrollview
    */
//        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
   

   /*
    * below code scales the imageview on paging the scrollview
    */
//   let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
//
//   if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
//
//       slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
//       slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
//
//   } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
//       slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
//       slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
//   }
//   } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
//       slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
//       slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
//
//   } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
//       slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
//       slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
//   }
}




func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
   if(pageControl.currentPage == 0) {
       //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
       //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
       //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1
       
       let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
       pageControl.pageIndicatorTintColor = pageUnselectedColor
   
       
       let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
       slides[pageControl.currentPage].backgroundColor = bgColor
       
       let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
       pageControl.currentPageIndicatorTintColor = pageSelectedColor
   }
}


func fade(fromRed: CGFloat,
         fromGreen: CGFloat,
         fromBlue: CGFloat,
         fromAlpha: CGFloat,
         toRed: CGFloat,
         toGreen: CGFloat,
         toBlue: CGFloat,
         toAlpha: CGFloat,
         withPercentage percentage: CGFloat) -> UIColor {
   
   let red: CGFloat = (toRed - fromRed) * percentage + fromRed
   let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
   let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
   let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
   
   // return the fade colour
   return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}
  
}
