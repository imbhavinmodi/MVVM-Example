//
//  ProductCell.swift
//  Youtube MVVM Products
//
//  Created by Bhavin's on 08/06/23.
//

import UIKit

class ProductCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var productBackgroundView: UIView!
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var rateButton: UIButton!

    // MARK: - Variables
    var product: Product? {
        didSet { // Property Observer
            productDetailConfiguration()
        }
    }
    
    // MARK: -
    override func awakeFromNib() {
        super.awakeFromNib()
        productBackgroundView.clipsToBounds = false
        productBackgroundView.layer.cornerRadius = 15

        productImageView.layer.cornerRadius = 10

        self.productBackgroundView.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration() {
        guard let product else { return }
        productTitleLabel.text = product.title
        productCategoryLabel.text = product.category
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        productImageView.setImage(with: product.image)
    }
    
}

