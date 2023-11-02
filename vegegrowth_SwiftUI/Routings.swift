//
//  Navigation.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/07.
//

import SwiftUI
import Foundation

// Viewを作るためのものの宣言
enum Rootings {
    case home(vegeList: [VegeItem])
    case takePic(vegeItem: VegeItem)
    case manage(vegeItem: VegeItem, vegeRepositoryList: [VegetableRepository])
}

extension Rootings {
    // ここで画面遷移用のViewを作る。
    func createView() -> some View {
        switch self {
        case .home(let vegeList):
            let view = HomeView(
                viewModel: HomeViewModel(vegeList: vegeList)
            )
            return AnyView(view)
            
        case .takePic(
            let vegeItem
        ):
            let view = TakePicView(
                vegeItem: vegeItem,
                viewModel: TakePictureViewModel(vegeItem: vegeItem)
            )
            return AnyView(view)
            
        case .manage(
            let vegeItem,
            let vegeRepositoryList
        ):
            let view = ManageView(
                viewModel: ManageViewModel(
                    vegeItem: vegeItem,
                    vegeRepositoryList: vegeRepositoryList
                )
            )
            return AnyView(view)
        }
    }
}
