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
            
        case .takePic(let vegeItem):
            let view = TakePicView(vegeItem: vegeItem)
            return AnyView(view)
        }
    }
}
