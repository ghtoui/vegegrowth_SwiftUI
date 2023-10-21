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
}

class TakePictureViewModel: TakePictureViewModelType {
    @Published var inputText: String = ""
    
    @Published var isOpenRegisterDialog: Bool = false
    
    @Published var isCameraOpen: Bool = false
    
    @Published var takePictureImage: UIImage?
    
    @Published var isVisibleRegisterButton: Bool = false
    
    @Published var isRegisterable: Bool = false
    
    @Published var isFirstOpenRegisterDialog: Bool = true
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        bind()
    }
    
    func changeRegisterDialog() {
        if isOpenRegisterDialog {
            isOpenRegisterDialog = false
            resetDialogState()
        } else {
            isOpenRegisterDialog = true
        }
    }
    
    private func resetDialogState() {
        isVisibleRegisterButton = false
        isRegisterable = false
        isFirstOpenRegisterDialog = true
        inputText = ""
    }
    
    private func bind() {
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
                if (text != "" && self.isFirstOpenRegisterDialog) {
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
