//
//  ManageView.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/25.
//

import Foundation
import SwiftUI
import Charts

struct ManageView<ViewModel: ManageViewModelType>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 32) {
                PlotCharts(
                    sizeData: viewModel.sizeData,
                    dateData: viewModel.dateData,
                    currentIndex: $viewModel.currentIndex
                )
                    .padding(.horizontal, 16)
                ImageCoroucel(currentIndex: $viewModel.currentIndex)
                    .frame(height: geo.size.height * 0.35)
                MemoView(memo: $viewModel.memo)
                    .frame(height: geo.size.height * 0.2)
            }
            .navigationBarTitle(viewModel.title, displayMode: .inline)
        }
    }
}

struct PlotCharts: View {
    @State var sizeData: [Double]
    @State var dateData: [Date]
    @Binding var currentIndex: Int
    
    private let dateManager = DateManager()
    var body: some View {
        Chart(Array(zip(sizeData, dateData)), id: \.0) { size, date in
            LineMark(
                x: .value(L10n.noneText, date),
                y: .value(L10n.noneText, size)
            )
            PointMark(
                x: .value(L10n.noneText, dateData[currentIndex]),
                y: .value(L10n.noneText, sizeData[currentIndex])
            )
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
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
        Asset.Images.photoCamera
    ]
    @Binding var currentIndex: Int
    let itemPadding: CGFloat = 20
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        VStack {
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
                .offset(x: -CGFloat(currentIndex) * (bodyView.size.width * 0.8 + itemPadding))
                .gesture(
                    DragGesture()
                        .updating(self.$dragOffset, body: { (value, state, _) in
                            // 移動幅のみ更新する
                            state = value.translation.width
                        })
                        .onEnded({ value in
                            var newIndex = currentIndex
                            // ドラッグ幅からページングを判定
                            let percent = 0.3
                            if abs(value.translation.width) > bodyView.size.width * percent {
                                newIndex = value.translation.width > 0 ? self.currentIndex - 1 : self.currentIndex + 1
                            }
                            
                            // 最小ページ・最大ページを超えないように
                            if newIndex < 0 {
                                newIndex = 0
                            } else if newIndex > (imageList.count - 1) {
                                newIndex = imageList.count - 1
                            }
                            currentIndex = newIndex
                        })
                )
                .animation(.linear, value: 150)
            }
            bottomBar(currentIndex: currentIndex)
        }
    }
    
    private func bottomBar(currentIndex: Int) -> some View {
        return HStack(spacing: 0) {
            ForEach(0 ..< imageList.count, id: \.self) { index in
                Button(
                    action: { self.currentIndex = index },
                    label: {
                        Rectangle()
                            .foregroundColor(currentIndex == index ? .blue : .gray.opacity(0.4))
                    })
            }
            .frame(height: 4)
        }
        .padding(.horizontal, 32)
        .padding(.top, 8)
    }
}

struct MemoView: View {
    @Binding var memo: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .foregroundColor(.red)
            ScrollView {
                HStack {
                    Spacer()
                    Text(memo)
                        .padding(16)
                    Spacer()
                }
            }
        }
        .padding(16)
    }
}

struct ManagePreview: PreviewProvider {
    static var previews: some View {
        let vegeList: [VegeItem] = VegeItemList().getVegeList()
        let vegeItem = vegeList[0]
        let data = VegetableRepositoryList().getVegeRepositoryList()
        
        NavigationView {
            ManageView(
                viewModel: ManageViewModel(
                    vegeItem: vegeItem,
                    vegeRepositoryList: data
                )
            )
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
        .previewDisplayName("iPhone 14 Pro homeview")
        
        NavigationView {
            ManageView(
                viewModel: ManageViewModel(
                    vegeItem: vegeItem,
                    vegeRepositoryList: data
                )
            )
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        .previewDisplayName("iPhone SE homeview")
    }
}
