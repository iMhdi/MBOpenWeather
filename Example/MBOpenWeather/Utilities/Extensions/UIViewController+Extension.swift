//
//  UIViewController+Extension.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

let LOADING_VIEW_TAG        =   789

extension UIViewController {
    
    static func newInstance<VC: UIViewController>(of instanceType: VC) -> VC {
        let defaultNib = NSStringFromClass(type(of: instanceType)).components(separatedBy: ".").dropFirst().joined(separator: ".")

        return VC(nibName: defaultNib, bundle: nil)
    }
    
    func showLoading() -> Void {
        let spinnerView = UIView.init(frame: view.bounds)
        spinnerView.tag = LOADING_VIEW_TAG
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            UIApplication.shared.keyWindow!.addSubview(spinnerView)
        }
    }
    
    func hideLoading() -> Void {
        UIApplication.shared.keyWindow!.viewWithTag(LOADING_VIEW_TAG)?.removeFromSuperview()
    }
    
    var navController:AppNavigator {
        return self.navigationController as! AppNavigator
    }
    
    func displayAlert(withMessage message: String, andCompletionHandler handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        //We add buttons to the alert controller by creating UIAlertActions:
        let actionOk = UIAlertAction(title: "OK", style: .default, handler: handler)

        alertController.addAction(actionOk)
        self.present(alertController, animated: true, completion: nil)
    }
}
