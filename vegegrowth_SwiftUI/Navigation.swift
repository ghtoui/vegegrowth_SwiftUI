//
//  Navigation.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/07.
//

import UIKit
import Foundation

enum ScreenRoute {
    case home
    case takePicture
    case manage
}

extension ScreenRoute {
    func createViewController() -> UIViewController {
        switch self {
        case .home:
            let vc = HomeViewController()
            return vc
            
        case .takePicture:
            let vc = TakePictureViewController()
            return vc
            
        case .manage:
            let vc = ManageViewController()
            return vc
        }
    }
}
