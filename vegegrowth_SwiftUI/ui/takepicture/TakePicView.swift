//
//  TakePicView.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/10.
//

import SwiftUI

struct TakePicView: View {
    let vegeItem: VegeItem
    var body: some View {
        Text(vegeItem.name)
    }
}

struct TakePicView_Previews: PreviewProvider {
    static var previews: some View {
        let vegeList: [VegeItem] = VegeItemList().getVegeList()
        TakePicView(vegeItem: vegeList[0])
    }
}
