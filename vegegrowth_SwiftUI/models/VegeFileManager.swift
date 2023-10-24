//
//  FileManager.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/19.
//

import Foundation

class VegeFileManager {
    private let jsonParser = JsonParser()
    
    func saveVegeList(vegeList: [VegeItem]) {
        let jsonData = jsonParser.parseToJson(item: vegeList)
        UserDefaults.standard.set(jsonData, forKey: L10n.userDefaultVegeItemList)
    }
    
    func loadVegeList() -> [VegeItem] {
        guard let json = UserDefaults.standard.string(forKey: L10n.userDefaultVegeItemList) else {
            return []
        }
        
        let vegeList: [VegeItem] = jsonParser.parseFromJson(json: json)
        return vegeList
    }
}
