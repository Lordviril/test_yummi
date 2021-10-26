//
//  CollapserView.swift
//  TestSoyYo
//
//  Created by Pedro Alonso Daza B on 7/09/20.
//  Copyright © 2020 Pedro Alonso Daza B. All rights reserved.
//

import UIKit

class CollapserView: UIView {

    var heigtFrame:CGFloat = 200
    @IBOutlet weak var pictoreImageView: UIImageView!
    @IBOutlet weak var gradiantView: GradiantView!
    @IBOutlet weak var contentView: UIView!
    
    private var isFirstCall = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //viewSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        viewSetup()
        
    }
    
    private func loadViewFromNib() -> UIView? {

         let nibName = "CollapserView"
         let bundle = Bundle(for: type(of: self))
         let nib = UINib(nibName: nibName, bundle: bundle)
         return nib.instantiate(withOwner: self, options: nil).first as? UIView
     }
    
    private func viewSetup() {
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        if !isFirstCall {
            self.addSubview(view)
            isFirstCall = true
        }
        
        contentView = view
        
    }
    
    func setData(color:UIColor, scrollView: UIScrollView ) {
        gradiantView.setData(color: color)
        heigtFrame = self.frame.height
        let offsetY = 1 - (heigtFrame / 2)
        scrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: false)
        self.backgroundColor = UIColor.clear
        
    }

}

extension CollapserView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = 1 - (heigtFrame / 2)

        let height = contentView.frame.height / 2.0
        var offset = (((height - (scrollView.contentOffset.y - offsetY)) * 1.0) / height)
        if offset >= 1 {
            offset = 1
        }
        gradiantView.updateAplha(alpha: (1 - offset))
        var heigtFrame1 = (heigtFrame - scrollView.contentOffset.y) + offsetY
        if heigtFrame1 <= heigtFrame / 2 {
            heigtFrame1 = heigtFrame / 2
        }
        self.contentView.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: heigtFrame1)

        
    }
    
}
