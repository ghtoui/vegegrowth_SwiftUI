//
//  VegeStatus.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/07.
//

import Foundation
import SwiftUI

enum VegeStatus: CaseIterable, Codable {
    case `default`
    case favorite
    case end
}

extension VegeStatus {
    public var rawValue: String {
        switch self {
        case .`default`:
            return L10n.statusDefault
        case .favorite:
            return L10n.statusFavorite
        case .end:
            return L10n.statusEnd
        }
    }
    
    func getIcon() -> ImageAsset {
        switch self {
        case .`default`:
            return Asset.Images.done
        case .favorite:
            return Asset.Images.favorite
        case .end:
            return Asset.Images.done
        }
    }
    
    func getTint() -> Color {
        switch self {
        case .`default`:
            return .clear
        case .favorite:
            return .red
        case .end:
            return .black
        }
    }
}
