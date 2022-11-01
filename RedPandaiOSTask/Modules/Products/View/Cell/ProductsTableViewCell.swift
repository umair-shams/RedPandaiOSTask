//
//  ProductsTableViewCell.swift
//  RedPandaiOSTask
//
//  Created by Umair Shams on 02/11/2022.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var productsNameLbl: UILabel!
    @IBOutlet weak var productsPriceLbl: UILabel!
    @IBOutlet weak var productsDescLbl: UILabel!
    @IBOutlet weak var productsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.productsImageView.layer.cornerRadius = 8
    }
}
