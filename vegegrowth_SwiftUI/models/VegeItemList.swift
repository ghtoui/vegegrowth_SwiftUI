//
//  VegeItemList.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/07.
//

import Foundation

struct VegeItemList {
    func getVegeList() -> [VegeItem] {
        return [
            VegeItem(name: "トマト", uuid: UUID().uuidString, category: VegeCategory.leaf, status: VegeStatus.default),
            VegeItem(name: "きゅうり", uuid: UUID().uuidString, category: VegeCategory.leaf, status: VegeStatus.default),
            VegeItem(name: "チューリップ", uuid: UUID().uuidString, category: VegeCategory.flower, status: VegeStatus.favorite),
            VegeItem(name: "茄子", uuid: UUID().uuidString, category: VegeCategory.leaf, status: VegeStatus.end),
            VegeItem(name: "パンジー", uuid: UUID().uuidString, category: VegeCategory.flower, status: VegeStatus.default),
            VegeItem(name: "かぼちゃ", uuid: UUID().uuidString, category: VegeCategory.leaf, status: VegeStatus.default),
            VegeItem(name: "ダリア", uuid: UUID().uuidString, category: VegeCategory.flower, status: VegeStatus.default),
        ]
    }
}
