//
//  VegetableRepository.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/24.
//

import Foundation

struct VegetableRepository: Identifiable, Codable {
    var id = UUID()
    let name: String
    let uuid: String
    let itemUuid: String
    let size: Double
    var memo: String
    let date: String
    
    func diffDate(from: Date) -> Int {
        let dateManager = DateManager()
        guard let date = dateManager.transDateFromString(dateText: self.date) else {
            return -1
        }
        let time = Int(date.timeIntervalSince(from))
        return time / 24 / 60 / 60
    }
}
