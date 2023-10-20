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
        let isVisibleRegisterButton: Bool = true
        NavigationView {
            VStack(spacing: 30) {
                ZStack {
                    Rectangle()
                        .scaledToFit()
                        .padding(32)
                        .foregroundColor(.gray.opacity(0.4))
                    
                    Text(L10n.pictureNoneText)
                }
                
                TakePicButton(
                    onTakePictureClick: { }
                )
                
                if isVisibleRegisterButton {
                    RegisterDataButton(
                        onRegisterClick: { }
                    )
                }
            }
            .navigationBarTitle(vegeItem.name, displayMode: .inline)
        }
    }
}

struct TakePicButton: View {
    let onTakePictureClick: () -> Void
    
    var body: some View {
        Button(
            action: { onTakePictureClick() }) {
                HStack {
                    Image(asset: Asset.Images.photoCamera)
                    Text(L10n.takePhotoButtonText)
                }
            }
            .frame(width: 130, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.blue))
    }
}

struct RegisterDataButton: View {
    let onRegisterClick: () -> Void
    
    var body: some View {
        Button(
            action: { onRegisterClick() }) {
                HStack {
                    Image(asset: Asset.Images.registerData)
                    Text(L10n.takePhotoButtonText)
                }
            }
            .frame(width: 130, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.blue))
    }
}
struct TakePicView_Previews: PreviewProvider {
    static var previews: some View {
        let vegeList: [VegeItem] = VegeItemList().getVegeList()
        TakePicView(
            vegeItem: vegeList[0]
        )
    }
}
