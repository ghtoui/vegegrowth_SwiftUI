//
//  VegeSortStatus.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/08.
//

import Foundation
import SwiftUI

enum VegeSortStatus: CaseIterable, Hashable {
    case category(VegeCategory)
    case status(VegeStatus)
}

extension VegeSortStatus {
    static var allCases: [VegeSortStatus] {
        var cases: [VegeSortStatus] = []
        VegeCategory.allCases.forEach { category in
            cases.append(.category(category))
        }
        VegeStatus.allCases.forEach { status in
            cases.append(.status(status))
        }
        return cases
    }
    
    public var rawValue: String {
        switch self {
        case .category(let category):
            return category.rawValue
        case .status(let status):
            return status.rawValue
        }
    }
    
    func getIcon() -> ImageAsset {
        switch self {
        case .category(let category):
            return category.getIcon()
        case .status(let status):
            return status.getIcon()
        }
    }
    
    func getTint() -> Color {
        switch self {
        case .category(let category):
            return category.getTint()
        case .status(let status):
            return status.getTint()
        }
    }
    
    // SortStatusとcategory, statusを比較する
    // それ以外が与えられたらfalse
    func isEqual<T>(compare: T) -> Bool {
        switch self {
        case .category(let category):
            if let compare = compare as? VegeCategory {
                return category == compare
            }
        case .status(let status):
            if let compare = compare as? VegeStatus {
                return status == compare
            }
        }
        return false
    }
}
