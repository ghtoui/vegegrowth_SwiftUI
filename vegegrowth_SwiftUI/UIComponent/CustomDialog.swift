//
//  CustomDialg.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/08.
//

import Foundation
import SwiftUI

// CustomDialogを作成するものを作成する

struct CustomDialog<DialogContent: View>: ViewModifier {
    let isOpen: Bool
    let dialogContent: DialogContent
    
    init(
        isOpen: Bool,
        @ViewBuilder dialogContent: () -> DialogContent
    ) {
        self.isOpen = isOpen
        self.dialogContent = dialogContent()
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isOpen {
                // 後ろを黒の半透明にしてダイアログの強調
                // edgesIgnoringSafeAreaで、全て覆えるようにしている
                Rectangle()
                    .foregroundColor(.black.opacity(0.3))
                    .edgesIgnoringSafeArea(.all)
                // ダイアログのコンテンツ表示
                ZStack {
                    dialogContent
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.white)
                        )
                }.padding(40)
            }
        }
    }
}

// Viewを拡張して使いやすく
extension View {
    func customDialog<DialogContent: View>(
        isOpen: Bool,
        @ViewBuilder dialogContent: @escaping () -> DialogContent
    ) -> some View {
        self.modifier(CustomDialog(isOpen: isOpen, dialogContent: dialogContent))
    }
}
