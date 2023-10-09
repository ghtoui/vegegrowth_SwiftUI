//
//  HomeMenu.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/09.
//

import Foundation

enum MenuStatus: CaseIterable {
    case none
    case delete
    case edit
}

extension MenuStatus {
    public var rawValue: String {
        switch self {
        case .none:
            return L10n.noneText
        case .delete:
            return L10n.deleteText
        case .edit:
            return L10n.editText
        }
    }
    
    func getIcon() -> ImageAsset {
        switch self {
        case .none:
            return Asset.Images.menu
        case .delete:
            return Asset.Images.delete
        case .edit:
            return Asset.Images.edit
        }
    }
}
