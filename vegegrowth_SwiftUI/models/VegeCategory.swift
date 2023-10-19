//
//  VegeCategory.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/07.
//

import Foundation
import SwiftUI

enum VegeCategory: CaseIterable, Codable {
    case none
    case leaf
    case flower
    case other
}

extension VegeCategory {
    // 直接 = にするとL10nは使えないので、直接上書きする
    public var rawValue: String {
        switch self {
        case .none:
            return L10n.categoryNone
        case .leaf:
            return L10n.categoryLeaf
        case .flower:
            return L10n.categoryFlower
        case .other:
            return L10n.categoryOther
        }
    }
    
    func getIcon() -> ImageAsset {
        switch self {
        case .none:
            return Asset.Images.pending
        case .leaf:
            return Asset.Images.pottedPlant
        case .flower:
            return Asset.Images.flower
        case .other:
            return Asset.Images.pending
        }
    }
    
    func getTint() -> Color {
        switch self {
        case .none:
            return .clear
        case .leaf:
            return .green
        case .flower:
            return .red
        case .other:
            return .black
        }
    }
}
