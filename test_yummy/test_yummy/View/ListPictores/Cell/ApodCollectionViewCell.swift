//
//  ApodCollectionViewCell.swift
//  TestSoyYo
//
//  Created by Pedro Alonso Daza B on 7/09/20.
//  Copyright © 2020 Pedro Alonso Daza B. All rights reserved.
//

import UIKit
import SDWebImage

class ApodCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pictoreImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    static let identifier = Constants.APOD_CELL
    override var reuseIdentifier: String? { return ApodCollectionViewCell.identifier }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(nasaPictore: NASAPictore) {
        titleLabel.text = nasaPictore.title
        subTitleLabel.text = nasaPictore.date
        //let urlT = URL(fileURLWithPath: nasaPictore.url)
        if let url1 = URL(string: nasaPictore.url) {
            pictoreImageView.sd_setImage(with: url1)
        }
        
    }
    

}
