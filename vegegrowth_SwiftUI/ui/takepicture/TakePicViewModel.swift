//
//  TakePicViewModel.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/20.
//

import Foundation
import SwiftUI
import Combine

protocol TakePictureViewModelType: ObservableObject {
    var inputText: String { get set }
    var isOpenRegisterDialog: Bool { get }
    var isCameraOpen: Bool { get set }
    var takePictureImage: UIImage? { get set }
    var isVisibleRegisterButton: Bool { get }
    var isRegisterable: Bool { get }
    var isFirstOpenRegisterDialog: Bool { get }
    
    func changeRegisterDialog()
    func saveGrowthData()
}

class TakePictureViewModel: TakePictureViewModelType {
    @Published var inputText: String = L10n.noneText
    
    @Published var isOpenRegisterDialog: Bool = false
    
    @Published var isCameraOpen: Bool = false
    
    @Published var takePictureImage: UIImage?
    
    @Published var isVisibleRegisterButton: Bool = false
    
    @Published var isRegisterable: Bool = false
    
    @Published var isFirstOpenRegisterDialog: Bool = true
    
    private let vegeItem: VegeItem
    private var vegeRepositoryList: [VegetableRepository] = []
    
    private let vegeRepositoryFileManager = VegetableRepositoryFileManager()
    private let dateManager = DateManager()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(vegeItem: VegeItem) {
        self.vegeItem = vegeItem
        self.vegeRepositoryList = vegeRepositoryFileManager.loadVegeRepositoryList(vegeItem: vegeItem)
        
        bind()
    }
    
    func changeRegisterDialog() {
        isOpenRegisterDialog = !isOpenRegisterDialog
        resetDialogState()
    }
    
    func saveGrowthData() {
        guard let size = Double(inputText) else {
            return
        }
        let vegeRepository = VegetableRepository(
            name: vegeItem.name,
            uuid: UUID().uuidString,
            itemUuid: vegeItem.uuid,
            size: size,
            memo: L10n.noneText,
            date: dateManager.getDatetimeNow()
        )
        vegeRepositoryList.append(vegeRepository)
        
        let isSuccessSavePicture = vegeRepositoryFileManager.saveTakePicture(image: takePictureImage, vegeRepository: vegeRepository)
        if isSuccessSavePicture {
            vegeRepositoryFileManager.saveVegeRepositoryList(vegeRepositoryList: vegeRepositoryList, vegeItem: vegeItem)
        }
        changeRegisterDialog()
        takePictureImage = nil
    }
    
    private func resetDialogState() {
        isFirstOpenRegisterDialog = true
        inputText = L10n.noneText
    }
    
    private func bind() {
        // 写真の状態で登録ボタンの表示切り替え
        $takePictureImage.sink { image in
            if image == nil {
                self.isVisibleRegisterButton = false
            } else {
                self.isVisibleRegisterButton = true
            }
        }
        .store(in: &cancellables)
        
        $inputText
            .sink { text in
                if !text.isEmpty && self.isFirstOpenRegisterDialog {
                    self.isFirstOpenRegisterDialog = false
                }
            }
            .store(in: &cancellables)
        
        $inputText
            .removeDuplicates()
            .map { Double($0) != nil }
            .sink { bool in
                if !self.isFirstOpenRegisterDialog {
                    self.isRegisterable = bool
                }
            }
            .store(in: &cancellables)
    }
}
