//
//  TableScreenView.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/07.
//

import SwiftUI

struct TableScreenView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Button(action: {}, label: {
                Text("Swift Button")
            })
            Rectangle()
                .stroke(lineWidth: 4)
                .foregroundColor(Color.red)
                .frame(width: 100, height: 100)
            ZStack(alignment: .bottom) {
                Circle()
                    .stroke(lineWidth: 4)
                    .fill(Color.blue)
                    .frame(width: 100, height: 100)
                Text("円")
            }
        }
    }
}

// これがPreview
struct TableScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TableScreenView()
    }
}
