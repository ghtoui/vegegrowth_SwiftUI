//
//  VegeGrowthDataManager.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/24.
//

import Foundation
import SwiftUI

class VegetableRepositoryFileManager {
    private let jsonParser: JsonParser = JsonParser()
    
    func loadVegeRepositoryList(vegeItem: VegeItem) -> [VegetableRepository] {
        guard let json = UserDefaults.standard.string(forKey: vegeItem.uuid) else {
            return []
        }
        
        let vegeRepositoryList: [VegetableRepository] = jsonParser.parseFromJson(json: json)
        return vegeRepositoryList
    }
    
    func saveVegeRepositoryList(vegeRepositoryList: [VegetableRepository], vegeItem: VegeItem) {
        let jsonData = jsonParser.parseToJson(item: vegeRepositoryList)
        UserDefaults.standard.set(jsonData, forKey: vegeItem.uuid)
    }
    
    func saveTakePicture(image: UIImage?, vegeRepository: VegetableRepository) -> Bool {
        guard let image = image else {
            return false
        }
        
        let jpegImageData = image.jpegData(compressionQuality: 0.5)
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(vegeRepository.uuid + L10n.jpegExtension)
        do {
            try jpegImageData!.write(to: fileURL)
        } catch {
            return false
        }
        return true
    }
}
