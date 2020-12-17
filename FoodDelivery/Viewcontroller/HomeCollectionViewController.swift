//
//  HomeCollectionViewController.swift
//  FoodDelivery
//
//  Created by Bhanuja Tirumareddy on 18/12/20.
//

import UIKit

final class HomeCollectionViewController: UICollectionViewController {
 
  // MARK: - Properties
  var customLayout: CustomLayout? {
    return collectionView?.collectionViewLayout as? CustomLayout
  }

  private let teams: [Team] = [Pizza(), Sushi(), Drinks()]
  private let sections = ["Veg", "Non-Veg"]
  private var displayedTeam = 1
  var cartModels:[CartViewModel]?
  var floatingButton : UIButton?
  var badgeLabel : UIButton?
  override var prefersStatusBarHidden: Bool {
    return true
  }

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
cartModels = []
    setupCollectionViewLayout()
    setupFloatingButton()
  }
}

private extension HomeCollectionViewController {

  func setupFloatingButton() {
    floatingButton = UIButton()
    floatingButton?.frame = CGRect(x: 285, y: self.collectionView.frame.size.height - 50, width: 50, height: 50)
   
    floatingButton?.setImage(UIImage.init(named: "shopping-cart"), for: .normal)
    floatingButton?.backgroundColor = .blue
    floatingButton?.clipsToBounds = true
    floatingButton?.layer.cornerRadius = (floatingButton?.frame.size.width)!/2
    floatingButton?.layer.borderWidth = 1.0
    floatingButton?.layer.borderColor = UIColor.white.cgColor
    floatingButton!.addTarget(self,action:#selector(buttonClicked(sender:)),
                              for:.touchUpInside)
  
    badgeLabel  = UIButton()
    badgeLabel!.frame = CGRect(x: (floatingButton?.frame.origin.x)! + 35, y:self.collectionView.frame.size.height - 52, width: 16, height: 16)
    badgeLabel?.backgroundColor = .green
    badgeLabel?.clipsToBounds = true
    badgeLabel?.layer.cornerRadius = (badgeLabel?.frame.size.width)!/2
   // floatingButton?.addSubview(badgeLabel!)
    
    collectionView.addSubview(floatingButton!)
   collectionView.addSubview(badgeLabel!)
    
  }
  func setupCartElements() {
    badgeLabel?.setTitleColor(.black, for: .normal)
    badgeLabel?.setTitle(String(cartModels!.count), for: .normal)
    badgeLabel?.titleLabel?.font = UIFont.init(name: "system", size: 4)
    
  }
  internal override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = true
  }
  @objc func buttonClicked(sender:UIButton) {
    let vc = CartViewController.prepareVC(withCartDependency: self.cartModels)
    vc.cartviewDelegate = self
    //self.present(vc, animated: false, completion: nil)
    self.navigationController?.pushViewController(vc, animated: false)
    
  }
  func setupCollectionViewLayout() {
    guard let collectionView = collectionView, let customLayout = customLayout else { return }

    collectionView.register(
      UINib(nibName: "HeaderView", bundle: nil),
      forSupplementaryViewOfKind: CustomLayout.Element.header.kind,
      withReuseIdentifier: CustomLayout.Element.header.id
    )

    collectionView.register(
      UINib(nibName: "MenuView", bundle: nil),
      forSupplementaryViewOfKind: CustomLayout.Element.menu.kind,
      withReuseIdentifier: CustomLayout.Element.menu.id
    )

    customLayout.settings.itemSize = CGSize(width: collectionView.frame.width-60, height: 350)
    customLayout.settings.headerSize = CGSize(width: collectionView.frame.width, height: 400 )
    customLayout.settings.menuSize = CGSize(width: collectionView.frame.width, height: 70)
    customLayout.settings.sectionsHeaderSize = CGSize(width: collectionView.frame.width, height: 50)
    customLayout.settings.sectionsFooterSize = CGSize(width: collectionView.frame.width, height: 0)
    customLayout.settings.isHeaderStretchy = true
    customLayout.settings.isAlphaOnHeaderActive = true
    customLayout.settings.headerOverlayMaxAlphaValue = CGFloat(0.6)
    customLayout.settings.isMenuSticky = true
    customLayout.settings.isSectionHeadersSticky = true
    customLayout.settings.isParallaxOnCellsEnabled = true
    customLayout.settings.maxParallaxOffset = 60
    customLayout.settings.minimumInteritemSpacing = 30
    customLayout.settings.minimumLineSpacing = 30
  }
}

//MARK: - UICollectionViewDataSource
extension HomeCollectionViewController {
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {

         let  off = scrollView.contentOffset.y

    floatingButton!.frame = CGRect(x: 285, y:   off + (self.collectionView.frame.size.height-50), width: floatingButton!.frame.size.width, height: floatingButton!.frame.size.height)
    badgeLabel!.frame = CGRect(x: (floatingButton?.frame.origin.x)! + 35, y:   off + (self.collectionView.frame.size.height-52), width: badgeLabel!.frame.size.width, height: badgeLabel!.frame.size.height)
    
  }
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sections.count
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return teams[displayedTeam-1].playerPictures[section].count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomLayout.Element.cell.id, for: indexPath)
    if let itemCell = cell as? ItemCell {
      itemCell.delegate = self
      itemCell.addcartButton.tag = indexPath.item
      itemCell.section = indexPath.section
      itemCell.addcartButton.setTitle(teams[displayedTeam-1].values[indexPath.item], for: .normal)
      itemCell.picture.image = UIImage(named: teams[displayedTeam-1].playerPictures[indexPath.section][indexPath.item])
    }
    return cell
  }
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CustomLayout.Element.sectionHeader.id, for: indexPath)
      if let sectionHeaderView = supplementaryView as? SectionHeaderView {
        sectionHeaderView.title.text = sections[indexPath.section]
      }
      return supplementaryView

    case UICollectionView.elementKindSectionFooter:
      let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CustomLayout.Element.sectionFooter.id, for: indexPath)
      if let sectionFooterView = supplementaryView as? SectionFooterView {
        sectionFooterView.mark.text = "Strength: \(teams[displayedTeam-1].marks[indexPath.section])"
      }
      return supplementaryView

    case CustomLayout.Element.header.kind:
      let topHeaderView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: CustomLayout.Element.header.id,
        for: indexPath
      )
      return topHeaderView

    case CustomLayout.Element.menu.kind:
      let menuView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: CustomLayout.Element.menu.id,
        for: indexPath
      )
      if let menuView = menuView as? MenuView {
        menuView.delegate = self
        menuView.setButtonSelectedColors(index: displayedTeam)
      }
      return menuView

    default:
      fatalError("Unexpected element kind")
    }
  }
}

// MARK: - MenuViewDelegate
extension HomeCollectionViewController: MenuViewDelegate {

  func reloadCollectionViewDataWithTeamIndex(_ index: Int) {
    displayedTeam = index
    collectionView?.reloadData()
  }
}
extension HomeCollectionViewController: ItemCellDelegate {
  func selectedItem(cartModel: CartViewModel) {
    cartModels?.append(cartModel)
    setupCartElements()
  
  }
}
extension HomeCollectionViewController : CartviewDelegate {
  func removeCartViewModelatIndex(index: Int) {
    cartModels?.remove(at: index)
    setupCartElements()
  }
}
