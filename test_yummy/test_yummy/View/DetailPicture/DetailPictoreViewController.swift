//
//  DetailPictoreViewController.swift
//  TestSoyYo
//
//  Created by Pedro Alonso Daza B on 7/09/20.
//  Copyright © 2020 Pedro Alonso Daza B. All rights reserved.
//

import UIKit

class DetailPictoreViewController: UIViewController {
    @IBOutlet weak var collapserView: CollapserView!
    @IBOutlet weak var generalScrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mediaLabel: UILabel!
    
    var nasaPictore: NASAPictore?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let image = collapserView.pictoreImageView.image {
            if let color = image.averageColor {
                collapserView.setData(color: color, scrollView: generalScrollView)
                return
            }
            
        }
        
        collapserView.setData(color: UIColor.clear, scrollView: generalScrollView)
    }
    // MARK: - SetUp
    func setUp() {
        if let nasaPci = nasaPictore {
            collapserView.pictoreImageView.downloaded(from: nasaPci.url, contentMode: .scaleToFill)
            titleLabel.text = nasaPci.title
            descriptionLabel.text = nasaPci.explanation
            mediaLabel.text = nasaPci.media_type
            dateLabel.text = nasaPci.date
            
        }
        generalScrollView.delegate = collapserView
        generalScrollView.contentSize = CGSize(width: generalScrollView.frame.width, height: 800)
        
    }

    // MARK: - Actions
    @IBAction func closePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
