//
//  ManageView.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/25.
//

import Foundation
import SwiftUI
import Charts

struct ManageView: View {
    let vegeItem: VegeItem
    let vegeRepositoryList: [VegetableRepository]
    
    var body: some View {
        VStack {
            PlotCharts(data: vegeRepositoryList)
            ImageCoroucel()
            MemoView()
        }
        .navigationBarTitle(vegeItem.name, displayMode: .inline)
    }
}

struct PlotCharts: View {
    @State var data: [VegetableRepository]
    var body: some View {
        Chart(data) { element in
            LineMark(
                x: .value("", element.date),
                y: .value("", element.size)
            )
        }
        .padding(.top, 16)
    }
}

// androidのようにPagerを使ったカルーセルは実装できなさそう
struct ImageCoroucel: View {
    let imageList = [
        Asset.Images.delete,
        Asset.Images.chevronRight,
        Asset.Images.done,
        Asset.Images.errorCircle,
        Asset.Images.flower,
        Asset.Images.photoCamera,
        Asset.Images.menu
    ]
    @State private var currentIndex = 0
    let itemPadding: CGFloat = 20
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { bodyView in
            HStack(spacing: itemPadding) {
                ForEach(Array(imageList.enumerated()), id: \.element.name) { index, image in
                    ZStack {
                        // paddingで真ん中に来るように調整
                        // ZStackの背景色を設定するだけでは、最初の背景がおかしくなる
                        Rectangle()
                            .foregroundColor(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            .padding(.leading, index == 0 ? bodyView.size.width * 0.1 : 0)
                        Image(asset: image)
                            .resizable()
                            .frame(width: bodyView.size.width * 0.8)
                            .scaledToFill()
                            .padding(.leading, index == 0 ? bodyView.size.width * 0.1 : 0)
                    }
                }
            }
            // ドラッグした分だけoffsetを移動
            .offset(x: self.dragOffset)
            // currentIndexに応じたoffsetへ移動する
            .offset(x: -CGFloat(self.currentIndex) * (bodyView.size.width * 0.8 + itemPadding))
            .gesture(
                DragGesture()
                    .updating(self.$dragOffset, body: { (value, state, _) in
                        // 移動幅のみ更新する
                        state = value.translation.width
                    })
                    .onEnded({ value in
                        var newIndex = self.currentIndex
                        // ドラッグ幅からページングを判定
                        let percent = 0.3
                        if abs(value.translation.width) > bodyView.size.width * percent {
                            newIndex = value.translation.width > 0 ? self.currentIndex - 1 : self.currentIndex + 1
                        }
                        
                        // 最小ページ・最大ページを超えないように
                        if newIndex < 0 {
                            newIndex = 0
                        } else if newIndex > (self.imageList.count - 1) {
                            newIndex = self.imageList.count - 1
                        }
                        self.currentIndex = newIndex
                    })
            )
            .animation(.linear, value: 150)
        }
    }
}

struct MemoView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
            Text("メモ")
        }
    }
}

struct ManagePreview: PreviewProvider {
    static var previews: some View {
        let vegeList: [VegeItem] = VegeItemList().getVegeList()
        let vegeItem = vegeList[0]
        let data = VegetableRepositoryList().getVegeRepositoryList()
        
        NavigationView {
            ManageView(vegeItem: vegeItem, vegeRepositoryList: data)
        }
    }
}
