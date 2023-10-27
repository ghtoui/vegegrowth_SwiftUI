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

struct ImageCoroucel: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
            Text("ここには画像表示用のカルーセル")
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
