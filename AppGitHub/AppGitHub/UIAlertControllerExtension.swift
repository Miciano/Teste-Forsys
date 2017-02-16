//
//  UIAlertControllerExtension.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 16/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

//Extensio criada para encapsular o uso de uma alert, tendo sua implementação em um unico lugar
extension UIAlertController {
    
    static func alert(title:String, message:String, presenter: UIViewController, cancelButton:Bool, handler: ((UIAlertAction) -> Void)?)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(action)
        if cancelButton == true {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        
        presenter.present(alert, animated: true, completion: nil)
    }
}
