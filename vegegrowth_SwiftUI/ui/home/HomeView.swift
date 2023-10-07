//
//  TableScreenView.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/07.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        let vegeList = VegeItemList().getVegeList()
        List {
            ForEach(vegeList) { list in
                /*@START_MENU_TOKEN@*/Text(list.name)/*@END_MENU_TOKEN@*/
            }
        }
    }
}

// これがPreview
struct HomeViewPreviews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
