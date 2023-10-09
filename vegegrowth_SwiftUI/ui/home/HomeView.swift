//  TableScreenView.swift
//
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/07.
//

import SwiftUI

struct HomeView: View {
    @State var vegeList: [VegeItem]
    @State var isOpenAddDialog: Bool = false
    @State var name: String = ""
    @State var selectedCategory: VegeCategory = VegeCategory.none
    @State var selectedSortStatus: VegeSortStatus = VegeSortStatus.category(.none)
    @State var selectedMenuStatus: MenuStatus = MenuStatus.none
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(vegeList) { item in
                        VegeListElement(
                            vegeItem: item,
                            selectedMenuStatus: selectedMenuStatus,
                            onDeleteButtonClick: { item in
                                if let index = vegeList.firstIndex(where: { $0.uuid == item.uuid }) {
                                    vegeList.remove(at: index)
                                }
                            },
                            onEditButtonClick: { (item, status) in
                                if let index = vegeList.firstIndex(where: { $0.uuid == item.uuid }) {
                                    vegeList[index].status = status
                                }
                            }
                        )
                    }
                    .onDelete(perform: nil)
                } header: { HomeListHeader(
                    onMenuIconClick: { selectedMenuStatus = $0 },
                    onDoneButtonClick: { selectedMenuStatus = .none },
                    selectedSortStatus: $selectedSortStatus,
                    selectedMenuStatus: $selectedMenuStatus
                )}
            }
            .listStyle(.plain)
            .navigationBarTitle(L10n.homeNavigationTitle, displayMode: .inline)
            .navigationBarItems(trailing: Button(action: { isOpenAddDialog = true }, label: { Text(L10n.addText) }))
            .customDialog(isOpen: $isOpenAddDialog) {
                AddAlertView(
                    selectedCategory: $selectedCategory,
                    name: $name,
                    onAddButtonClick: {
                        let item = VegeItem(name: name, uuid: UUID().uuidString, category: selectedCategory, status: VegeStatus.default)
                        print(item)
                        vegeList.append(item)
                        isOpenAddDialog = false
                        selectedCategory = .none
                        name = L10n.noneText
                    },
                    onCanselButtonClick: {
                        isOpenAddDialog = false
                        selectedCategory = .none
                        name = L10n.noneText
                    }
                )
            }
        }
    }
}

struct HomeListHeader: View {
    let onMenuIconClick: (MenuStatus) -> Void
    let onDoneButtonClick: () -> Void
    @Binding var selectedSortStatus: VegeSortStatus
    @Binding var selectedMenuStatus: MenuStatus
    
    var body: some View {
        HStack {
            Menu {
                ForEach(VegeSortStatus.allCases, id: \.self) { sortStatus in
                    Button(
                        action: { selectedSortStatus = sortStatus },
                        label: {
                            HStack {
                                if selectedSortStatus == sortStatus {
                                    Image(asset: Asset.Images.done)
                                        .accentColor(.red)
                                }
                                if sortStatus == .category(VegeCategory.none) {
                                    Text(L10n.allText)
                                } else {
                                    Text(sortStatus.rawValue)
                                }
                            }
                        })
                }
            } label: {
                Image(asset: Asset.Images.sort)
            }
            .menuOrder(.fixed)
            Spacer()
            if selectedMenuStatus != .none {
                Button(
                    action: { onDoneButtonClick() },
                    label: {
                        Text(L10n.doneText)
                    }
                )
            } else {
                Menu {
                    ForEach(MenuStatus.allCases, id: \.self) { menu in
                        if menu == .delete {
                            Button(
                                role: .destructive,
                                action: { onMenuIconClick(menu) },
                                label: {
                                    HStack {
                                        Image(asset: menu.getIcon())
                                        Text(menu.rawValue)
                                    }
                                })
                        } else if menu != .none {
                            Button(
                                action: { onMenuIconClick(menu) },
                                label: {
                                    HStack {
                                        Image(asset: menu.getIcon())
                                        Text(menu.rawValue)
                                    }
                                }
                            )
                        }
                    }
                } label: {
                    Image(asset: Asset.Images.menu)
                }
                .menuOrder(.fixed)
            }
        }
        .padding(.vertical, 16)
    }
}

struct AddAlertView: View {
    @Binding var selectedCategory: VegeCategory
    @Binding var name: String
    let onAddButtonClick: () -> Void
    let onCanselButtonClick: () -> Void
    
    var body: some View {
        VStack {
            Text(L10n.addDialogTitle)
                .lineLimit(2)
                .font(.title)
                .minimumScaleFactor(0.5)
            TextField(L10n.noneText, text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 30)
            
            Picker(
                selection: $selectedCategory,
                label: Text(selectedCategory.rawValue)
            ) {
                ForEach(VegeCategory.allCases, id: \.self) { category in
                    Text("\(category.rawValue)")
                }
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            }
            .pickerStyle(.menu)
            .padding(.top, 4)
            
            HStack {
                Button(L10n.canselText, role: .cancel) { onCanselButtonClick() }
                    .frame(width: 100, height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    )
                    .padding(.trailing, 4)
                Button(L10n.addText, role: .none) { onAddButtonClick() }
                    .padding()
                    .frame(width: 100, height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    )
            }
            .padding(.top, 40)
        }
        .padding(24)
    }
}

struct VegeListElement: View {
    let vegeItem: VegeItem
    let selectedMenuStatus: MenuStatus
    let onDeleteButtonClick: (VegeItem) -> Void
    let onEditButtonClick: (VegeItem, VegeStatus) -> Void
    @State var isDelete = false
    @State var isSelectedVegeStatus: VegeStatus = VegeStatus.default
    
    var body: some View {
        HStack {
            if selectedMenuStatus == .delete {
                Button(
                    action: { isDelete = !isDelete },
                    label: { Image(asset: Asset.Images.chevronRight)
                            .foregroundColor(.red)
                    })
            }
            Image(asset: vegeItem.category.getIcon())
                .foregroundColor(vegeItem.category.getTint())
            Text(vegeItem.name)
            Image(asset: vegeItem.status.getIcon())
                .foregroundColor(vegeItem.status.getTint())
                .padding(.leading, 24)
            Spacer()
            if isDelete {
                Button(
                    action: { onDeleteButtonClick(vegeItem) },
                    label: {
                        Image(asset: Asset.Images.delete)
                            .foregroundColor(.red)
                    }
                )
            }
            if selectedMenuStatus == .edit {
                Menu {
                    ForEach(VegeStatus.allCases, id: \.self) { status in
                        Button(
                            action: {
                                onEditButtonClick(vegeItem, status)
                                isSelectedVegeStatus = status
                            },
                            label: {
                                HStack {
                                    Image(asset: status.getIcon())
                                    Text(status.rawValue)
                                }
                            }
                        )
                    }
                } label: {
                    Image(asset: Asset.Images.edit)
                }
                .menuOrder(.fixed)
            }
        }
        .frame(height: 40)
        // 値の変更を検知させる
        .onChange(of: selectedMenuStatus) { menuStatus in
            if menuStatus != .delete {
                isDelete = false
            }
        }
    }
}

// これがPreview
struct HomeViewPreviews: PreviewProvider {
    @State static var vegeList: [VegeItem] = VegeItemList().getVegeList()
    @State static var isOpenAddDialog: Bool = false
    @State static var name: String = ""
    @State static var selectedCategory: VegeCategory = VegeCategory.none
    
    static var previews: some View {
        HomeView(
            vegeList: VegeItemList().getVegeList()
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        .previewDisplayName("iPhone SE homeview")
        
        HomeView(
            vegeList: VegeItemList().getVegeList()
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
        .previewDisplayName("iPhone 14 Pro homeview")
    }
}
