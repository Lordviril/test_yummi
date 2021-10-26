//
//  Alerts.swift
//  TestSoyYo
//
//  Created by Pedro Alonso Daza B on 8/09/20.
//  Copyright © 2020 Pedro Alonso Daza B. All rights reserved.
//

import Foundation
import UIKit

func shoeAlertWithMessagge(controller: UIViewController, messagge: String) {
    let alert = UIAlertController(title: "Error", message: messagge, preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))

    controller.present(alert, animated: true)
}
