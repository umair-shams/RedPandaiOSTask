//
//  ViewController.swift
//  RedPandaiOSTask
//
//  Created by Umair Shams on 27/10/2022.
//

import UIKit
import Firebase
import SDWebImage

class ProductsViewController: UIViewController {

    @IBOutlet weak var productsLoadingView: UIActivityIndicatorView!
    @IBOutlet weak var productsTableView: UITableView!
        
    private let productsViewModel = ProductsViewModel(databaseManager: FirebaseManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productsTableView.delegate = self
        self.productsTableView.dataSource = self
        self.bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        productsLoadingView.startAnimating()
        productsViewModel.fetch()
    }
    
    func bindData() {
        productsViewModel.isFethcingCompleted.bind {
            guard let isCompleted = $0 else { return }
            
            if isCompleted {
                DispatchQueue.main.async {
                    self.productsLoadingView.stopAnimating()
                    self.productsLoadingView.isHidden = true
                    self.productsTableView.reloadData()
                }
            }
        }
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsViewModel.productsData.productIds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell", for: indexPath) as! ProductsTableViewCell
        cell.productsNameLbl.text = productsViewModel.productsData.productNames[indexPath.row]
        cell.productsPriceLbl.text = "₹ \(productsViewModel.productsData.productPrices[indexPath.row])"
        cell.productsDescLbl.text = productsViewModel.productsData.productDescriptions[indexPath.row]
        
        cell.productsImageView.sd_setImage(with: URL(string: productsViewModel.productsData.productImages[indexPath.row]))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
