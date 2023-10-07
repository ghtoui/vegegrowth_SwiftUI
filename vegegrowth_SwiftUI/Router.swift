//
//  Router.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/07.
//

import Foundation
import UIKit

class Router {
    static let shared = Router()
    
    func navigateTo(screen: ScreenRoute, from: UIViewController, animated: Bool) {
        let vc = screen.createViewController()
        from.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func back(from: UIViewController, animated: Bool) {
        from.navigationController?.pushViewController(from, animated: animated)
    }
}
