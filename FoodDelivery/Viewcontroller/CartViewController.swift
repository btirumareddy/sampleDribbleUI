//
//  CartViewController.swift
//  JungleCup
//
//  Created by Bhanuja Tirumareddy on 17/12/20.
//  Copyright © 2020 RW Swift Team. All rights reserved.
//

import UIKit
protocol CartviewDelegate {
  func removeCartViewModelatIndex(index: Int)
}

class CartViewController: UIViewController {
 
  @IBOutlet weak var menuView: MenuView!
  var cartModels:[CartViewModel]?
  private var displayedTeam = 1
  
  @IBOutlet weak var cartTableView: UITableView!
   var cartviewDelegate : CartviewDelegate?
  static func prepareVC( withCartDependency cartVM: [CartViewModel]?) -> CartViewController {
    
    let cartViewController =  CartViewController(nibName: CartViewController.nameOfClass, bundle: nil)
    cartViewController.cartModels = cartVM!
    return cartViewController
  }

  override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = false
   
      menuView.delegate = self
      menuView.setButtonSelectedColors(index: displayedTeam)
   
    self.setupTableView()
        // Do any additional setup after loading the view.
    }
  func setupTableView()  {
      self.cartTableView .register(UINib(nibName: CartTableViewCell.nameOfClass, bundle: nil), forCellReuseIdentifier: CartTableViewCell.nameOfClass)
      self.cartTableView.isEditing = true
      self.cartTableView.delegate = self
      self.cartTableView.dataSource = self
      self.cartTableView.allowsSelectionDuringEditing = true
      self.cartTableView.tableFooterView = UIView .init(frame: .zero)
  }
  func deleteCartCell(itemindex: Int) {
    cartModels?.remove(at: itemindex)
    self.cartTableView .deleteRows(at: [IndexPath(row: itemindex, section: 0)], with: .middle)
    self.cartTableView.reloadData()
    cartviewDelegate?.removeCartViewModelatIndex(index: itemindex)
    
  }
}
extension CartViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cartModels!.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let tableCell: CartTableViewCell? = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.nameOfClass) as? CartTableViewCell
    guard let cell = tableCell else {return UITableViewCell() }
    let asset: CartViewModel = cartModels![indexPath.row] as! CartViewModel
    cell.configure(withcartCellVM: asset)
    return cell
  }
  
}
extension CartViewController : UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if (editingStyle == UITableViewCell.EditingStyle.delete) {
        let alert = UIAlertController(title: "Alert", message: "Are you sure to delete item from cart?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] action in
                        switch action.style{
                        case .default:
                          deleteCartCell(itemindex: indexPath.row)
                              print("default")
                        case .cancel:
                          alert.dismiss(animated: false, completion: nil)
          
                        case .destructive:
                              print("destructive")
                    
                  }}))
        self.present(alert, animated: true)
      }
  }
}

extension CartViewController: MenuViewDelegate {

  func reloadCollectionViewDataWithTeamIndex(_ index: Int) {
   
    menuView.setButtonSelectedColors(index: index)
    cartTableView?.reloadData()
  }
}
