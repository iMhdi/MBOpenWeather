//
//  AppNavigator.swift
//  MBOpenWeather_Example
//
//  Created by El Mahdi Boukhris on 22/07/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

enum Destination {
    case home
    case cityDetails
    case newCityForm
}

enum ViewControllerPresentationStyle {
    case root
    case push
    case present
}

class AppNavigator: UINavigationController, Navigator {
    
    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationBar.titleTextAttributes = textAttributes
        self.navigationBar.barTintColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func startApp() -> AppNavigator {
        let homeViewController      =   UIViewController.newInstance(of: HomeViewController())
        let navigationController    =   AppNavigator(rootViewController: homeViewController)
        
        return navigationController
    }
    
    // MARK: - Navigator
    func navigate(to destination: Destination, withStyle presentationStyle: ViewControllerPresentationStyle, andData dataDictionary:[String:Any]? = nil) {
        let viewController = ControllerFactory.newInstance(for: destination, withData: dataDictionary)
        
        switch presentationStyle {
        case .push:
            push(viewController: viewController)
            break
        case .present:
            present(viewController: viewController)
            break
        case .root:
            changeRoot(viewController: viewController)
            break
        }
    }
    
    private func present(viewController:UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    private func push(viewController:UIViewController) {
        pushViewController(viewController, animated: true)
    }
    
    private func changeRoot(viewController:UIViewController) {
        setViewControllers([viewController], animated: true)
    }
}
