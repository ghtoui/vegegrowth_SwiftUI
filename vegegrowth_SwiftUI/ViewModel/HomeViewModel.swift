//
//  HomeViewModel.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/09.
//

import Foundation

protocol HomeViewModelType: ObservableObject {
    var sortList: [VegeItem] { get }
    var isOpenAddDialog: Bool { get }
    var inputText: String { get set }
    var selectedCategory: VegeCategory { get }
    var selectedSortStatus: VegeSortStatus { get }
    var selectedMenuStatus: MenuStatus { get }
    
    func selectMenuStatus(selectMenuStatus: MenuStatus)
    func selectSortStatus(selectSortStatus: VegeSortStatus)
    func selectCategory(selectCategory: VegeCategory)
    func changeOpenAddDialog()
    func deleteVegeItem(item: VegeItem)
    func changeVegeStatus(item: VegeItem, status: VegeStatus)
    func addVegeItem()
    func cancelDialog()
}

extension HomeViewModelType {
    func checkInputText() -> Bool {
        return self.inputText != ""
    }
}

class HomeViewModel: HomeViewModelType {
    private var vegeList: [VegeItem]
    
    @Published var sortList: [VegeItem]
    
    @Published var isOpenAddDialog: Bool = false
    
    @Published var inputText: String = ""
    
    @Published var selectedCategory: VegeCategory = VegeCategory.none
    
    @Published var selectedSortStatus: VegeSortStatus = VegeSortStatus.category(.none)
    
    @Published var selectedMenuStatus: MenuStatus = MenuStatus.none
    
    init(vegeList: [VegeItem]) {
        self.vegeList = vegeList
        self.sortList = vegeList
    }
    
    func selectMenuStatus(selectMenuStatus: MenuStatus) {
        self.selectedMenuStatus = selectMenuStatus
    }
    
    func selectSortStatus(selectSortStatus: VegeSortStatus) {
        self.selectedSortStatus = selectSortStatus
        sortList(sortStatus: selectSortStatus)
    }
    
    func selectCategory(selectCategory: VegeCategory) {
        self.selectedCategory = selectCategory
    }
    
    func changeOpenAddDialog() {
        self.isOpenAddDialog = !self.isOpenAddDialog
    }
    
    func deleteVegeItem(item: VegeItem) {
        guard let index = getListIndex(item: item) else {
            return
        }
        vegeList.remove(at: index)
        sortList(sortStatus: selectedSortStatus)
    }
    
    func changeVegeStatus(item: VegeItem, status: VegeStatus) {
        guard let index = getListIndex(item: item) else {
            return
        }
        vegeList[index].status = status
        sortList(sortStatus: selectedSortStatus)
    }
    
    func addVegeItem() {
        let item = VegeItem(name: inputText,
                            uuid: UUID().uuidString,
                            category: selectedCategory,
                            status: .default
        )
        vegeList.append(item)
        isOpenAddDialog = false
        selectedCategory = .none
        inputText = L10n.noneText
        sortList(sortStatus: selectedSortStatus)
    }
    
    func cancelDialog() {
        isOpenAddDialog = false
        selectedCategory = .none
        inputText = L10n.noneText
    }
}

extension HomeViewModel {
    private func getListIndex(item: VegeItem) -> Int? {
        if let index = vegeList.firstIndex(where: { $0.uuid == item.uuid }) {
            return index
        }
        return nil
    }
    
    private func sortList(sortStatus: VegeSortStatus) {
        var sortList = vegeList.filter {
            sortStatus.isEqual(compare: $0.category) || sortStatus.isEqual(compare: $0.status)
        }
        if sortStatus == .category(.none) {
            sortList = vegeList
        }
        
        self.sortList = sortList
    }
}
