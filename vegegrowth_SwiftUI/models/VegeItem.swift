//
//  VegeItem.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/07.
//

import Foundation

struct VegeItem: Identifiable {
    var id = UUID()
    let name: String
    let uuid: String
    let category: VegeCategory
    var status: VegeStatus
}
