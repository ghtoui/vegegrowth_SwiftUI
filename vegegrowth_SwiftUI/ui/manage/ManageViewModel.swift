//
//  ManageViewModel.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/29.
//

import Foundation
import Combine

protocol ManageViewModelType: ObservableObject {
    var currentIndex: Int { get set }
    var title: String { get }
    var memo: String { get set }
    var sizeData: [Double] { get }
    var dateData: [Date] { get }
    
    func setCurrentIndex(index: Int)
}

class ManageViewModel: ManageViewModelType {
    @Published var currentIndex: Int = 0
    @Published var title: String
    @Published var memo: String = ""
    @Published var sizeData: [Double] = []
    @Published var dateData: [Date] = []
    
    private let vegeItem: VegeItem
    private let vegeRepositoryList: [VegetableRepository]
    
    private let dateManager = DateManager()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(vegeItem: VegeItem, vegeRepositoryList: [VegetableRepository]) {
        self.vegeItem = vegeItem
        self.vegeRepositoryList = vegeRepositoryList
        title = vegeItem.name
        graphDataFilter()
        
        bind()
    }
    
    func setCurrentIndex(index: Int) {
        self.currentIndex = index
    }
    
    private func bind() {
        $currentIndex.sink { index in
            self.memo = self.vegeRepositoryList[index].memo
            self.graphDataFilter()
        }
        .store(in: &cancellables)
    }
    
    private func graphDataFilter() {
        sizeData = vegeRepositoryList.map {
            $0.size
        }
        dateData = vegeRepositoryList.map {
            dateManager.transDateFromString(dateText: $0.date)!
        }
    }
}
