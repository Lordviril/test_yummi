//
//  ListPictoresProtocols.swift
//  TestSoyYo
//
//  Created by Pedro Alonso Daza B on 6/09/20.
//  Copyright © 2020 Pedro Alonso Daza B. All rights reserved.
//

import Foundation
import UIKit

protocol InformationHealthyLifeViewToViewModel {
    func succesGetListPictores(nasaPictores:[NASAPictore])
    func succesGetPictores(nasaPictore:NASAPictore)
    func showError(error:String)
    //...

}

protocol InformationHealthyLifeViewModelToView:class {
    func getListLastPictores(controller:UIViewController, dateInit: Date)
    func getPictores(controller:UIViewController, datePictores: Date)
}
