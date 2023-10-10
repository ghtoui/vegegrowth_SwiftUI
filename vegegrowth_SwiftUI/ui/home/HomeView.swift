//  TableScreenView.swift
//
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/07.
//

import SwiftUI

// ジェネリックスを使ってinterfaceのViewModelを指定する
struct HomeView<ViewModel: HomeViewModelType>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    Section {
                        ForEach(viewModel.sortList) { item in
                            VegeListElement(
                                vegeItem: item,
                                selectedMenuStatus: viewModel.selectedMenuStatus,
                                onDeleteButtonClick: { item in
                                    viewModel.deleteVegeItem(item: item)
                                },
                                onEditButtonClick: { (item, status) in
                                    viewModel.changeVegeStatus(item: item, status: status)
                                }
                            )
                            Rectangle()
                                .foregroundColor(.gray.opacity(0.5))
                                .frame(height: 0.5, alignment: .bottom)
                        }
                        .onDelete(perform: nil)
                    } header: { HomeListHeader(
                        onMenuIconClick: { viewModel.selectMenuStatus(selectMenuStatus: $0) },
                        onDoneButtonClick: { viewModel.selectMenuStatus(selectMenuStatus: .none) },
                        selectedSortStatus: viewModel.selectedSortStatus,
                        selectedMenuStatus: viewModel.selectedMenuStatus,
                        onSortMenuButtonClick: { viewModel.selectSortStatus(selectSortStatus: $0) }
                    )}
                    .padding(.horizontal, 24)
                }
                .listStyle(.plain)
                .navigationBarTitle(L10n.homeNavigationTitle, displayMode: .inline)
                .navigationBarItems(trailing: Button(
                    action: { viewModel.changeOpenAddDialog() },
                    label: { Text(L10n.addText) })
                )
                .customDialog(isOpen: viewModel.isOpenAddDialog) {
                    AddAlertDialog(
                        selectedCategory: viewModel.selectedCategory,
                        inputText: $viewModel.inputText,
                        onAddButtonClick: { viewModel.addVegeItem() },
                        onCanselButtonClick: { viewModel.cancelDialog() },
                        onCategoryMenuClick: { viewModel.selectCategory(selectCategory: $0) }
                    )
                }
            }
        }
    }
}

struct HomeListHeader: View {
    let onMenuIconClick: (MenuStatus) -> Void
    let onDoneButtonClick: () -> Void
    let selectedSortStatus: VegeSortStatus
    let selectedMenuStatus: MenuStatus
    let onSortMenuButtonClick: (VegeSortStatus) -> Void
    
    var body: some View {
        HStack {
            Menu {
                ForEach(VegeSortStatus.allCases, id: \.self) { sortStatus in
                    Button(
                        action: { onSortMenuButtonClick(sortStatus) },
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

struct AddAlertDialog: View {
    let selectedCategory: VegeCategory
    @Binding var inputText: String
    let onAddButtonClick: () -> Void
    let onCanselButtonClick: () -> Void
    let onCategoryMenuClick: (VegeCategory) -> Void
    
    var body: some View {
        VStack {
            Text(L10n.addDialogTitle)
                .lineLimit(2)
                .font(.title)
                .minimumScaleFactor(0.5)
            TextField(L10n.noneText, text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 30)
            
            Menu {
                ForEach(VegeCategory.allCases, id: \.self) { category in
                    if category != .none {
                        Button(
                            action: { onCategoryMenuClick(category) },
                            label: {
                                HStack {
                                    Image(asset: category.getIcon())
                                    Text("\(category.rawValue)")
                                }
                            })
                    }
                }
            } label: {
                if selectedCategory == .none {
                    Text(selectedCategory.rawValue)
                } else {
                    HStack {
                        Text(selectedCategory.rawValue)
                        Image(asset: selectedCategory.getIcon())
                            .foregroundColor(selectedCategory.getTint())
                    }
                }
            }
            .menuOrder(.fixed)
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
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            if selectedMenuStatus == .none {
                let takePic = Rootings.takePic(vegeItem: vegeItem)
                NavigationLink(
                    destination: { takePic.createView() },
                    label: { Rectangle().foregroundColor(.clear) }
                )
            }
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
}

// これがPreview
struct HomeViewPreviews: PreviewProvider {
    @State static var vegeList: [VegeItem] = VegeItemList().getVegeList()
    @State static var isOpenAddDialog: Bool = false
    @State static var name: String = ""
    @State static var selectedCategory: VegeCategory = VegeCategory.none
    
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(vegeList: VegeItemList().getVegeList()))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE homeview")
        
        HomeView(viewModel: HomeViewModel(vegeList: VegeItemList().getVegeList()))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro homeview")
    }
}
