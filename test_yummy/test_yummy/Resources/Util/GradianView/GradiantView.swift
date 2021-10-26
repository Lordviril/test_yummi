//
//  GradiantView.swift
//  TestSoyYo
//
//  Created by Pedro Alonso Daza B on 7/09/20.
//  Copyright © 2020 Pedro Alonso Daza B. All rights reserved.
//

import UIKit

class GradiantView: UIView {
    
    var colorAverage = UIColor.clear
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

         let nibName = "GradiantView"
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
    
    func setData(color:UIColor ) {
        colorAverage = color
        contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        
    }
    
    func updateAplha(alpha:CGFloat) {
        contentView.backgroundColor = colorAverage
        self.backgroundColor = colorAverage
        contentView.alpha = alpha
        self.alpha = alpha
    }

}
