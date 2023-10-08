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
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(vegeList) { item in
                        VegeListElement(vegeItem: item)
                    }
                }
            }
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

struct AddAlertView: View {
    @Binding var selectedCategory: VegeCategory
    @Binding var name: String
    let onAddButtonClick: () -> Void
    let onCanselButtonClick: () -> Void
    
    var body: some View {
        VStack {
            Text(L10n.addDialogTitle)
                .font(.title)
                .lineLimit(2)
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
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.white)
            )
            
            HStack {
                Button(L10n.canselText, role: .cancel) { onCanselButtonClick() }
                    .foregroundColor(.blue)
                Button(L10n.addText, role: .destructive) {
                    onAddButtonClick()
                }
                .padding()
                .foregroundColor(.blue)
            }
        }
        .padding(24)
    }
}

struct VegeListElement: View {
    let vegeItem: VegeItem
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(asset: vegeItem.category.getIcon())!)
                .foregroundColor(vegeItem.category.getTint())
            Text(vegeItem.name)
            Image(uiImage: UIImage(asset: vegeItem.status.getIcon())!)
                .foregroundColor(vegeItem.status.getTint())
                .padding(.leading, 24)
            Spacer()
        }
        .frame(height: 40)
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
        
        AddAlertView(selectedCategory: $selectedCategory, name: $name, onAddButtonClick: { }, onCanselButtonClick: { })
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE")
        
        AddAlertView(selectedCategory: $selectedCategory, name: $name, onAddButtonClick: { }, onCanselButtonClick: { })
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
    }
}
